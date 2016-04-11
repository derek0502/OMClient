//
//  OMCMovieDetailView.m
//  OMClient
//
//  Created by Derek Cheung on 11/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCMovieDetailView.h"

// View
#import "OMCNavigationView.h"

@interface OMCMovieDetailView ()

@property (nonatomic, strong) OMCNavigationView *navigationView;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation OMCMovieDetailView

#pragma mark - Setup

- (void)setup
{
    [super setup];
    
    [self setupNavigationView];
    [self setupBackButton];
}

- (void)setupNavigationView
{
    _navigationView = [OMCNavigationView new];
    
    [self addSubview:_navigationView];
}

- (void)setupBackButton
{
    _backButton = [UIButton new];
    
    UIImage *image = [UIImage imageNamed:@"back"];
    [_backButton setImage:image forState:UIControlStateNormal];
    
    [_navigationView.contentView addSubview:_backButton];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
    [super setupConstraints];
    
    [self setupNavigationViewConstraints];
    [self setupBackButtonConstraints];
}

- (void)setupNavigationViewConstraints
{
    _navigationView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_navigationView addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_navigationView addRightConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_navigationView addTopConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
}

- (void)setupBackButtonConstraints
{
    _backButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_backButton addLeftConstraintToView:_backButton.superview relation:NSLayoutRelationEqual constant:kNormalHorizontalMargin];
    [_backButton addCenterYConstraintToView:_backButton.superview];
}

@end
