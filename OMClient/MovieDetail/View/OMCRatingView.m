//
//  OMCRatingView.m
//  OMClient
//
//  Created by Derek Cheung on 12/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCRatingView.h"

// Constant
static NSInteger const kTotalNumberOfStar = 5;
static CGFloat const kRatingLabelFontSize = 10.0;

@interface OMCRatingView ()

@property (nonatomic, strong) NSMutableArray<UIImageView *> *ratingImageViews;
@property (nonatomic, strong) UILabel *ratingLabel;

@end

@implementation OMCRatingView

#pragma mark - Setup

- (void)setup
{
    [super setup];
    
    [self setupRatingImageViews];
    [self setupRatingLabel];
}

- (void)setupRatingImageViews
{
    _ratingImageViews = [NSMutableArray new];
    
    for (int i = 0 ; i < kTotalNumberOfStar ; i++) {
        
        UIImageView *imageView = [UIImageView new];
        
        [_ratingImageViews addObject:imageView];
        [self addSubview:imageView];
    }
}

- (void)setupRatingLabel
{
    _ratingLabel = [UILabel new];
    
    _ratingLabel.textColor = [UIColor lightGrayColor];
    _ratingLabel.font = [UIFont systemFontOfSize:kRatingLabelFontSize];
    
    [self addSubview:_ratingLabel];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
    [super setupConstraints];
    
    [self setupRatingImageViewsConstraints];
    [self setupRatingLabelConstraints];
}

- (void)setupRatingImageViewsConstraints
{
    UIImageView *previousImageView = nil;
    
    for (UIImageView *imageView in _ratingImageViews) {
        
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        if ([imageView isEqual:[_ratingImageViews firstObject]]) {
            
            [imageView addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
            [imageView addTopConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
            
        } else {
            
            [imageView addTopConstraintToView:previousImageView relation:NSLayoutRelationEqual constant:0.0];
            [imageView addLeftConstraintToView:previousImageView attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:5.0];
        }
        
        previousImageView = imageView;
    }
    
}

- (void)setupRatingLabelConstraints
{
    _ratingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_ratingLabel addLeftConstraintToView:_ratingImageViews.firstObject relation:NSLayoutRelationEqual constant:0.0];
    [_ratingLabel addTopConstraintToView:_ratingImageViews.firstObject attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:5.0];
    [_ratingLabel addBottomConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
}

#pragma mark - Setters

- (void)setRating:(float)rating
{
    _rating = rating;
    
    [self updateRatingImageViews];
    [self updateRatingLabel];
}

#pragma mark - Helpers

- (void)updateRatingImageViews
{
    NSInteger numberOfStar = _rating / 2;
    
    for (int i = 0 ; i < kTotalNumberOfStar ; i++) {
        
        if (i < numberOfStar) {
            
            _ratingImageViews[i].image = [UIImage imageNamed:@"red_star"];
            
        } else {
            
            _ratingImageViews[i].image = [UIImage imageNamed:@"outline_star"];
        }
    }
    
}

- (void)updateRatingLabel
{
    NSString *boldString = [NSString stringWithFormat:@"%.1f/10", _rating];
    NSString *fullString = [NSString stringWithFormat:@"Ratings: %@", boldString];
    
    NSRange boldRange = [fullString rangeOfString:boldString];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:fullString];
    
    NSDictionary *attrs  = @{
                             NSFontAttributeName: [UIFont boldSystemFontOfSize:kRatingLabelFontSize]
                             };
    
    [attrString setAttributes:attrs range:boldRange];
     
    _ratingLabel.attributedText = attrString;
}

@end
