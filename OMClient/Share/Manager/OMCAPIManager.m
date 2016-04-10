
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

									  if (!data || [data length] == 0) {  // No Data error

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

#pragma mark - Movie detail by ID

+ (NSURLSessionTask *)searchDetailWithId:(NSString *)imdbID
							  success:(MovieDetailSuccessBlock)success
							  failure:(BaseTaskFailureBlock)failure
{
	NSURLComponents *components = [NSURLComponents componentsWithString:kAPIEndpoint];
	NSURLQueryItem *searchItem = [NSURLQueryItem queryItemWithName:@"i" value:imdbID];
	components.queryItems = @[searchItem];
	
	return [OMCAPIManager taskWithUrl:components.URL
							  success:^(NSData *data, OMCAPIModel *dataModel)
			{
				if (success) {
					
					OMCMovieDetailModel *model = [[OMCMovieDetailModel alloc] initWithData:data error:nil];
					success(data, model);
				}
			}
							  failure:failure];
	
}

#pragma mark - Download image by URL

+ (NSURLSessionDownloadTask *)downloadImageWithUrl:(NSString *)url
										   success:(DownloadImageSuccessBlock)success
										   failure:(DownloadImageFailureBlock)failure
{
	NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:url]
																	 completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
									  {
										  if (error) {    // Network level error

											  if (failure) {

												  failure(nil, error);
											  }

                                          } else {

                                              NSData *imageData = [NSData dataWithContentsOfURL:location];

                                              if (!imageData || [imageData length] == 0) {   // data level error
                                                  
                                                  if (failure) {
                                                      
                                                      failure(imageData, error);
                                                  }
                                                  
                                              } else {
                                                  
                                                  if (success) {
                                                      
                                                      success(imageData);
                                                  }
                                              }
                                          }
                                      }];
    
    [task resume];
    
    return task;
}


@end
