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
#import "OMCImageView.h"
#import "OMCRatingView.h"
#import "OMCProducersHeaderView.h"
#import "OMCProducersContentView.h"

@interface OMCMovieDetailView ()

@property (nonatomic, strong) OMCNavigationView *navigationView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) OMCImageView *posterImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) OMCRatingView *ratingView;
@property (nonatomic, strong) UILabel *plotLabel;
@property (nonatomic, strong) OMCProducersHeaderView *producersHeaderView;
@property (nonatomic, strong) OMCProducersContentView *producersContentView;

@end

@implementation OMCMovieDetailView

#pragma mark - Setup

- (void)setup
{
    [super setup];
    
    [self setupNavigationView];
    [self setupBackButton];
    [self setupShareButton];
    [self setupLikeButton];
    [self setupScrollView];
    [self setupContentView];
    [self setupPosterImageView];
    [self setupTitleLabel];
    [self setupDescriptionLabel];
    [self setupRatingView];
    [self setupPlotLabel];
    [self setupProducersHeaderView];
	[self setupProducersContentView];
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

- (void)setupShareButton
{
    _shareButton = [UIButton new];
    
    UIImage *image = [UIImage imageNamed:@"share"];
    [_shareButton setImage:image forState:UIControlStateNormal];
    
    [_navigationView.contentView addSubview:_shareButton];
}

- (void)setupLikeButton
{
    _likeButton = [UIButton new];
    
    UIImage *image = [UIImage imageNamed:@"favourite"];
    [_likeButton setImage:image forState:UIControlStateNormal];
    
    [_navigationView.contentView addSubview:_likeButton];
}

- (void)setupScrollView
{
    _scrollView = [UIScrollView new];
    
    _scrollView.scrollEnabled = YES;
    _scrollView.alwaysBounceVertical = YES;
    
    [self addSubview:_scrollView];
}

- (void)setupContentView
{
    _contentView = [UIView new];
    
    [_scrollView addSubview:_contentView];
}

- (void)setupPosterImageView
{
    _posterImageView = [OMCImageView new];
    
    [_contentView addSubview:_posterImageView];
}

- (void)setupTitleLabel
{
    _titleLabel = [UILabel new];
    
    _titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    _titleLabel.textColor = [UIColor blackColor];
    [self generalConfigWithLabel:_titleLabel];
    
    [_contentView addSubview:_titleLabel];
}

- (void)setupDescriptionLabel
{
    _descriptionLabel = [UILabel new];
    
    _descriptionLabel.textColor = [UIColor lightGrayColor];
    _descriptionLabel.font = [UIFont systemFontOfSize:10.0];
    [self generalConfigWithLabel:_descriptionLabel];
    
    [_contentView addSubview:_descriptionLabel];
}

- (void)setupRatingView
{
    _ratingView = [OMCRatingView new];
    
    [_contentView addSubview:_ratingView];
}

- (void)setupPlotLabel
{
    _plotLabel = [UILabel new];
    
    _plotLabel.font = [UIFont systemFontOfSize:15.0];
    _plotLabel.textColor = [UIColor blackColor];
    [self generalConfigWithLabel:_plotLabel];
    
    [_contentView addSubview:_plotLabel];
}

- (void)setupProducersHeaderView
{
    _producersHeaderView = [OMCProducersHeaderView new];
    
    [_contentView addSubview:_producersHeaderView];
}

- (void)setupProducersContentView
{
	_producersContentView = [OMCProducersContentView new];

	[_contentView addSubview:_producersContentView];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
    [super setupConstraints];
    
    [self setupNavigationViewConstraints];
    [self setupBackButtonConstraints];
    [self setupShareButtonConstraints];
    [self setupLikeButtonConstraints];
    [self setupScrollViewConstraints];
    [self setupContentViewConstraints];
    [self setupPosterImageViewConstraints];
    [self setupTitleLabelConstraints];
    [self setupDescriptionLabelConstraints];
    [self setupRatingViewConstraints];
    [self setupPlotLabelConstraints];
    [self setupProducersHeaderViewConstraints];
	[self setupProducersContentViewConstraints];
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

- (void)setupShareButtonConstraints
{
    _shareButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_shareButton addCenterYConstraintToView:_shareButton.superview];
}

- (void)setupLikeButtonConstraints
{
    _likeButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_likeButton addLeftConstraintToView:_shareButton attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:kNormalHorizontalMargin];
    [_likeButton addRightConstraintToView:_likeButton.superview relation:NSLayoutRelationEqual constant:-kNormalHorizontalMargin];
    [_likeButton addCenterYConstraintToView:_likeButton.superview];
}

- (void)setupScrollViewConstraints
{
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_scrollView addTopConstraintToView:_navigationView attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:0.0];
    [_scrollView addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_scrollView addRightConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_scrollView addBottomConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
}

