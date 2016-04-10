//
//  OMCAPIManager.h
//  OMClient
//
//  Created by Derek Cheung on 7/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>

// Model
#import "OMCAPIModel.h"
#import "OMCSearchModel.h"
#import "OMCMovieDetailModel.h"

typedef void (^BaseTaskSuccessBlock)(NSData *data, OMCAPIModel *dataModel);
typedef void (^BaseTaskFailureBlock)(NSData *data, NSError *error, OMCAPIModel *dataModel);

typedef void (^TitleSearchSuccessBlock)(NSData *data, OMCSearchModel *dataModel);

typedef void (^MovieDetailSuccessBlock)(NSData *data, OMCMovieDetailModel *dataModel);

typedef void (^DownloadImageSuccessBlock)(NSData *imageData);
typedef void (^DownloadImageFailureBlock)(NSData *data, NSError *error);

@interface OMCAPIManager : NSObject

#pragma mark - General

+ (NSURLSessionTask *)taskWithUrl:(NSURL *)url
						  success:(BaseTaskSuccessBlock)success
						  failure:(BaseTaskFailureBlock)failure;

#pragma mark - Search by title

+ (NSURLSessionTask *)searchWithTitle:(NSString *)title
								 page:(NSInteger)page
							  success:(TitleSearchSuccessBlock)success
							  failure:(BaseTaskFailureBlock)failure;

#pragma mark - Movie detail by ID

+ (NSURLSessionTask *)searchDetailWithId:(NSString *)imdbID
							  success:(MovieDetailSuccessBlock)success
							  failure:(BaseTaskFailureBlock)failure;

#pragma mark - Download image by URL

+ (NSURLSessionTask *)downloadImageWithUrl:(NSString *)url
                                   success:(DownloadImageSuccessBlock)success
                                   failure:(DownloadImageFailureBlock)failure;

@end
