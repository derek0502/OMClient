//
//  OMCLoadingView.m
//  OMClient
//
//  Created by Derek Cheung on 11/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCLoadingView.h"

@interface OMCLoadingView ()

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation OMCLoadingView

#pragma mark - Setup

- (void)setup
{
    [super setup];
    
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self setupIndicatorView];
}

- (void)setupIndicatorView
{
    _indicatorView = [[UIActivityIndicatorView alloc] init];
    
    [_indicatorView startAnimating];
    
    [self addSubview:_indicatorView];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
    [super setupConstraints];
    
    [self setupIndicatorViewConstraints];
}

- (void)setupIndicatorViewConstraints
{
    _indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_indicatorView addCenterXConstraintToView:self];
    [_indicatorView addCenterYConstraintToView:self];
}

@end
