//
//  OMCMovieCell.m
//  OMClient
//
//  Created by Derek Cheung on 10/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCMovieCell.h"

// Manager
#import "OMCAPIManager.h"

// View
#import "OMCImageView.h"

@interface OMCMovieCell ()

@property (nonatomic, strong) OMCImageView *posterImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *yearLabel;
@property (nonatomic, strong) OMCMovieModel *model;
@property (nonatomic, strong) NSString *searchText;

@end

@implementation OMCMovieCell

#pragma mark - Setup

- (void)setup
{
	[super setup];

	self.selectionStyle = UITableViewCellSelectionStyleNone;
	[self setupPosterImageView];
	[self setupNameLabel];
	[self setupYearLabel];
}

- (void)setupPosterImageView
{
	_posterImageView = [OMCImageView new];

	[self.contentView addSubview:_posterImageView];
}

- (void)setupNameLabel
{
	_nameLabel = [UILabel new];

	_nameLabel.font = [UIFont boldSystemFontOfSize:30.0];
	_nameLabel.numberOfLines = 2;
	_nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
	_nameLabel.textColor = [UIColor blackColor];

	[self.contentView addSubview:_nameLabel];
}

- (void)setupYearLabel
{
	_yearLabel = [UILabel new];

	_yearLabel.font = [UIFont systemFontOfSize:10];
	_yearLabel.textColor = [UIColor blackColor];

	[self.contentView addSubview:_yearLabel];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
	[super setupConstraints];

	[self setupPosterImageViewConstraints];
	[self setupNameLabelConstraints];
	[self setupYearLabelConstraints];
}

- (void)setupPosterImageViewConstraints
{
	_posterImageView.translatesAutoresizingMaskIntoConstraints = NO;

	[_posterImageView addTopConstraintToView:self.contentView relation:NSLayoutRelationEqual constant:0.0];
	[_posterImageView addLeftConstraintToView:self.contentView relation:NSLayoutRelationEqual constant:kNormalHorizontalMargin];
	[_posterImageView addHeightConstraintWithRelation:NSLayoutRelationEqual constant:112.0];
	[_posterImageView addWidthConstraintWithRelation:NSLayoutRelationEqual constant:80.0];
}

- (void)setupNameLabelConstraints
{
	_nameLabel.translatesAutoresizingMaskIntoConstraints = NO;

	[_nameLabel addTopConstraintToView:_posterImageView relation:NSLayoutRelationEqual constant:0.0];
	[_nameLabel addLeftConstraintToView:_posterImageView attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:15.0];
	[_nameLabel addRightConstraintToView:self.contentView relation:NSLayoutRelationEqual constant:-kNormalHorizontalMargin];
}

- (void)setupYearLabelConstraints
{
	_yearLabel.translatesAutoresizingMaskIntoConstraints = NO;

	[_yearLabel addLeftConstraintToView:_nameLabel relation:NSLayoutRelationEqual constant:0.0];
	[_yearLabel addRightConstraintToView:_nameLabel relation:NSLayoutRelationEqual constant:0.0];
	[_yearLabel addTopConstraintToView:_nameLabel attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:0.0];
}

#pragma mark - Public

- (void)setModel:(OMCMovieModel *)model searchText:(NSString *)string
{
	_model = model;
    _searchText = string;

	if (model) {

        [self updateNameLabel];
		_yearLabel.text = @(_model.year).stringValue;
		_posterImageView.imageUrl = _model.poster;

	} else {

        [self resetCell];
	}
}

#pragma mark - Helpers

- (void)resetCell
{
    _nameLabel.text = @"";
    _nameLabel.attributedText = nil;
    _yearLabel.text = @"";
    _posterImageView.imageUrl = @"";
    _searchText = @"";
}

- (void)updateNameLabel
{
    NSRange redRange = [_model.title.lowercaseString rangeOfString:_searchText.lowercaseString];
    
    if (redRange.location != NSNotFound) {
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:_model.title];
        
        NSDictionary *attrs  = @{
                                 NSForegroundColorAttributeName: [UIColor redColor]
                                 };
        
        [attrString setAttributes:attrs range:redRange];
        
        _nameLabel.attributedText = attrString;
        
    } else {
        
        _nameLabel.text = _model.title;
    }
}

#pragma mark - Override

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    [self resetCell];
}

@end
