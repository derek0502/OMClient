//
//  OMCMovieModel.m
//  OMClient
//
//  Created by Derek Cheung on 7/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCMovieModel.h"

@implementation OMCMovieModel

#pragma mark - Override

+ (JSONKeyMapper *)keyMapper
{
	return [[JSONKeyMapper alloc] initWithDictionary:@{
													   @"Title" : @"title",
													   @"Year" : @"year",
													   @"Type" : @"type",
													   @"Poster" : @"poster"
													   }];
}

@end
