//
//  OMCMovieModel.h
//  OMClient
//
//  Created by Derek Cheung on 7/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseModel.h"

@protocol OMCMovieModel
@end

@interface OMCMovieModel : OMCBaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, strong) NSString *imdbID;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *poster;

@end
