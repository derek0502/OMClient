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

typedef void (^BaseTaskSuccessBlock)(NSData *data, OMCAPIModel *dataModel);
typedef void (^BaseTaskFailureBlock)(NSData *data, NSError *error, OMCAPIModel *dataModel);

@interface OMCAPIManager : NSObject

+ (NSURLSessionTask *)taskWithURL:(NSString *)urlString
                          success:(BaseTaskSuccessBlock)success
                          failure:(BaseTaskFailureBlock)failure;

@end
