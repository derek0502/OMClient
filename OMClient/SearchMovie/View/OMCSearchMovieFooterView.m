//
//  OMCSearchMovieFooterView.m
//  OMClient
//
//  Created by Derek Cheung on 12/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCSearchMovieFooterView.h"

@interface OMCSearchMovieFooterView ()

@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation OMCSearchMovieFooterView

#pragma mark - Setup

- (void)setup
{
    [super setup];
    
    [self setupMoreImageView];
    [self setupIndicatorView];
    self.status = OMCSearchMovieFooterViewStatusNormal;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)setupMoreImageView
{
    _moreImageView = [UIImageView new];
    
    _moreImageView.image = [UIImage imageNamed:@"more"];
    
    [self addSubview:_moreImageView];
}

- (void)setupIndicatorView
{
    _indicatorView = [UIActivityIndicatorView new];
    
    _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    [self addSubview:_indicatorView];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
    [super setupConstraints];
    
    [self setupMoreImageViewConstraints];
    [self setupIndicatorViewConstraints];
}

- (void)setupMoreImageViewConstraints
{
    _moreImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_moreImageView addTopConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_moreImageView addCenterXConstraintToView:self];
}

- (void)setupIndicatorViewConstraints
{
    _indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_indicatorView addTopConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_indicatorView addCenterXConstraintToView:self];
}

#pragma mark - Setters

- (void)setStatus:(OMCSearchMovieFooterViewStatus)status
{
    _status = status;
    
    switch (_status) {
            
        case OMCSearchMovieFooterViewStatusLoading:
            
            _moreImageView.hidden = YES;
            [_indicatorView startAnimating];
            _indicatorView.hidden = NO;
            break;
            
        default:
            
            _indicatorView.hidden = YES;
            [_indicatorView stopAnimating];
            _moreImageView.hidden = NO;
            break;
    }
}

#pragma mark - Actions

- (void)tap:(UIView *)sender
{
    if (_status == OMCSearchMovieFooterViewStatusNormal) {
        
        if ([_delegate respondsToSelector:@selector(viewDidTap:)]) {
            
            [_delegate viewDidTap:self];
        }
    }
}

@end
