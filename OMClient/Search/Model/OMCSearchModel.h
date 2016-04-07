//
//  OMCSearchModel.h
//  OMClient
//
//  Created by Derek Cheung on 7/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCAPIModel.h"

// Model
#import "OMCMovie.h"

@interface OMCSearchModel : OMCAPIModel

@property (nonatomic, assign) NSInteger totalResults;
@property (nonatomic, strong) NSArray<OMCMovie> *movies;

@end
