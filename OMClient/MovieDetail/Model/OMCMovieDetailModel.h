//
//  OMCMovieDetailModel.h
//  OMClient
//
//  Created by Derek Cheung on 8/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCAPIModel.h"

@interface OMCMovieDetailModel : OMCAPIModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, strong) NSString *rated;
@property (nonatomic, strong) NSString *released;
@property (nonatomic, strong) NSString *runtime;
@property (nonatomic, strong) NSString *genre;
@property (nonatomic, strong) NSString *director;
@property (nonatomic, strong) NSString *writer;
@property (nonatomic, strong) NSString *actors;
@property (nonatomic, strong) NSString *plot;
@property (nonatomic, strong) NSString *language;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *awards;
@property (nonatomic, strong) NSString *poster;
@property (nonatomic, assign) NSInteger metascore;
@property (nonatomic, assign) float imdbRating;
@property (nonatomic, assign) NSInteger imdbVotes;
@property (nonatomic, strong) NSString *imdbID;

@end
