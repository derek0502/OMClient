//
//  OMCLoadingView.m
//  OMClient
//
//  Created by Derek Cheung on 11/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCLoadingView.h"

@interface OMCLoadingView ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation OMCLoadingView

#pragma mark - Setup

- (void)setup
{
    [super setup];
    
    [self setupBackgroundView];
    [self setupIndicatorView];
}

- (void)setupBackgroundView
{
    _backgroundView = [[UIView alloc]init];
    [_backgroundView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
    
    [self addSubview:_backgroundView];
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
    
    [self setupBackgroundViewConstraints];
    [self setupIndicatorViewConstraints];
}

- (void)setupBackgroundViewConstraints
{
    _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_backgroundView fillSuperView:UIEdgeInsetsZero];
}

- (void)setupIndicatorViewConstraints
{
    _indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_indicatorView addCenterXConstraintToView:self];
    [_indicatorView addCenterYConstraintToView:self];
}

@end
