//
//  OMCSearchModel.m
//  OMClient
//
//  Created by Derek Cheung on 7/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCSearchModel.h"

@implementation OMCSearchModel

#pragma mark - Override

+ (JSONKeyMapper *)keyMapper
{
	return [JSONKeyMapper mapper:[super keyMapper] withExceptions:@{
																	@"Search" : @"movies"
																	}];
}

@end
