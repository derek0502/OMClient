//
//  OMCAPIManager.m
//  OMClient
//
//  Created by Derek Cheung on 7/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCAPIManager.h"

// Constants
static NSString *kAPIEndpoint = @"http://www.omdbapi.com/";

@implementation OMCAPIManager

#pragma mark - General

+ (NSURLSessionTask *)taskWithUrl:(NSURL *)url
						  success:(BaseTaskSuccessBlock)success
						  failure:(BaseTaskFailureBlock)failure
{
	NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
														 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
							  {
								  if (error) {  // Network level error

									  if (failure) {

										  failure(data, error, nil);
									  }

								  } else {

									  if (!data) {  // No Data error

										  if (failure) {

											  failure(data, error, nil);
										  }

									  } else {

										  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
																							   options:NSJSONReadingAllowFragments
																								 error:&error];

										  if (error) {  // Data parsing error

											  if (failure) {

												  failure(data, error, nil);
											  }

										  } else {

											  OMCAPIModel *model = [[OMCAPIModel alloc] initWithDictionary:dict
																									 error:&error];

											  if (error) {  // Model parsing error

												  if (failure) {

													  failure(data, error, nil);
												  }

											  } else {

												  if (model.response == NO || [model.errorMessage length]) { // API level error

													  if (failure) {

														  failure(data, error, model);
													  }

												  } else {

													  if (success) {

														  success(data, model);
													  }
												  }
											  }
										  }
									  }
								  }
							  }];
	[task resume];

	return task;
}

#pragma mark - Search by title

+ (NSURLSessionTask *)searchWithTitle:(NSString *)title
								 page:(NSInteger)page
							  success:(TitleSearchSuccessBlock)success
							  failure:(BaseTaskFailureBlock)failure
{
	NSURLComponents *components = [NSURLComponents componentsWithString:kAPIEndpoint];
	NSURLQueryItem *searchItem = [NSURLQueryItem queryItemWithName:@"s" value:title];
	NSURLQueryItem *pageItem = [NSURLQueryItem queryItemWithName:@"page" value:@(page).stringValue];
	components.queryItems = @[searchItem, pageItem];

	return [OMCAPIManager taskWithUrl:components.URL
							  success:^(NSData *data, OMCAPIModel *dataModel)
			{

				if (success) {

					OMCSearchModel *model = [[OMCSearchModel alloc] initWithData:data error:nil];
					success(data, model);
				}
			}
							  failure:failure];
}

@end
