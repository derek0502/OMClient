//
//  OMCAPIModel.m
//  OMClient
//
//  Created by Derek Cheung on 7/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCAPIModel.h"

@implementation OMCAPIModel

#pragma mark - Override

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Response" : @"response",
                                                       @"Error" : @"errorMessage"
                                                       }];
}

@end
