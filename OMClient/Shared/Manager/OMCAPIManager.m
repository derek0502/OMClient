//
//  OMCAPIManager.m
//  OMClient
//
//  Created by Derek Cheung on 7/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCAPIManager.h"

#import "OMCSearchModel.h"

@implementation OMCAPIManager

+ (NSURLSessionTask *)taskWithURL:(NSString *)urlString
                          success:(BaseTaskSuccessBlock)success
                          failure:(BaseTaskFailureBlock)failure
{
    NSURL *url = [NSURL URLWithString:urlString];
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

@end
