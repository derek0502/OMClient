//
//  OMCSearchMovieHeaderView.h
//  OMClient
//
//  Created by Derek Cheung on 12/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseView.h"

typedef NS_ENUM(NSInteger, OMCSearchMovieHeaderViewStatus) {
    
    OMCSearchMovieHeaderViewStatusStartNewSearch,
    OMCSearchMovieHeaderViewStatusTooManyResults,
    OMCSearchMovieHeaderViewStatusSearching,
    OMCSearchMovieHeaderViewStatusNoResult,
    OMCSearchMovieHeaderViewStatusNormal
};

@interface OMCSearchMovieHeaderView : OMCBaseView

@property (nonatomic, assign) OMCSearchMovieHeaderViewStatus status;

@end
