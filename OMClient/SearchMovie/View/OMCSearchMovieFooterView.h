//
//  OMCSearchMovieFooterView.h
//  OMClient
//
//  Created by Derek Cheung on 12/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseView.h"

typedef NS_ENUM(NSInteger, OMCSearchMovieFooterViewStatus) {
    
    OMCSearchMovieFooterViewStatusLoading,
    OMCSearchMovieFooterViewStatusNormal
};

@class OMCSearchMovieFooterView;

@protocol OMCSearchMovieFooterViewDelegate <NSObject>

@optional

- (void)viewDidTap:(OMCSearchMovieFooterView *)view;

@end

@interface OMCSearchMovieFooterView : OMCBaseView

@property (nonatomic, assign) OMCSearchMovieFooterViewStatus status;
@property (nonatomic, weak) id<OMCSearchMovieFooterViewDelegate> delegate;

@end