- (void)setupContentViewConstraints
{
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_contentView addTopConstraintToView:_contentView.superview relation:NSLayoutRelationEqual constant:0.0];
    [_contentView addWidthConstraintToView:_contentView.superview relation:NSLayoutRelationEqual constant:0.0];
    [_contentView addCenterXConstraintToView:_contentView.superview relation:NSLayoutRelationEqual constant:0.0];
}

- (void)setupPosterImageViewConstraints
{
    _posterImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_posterImageView addTopConstraintToView:_posterImageView.superview relation:NSLayoutRelationEqual constant:0.0];
    [_posterImageView addLeftConstraintToView:_posterImageView.superview relation:NSLayoutRelationEqual constant:0.0];
    [_posterImageView addRightConstraintToView:_posterImageView.superview relation:NSLayoutRelationEqual constant:0.0];
    [_posterImageView addHeightConstraintWithRelation:NSLayoutRelationEqual constant:350.0];
}

- (void)setupTitleLabelConstraints
{
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_titleLabel addTopConstraintToView:_posterImageView attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:30.0];
    [_titleLabel addLeftConstraintToView:_titleLabel.superview relation:NSLayoutRelationEqual constant:kNormalHorizontalMargin];
    [_titleLabel addRightConstraintToView:_titleLabel.superview relation:NSLayoutRelationEqual constant:-kNormalHorizontalMargin];
}

- (void)setupDescriptionLabelConstraints
{
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_descriptionLabel addTopConstraintToView:_titleLabel attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:5.0];
    [_descriptionLabel addLeftConstraintToView:_descriptionLabel.superview relation:NSLayoutRelationEqual constant:kNormalHorizontalMargin];
    [_descriptionLabel addRightConstraintToView:_descriptionLabel.superview relation:NSLayoutRelationEqual constant:-kNormalHorizontalMargin];
}

- (void)setupRatingViewConstraints
{
    _ratingView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_ratingView addTopConstraintToView:_descriptionLabel attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:30.0];
    [_ratingView addLeftConstraintToView:_ratingView.superview relation:NSLayoutRelationEqual constant:kNormalHorizontalMargin];
    [_ratingView addRightConstraintToView:_ratingView.superview relation:NSLayoutRelationEqual constant:-kNormalHorizontalMargin];
    
    [_ratingView addHeightConstraintWithRelation:NSLayoutRelationEqual constant:30.0];
}

- (void)setupPlotLabelConstraints
{
    _plotLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_plotLabel addTopConstraintToView:_ratingView attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:30.0];
    [_plotLabel addLeftConstraintToView:_plotLabel.superview relation:NSLayoutRelationEqual constant:kNormalHorizontalMargin];
    [_plotLabel addRightConstraintToView:_plotLabel.superview relation:NSLayoutRelationEqual constant:-kNormalHorizontalMargin];
}

- (void)setupProducersHeaderViewConstraints
{
    _producersHeaderView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_producersHeaderView addTopConstraintToView:_plotLabel attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:30.0];
    [_producersHeaderView addLeftConstraintToView:_producersHeaderView.superview relation:NSLayoutRelationEqual constant:kNormalHorizontalMargin];
    [_producersHeaderView addRightConstraintToView:_producersHeaderView.superview relation:NSLayoutRelationEqual constant:-kNormalHorizontalMargin];
    [_producersHeaderView addHeightConstraintWithRelation:NSLayoutRelationEqual constant:30.0];
}

- (void)setupProducersContentViewConstraints
{
	_producersContentView.translatesAutoresizingMaskIntoConstraints = NO;

	[_producersContentView addTopConstraintToView:_producersHeaderView attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:10.0];
	[_producersContentView addLeftConstraintToView:_producersContentView.superview relation:NSLayoutRelationEqual constant:0.0];
	[_producersContentView addRightConstraintToView:_producersContentView.superview relation:NSLayoutRelationEqual constant:0.0];
	[_producersContentView addBottomConstraintToView:_producersContentView.superview relation:NSLayoutRelationEqual constant:-30.0];
}

#pragma mark - Setters

- (void)setDataSource:(OMCMovieDetailModel *)dataSource
{
    _dataSource = dataSource;
    
    _posterImageView.imageUrl = _dataSource.poster;
    _titleLabel.text = [self titleString];
    _descriptionLabel.text = [self descriptionString];
    _ratingView.rating = _dataSource.imdbRating;
    _plotLabel.text = _dataSource.plot;
	_producersContentView.dataSource = _dataSource;
}

#pragma mark - Public

- (void)updateContentSize
{
    CGFloat contentHeight = [_contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGFloat contentWidth = [UIScreen mainScreen].bounds.size.width;
    
    _scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
}

#pragma mark - Helpers

- (NSString *)titleString
{
    return [NSString stringWithFormat:@"%@ (%d)", _dataSource.title, (int)_dataSource.year];
}

- (NSString *)descriptionString
{
    return [NSString stringWithFormat:@"%@ | %@\n%@ | %d", _dataSource.genre, _dataSource.rated, _dataSource.runtime, (int)_dataSource.year];
}

- (void)generalConfigWithLabel:(UILabel *)label
{
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - kNormalHorizontalMargin * 2;
}

@end
