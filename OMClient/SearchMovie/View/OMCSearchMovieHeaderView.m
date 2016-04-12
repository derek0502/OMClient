//
//  OMCSearchMovieHeaderView.m
//  OMClient
//
//  Created by Derek Cheung on 12/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCSearchMovieHeaderView.h"

@interface OMCSearchMovieHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation OMCSearchMovieHeaderView

#pragma mark - Setup

- (void)setup
{
    [super setup];
    
    [self setupTitleLabel];
    self.status = OMCSearchMovieHeaderViewStatusStartNewSearch;
}

- (void)setupTitleLabel
{
    _titleLabel = [UILabel new];
    
    _titleLabel.numberOfLines = 1;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [self addSubview:_titleLabel];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
    [super setupConstraints];
    
    [self setupTitleLabelConstraints];
}

- (void)setupTitleLabelConstraints
{
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_titleLabel addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:kNormalHorizontalMargin];
    [_titleLabel addRightConstraintToView:self relation:NSLayoutRelationEqual constant:-kNormalHorizontalMargin];
    [_titleLabel addCenterYConstraintToView:self];
}

#pragma mark - Setters

- (void)setStatus:(OMCSearchMovieHeaderViewStatus)status
{
    _status = status;
    
    NSString *statusString = @"";
    
    switch (_status) {
            
        case OMCSearchMovieHeaderViewStatusStartNewSearch:
            
            statusString = @"START A NEW SEARCH";
            break;
            
        case OMCSearchMovieHeaderViewStatusTooManyResults:
            
            statusString = @"TOO MANY RESULTS";
            break;
            
        case OMCSearchMovieHeaderViewStatusNoResult:
            
            statusString = @"NO RESULT FOUND";
            break;
            
        case OMCSearchMovieHeaderViewStatusSearching:
            
            statusString = @"SEARCHING...";
            break;
            
        default:
            
            statusString = @"SEARCH RESULT";
            break;
    }
    
    _titleLabel.text = statusString;
}

@end
