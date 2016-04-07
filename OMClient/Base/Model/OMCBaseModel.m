//
//  OMCBaseModel.m
//  OMClient
//
//  Created by Derek Cheung on 7/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseModel.h"

@implementation OMCBaseModel

#pragma mark - Override

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end
