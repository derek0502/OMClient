//
//  OMCMovieDetailModel.m
//  OMClient
//
//  Created by Derek Cheung on 8/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCMovieDetailModel.h"

@implementation OMCMovieDetailModel

#pragma mark - Override

+ (JSONKeyMapper *)keyMapper
{
	return [[JSONKeyMapper alloc] initWithDictionary:@{
													   @"Title" : @"title",
													   @"Year" : @"year",
													   @"Rated" : @"rated",
													   @"Released" : @"released",
													   @"Runtime" : @"runtime",
													   @"Genre" : @"genre",
													   @"Director" : @"director",
													   @"Writer" : @"writer",
													   @"Actors" : @"actors",
													   @"Plot" : @"plot",
													   @"Language" : @"language",
													   @"Country" : @"country",
													   @"Awards" : @"awards",
													   @"Poster" : @"poster",
													   @"Metascore" : @"metascore"
													   }];
}

@end
