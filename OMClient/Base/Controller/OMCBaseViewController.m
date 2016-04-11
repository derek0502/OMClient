//
//  OMCBaseViewController.m
//  OMClient
//
//  Created by Derek Cheung on 10/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseViewController.h"

// View
#import "OMCLoadingView.h"

@interface OMCBaseViewController ()

@property (nonatomic, strong) OMCLoadingView *loadingView;

@end

@implementation OMCBaseViewController

#pragma mark - Loading

- (void)startLoadingAnimation
{
    if (!_loadingView) {
        
        _loadingView = [OMCLoadingView new];
        _loadingView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:_loadingView];
        [_loadingView fillSuperView:UIEdgeInsetsZero];
    }
}

- (void)stopLoadingAnimation
{
    if(_loadingView) {
        
        [_loadingView removeFromSuperview];
        _loadingView = nil;
    }
}

@end
