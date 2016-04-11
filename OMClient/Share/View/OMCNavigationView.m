//
//  OMCNavigationView.m
//  OMClient
//
//  Created by Derek Cheung on 11/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCNavigationView.h"

@interface OMCNavigationView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *separatorView;

@end

@implementation OMCNavigationView

#pragma mark - Setup

- (void)setup
{
    [super setup];
    
    [self setupContentView];
    [self setupSeparatorView];
}

- (void)setupContentView
{
    _contentView = [UIView new];
    
    [self addSubview:_contentView];
}

- (void)setupSeparatorView
{
    _separatorView = [UIView new];
    
    _separatorView.backgroundColor = [UIColor redColor];
    
    [self addSubview:_separatorView];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
    [super setupConstraints];
    
    [self setupContentViewConstraints];
    [self setupSeparatorViewConstraints];
}

- (void)setupContentViewConstraints
{
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_contentView addTopConstraintToView:self relation:NSLayoutRelationEqual constant:kNormalStatusBarHeight];
    [_contentView addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_contentView addRightConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_contentView addHeightConstraintWithRelation:NSLayoutRelationEqual constant:kNormalNavigationBarHeight];
}

- (void)setupSeparatorViewConstraints
{
    _separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_separatorView addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_separatorView addRightConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_separatorView addTopConstraintToView:_contentView attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:0.0];
    [_separatorView addHeightConstraintWithRelation:NSLayoutRelationEqual constant:4.0];
}

@end
