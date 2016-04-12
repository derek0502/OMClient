//
//  OMCMovieDetailView.h
//  OMClient
//
//  Created by Derek Cheung on 11/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseView.h"

// Model
#import "OMCMovieDetailModel.h"

@interface OMCMovieDetailView : OMCBaseView

@property (nonatomic, strong, readonly) UIButton *backButton;
@property (nonatomic, strong, readonly) UIButton *shareButton;
@property (nonatomic, strong, readonly) UIButton *likeButton;
@property (nonatomic, strong) OMCMovieDetailModel *dataSource;

- (void)updateContentSize;

@end
