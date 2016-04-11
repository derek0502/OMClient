//
//  OMCProducersHeaderView.m
//  OMClient
//
//  Created by Derek Cheung on 11/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCProducersHeaderView.h"

// Constant
static CGFloat const kLineHeight = 0.5;

@interface OMCProducersHeaderView ()

@property (nonatomic, strong) UIView *leftLineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *rightLineView;

@end

@implementation OMCProducersHeaderView

#pragma mark - Setup

- (void)setup
{
    [super setup];
    
    [self setupLeftLineView];
    [self setupTitleLabel];
    [self setupRightLineView];
}

- (void)setupLeftLineView
{
    _leftLineView = [UIView new];
    
    _leftLineView.backgroundColor = [UIColor blackColor];
    
    [self addSubview:_leftLineView];
}

- (void)setupTitleLabel
{
    _titleLabel = [UILabel new];
    
    _titleLabel.text = @"PRODUCERS";
    _titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    _titleLabel.textColor = [UIColor blackColor];
    
    [self addSubview:_titleLabel];
}

- (void)setupRightLineView
{
    _rightLineView = [UIView new];
    
    _rightLineView.backgroundColor = [UIColor blackColor];
    
    [self addSubview:_rightLineView];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
    [super setupConstraints];
    
    [self setupLeftLineViewConstraints];
    [self setupTitleLabelConstraints];
    [self setupRightLineViewConstraints];
}

- (void)setupLeftLineViewConstraints
{
    _leftLineView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_leftLineView addCenterYConstraintToView:self];
    [_leftLineView addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_leftLineView addHeightConstraintWithRelation:NSLayoutRelationEqual constant:kLineHeight];
}

- (void)setupTitleLabelConstraints
{
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_titleLabel addLeftConstraintToView:_leftLineView attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:15.0];
    [_titleLabel addCenterYConstraintToView:self];
}

- (void)setupRightLineViewConstraints
{
    _rightLineView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_rightLineView addLeftConstraintToView:_titleLabel attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:15.0];
    [_rightLineView addCenterYConstraintToView:self];
    [_rightLineView addRightConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_rightLineView addHeightConstraintWithRelation:NSLayoutRelationEqual constant:kLineHeight];
    [_rightLineView addWidthConstraintToView:_leftLineView relation:NSLayoutRelationEqual constant:0.0];
}

@end
