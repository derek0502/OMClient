//
//  OMCProducersContentView.m
//  OMClient
//
//  Created by Derek Cheung on 12/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCProducersContentView.h"

// Constant
static CGFloat const kNameLabelsLeftMargin = 150.0;

@interface OMCProducersContentView ()

@property (nonatomic, strong) UILabel *directorTitleLabel;
@property (nonatomic, strong) UILabel *directorNameLabel;
@property (nonatomic, strong) UILabel *writersTitleLabel;
@property (nonatomic, strong) UILabel *writersNameLabel;
@property (nonatomic, strong) UILabel *actorsTitleLabel;
@property (nonatomic, strong) UILabel *actorsNameLabel;

@end

@implementation OMCProducersContentView

#pragma mark - Setup

- (void)setup
{
	[super setup];

	[self setupDirectorTitleLabel];
	[self setupDirectorNameLabel];
	[self setupWritersTitleLabel];
	[self setupWritersNameLabel];
	[self setupActorsTitleLabel];
	[self setupActorsNameLabel];
}

- (void)setupDirectorTitleLabel
{
	_directorTitleLabel = [UILabel new];

	_directorTitleLabel.text = @"DIRECTOR";
	[self generalConfigForTitleLabel:_directorTitleLabel];

	[self addSubview:_directorTitleLabel];
}

- (void)setupDirectorNameLabel
{
	_directorNameLabel = [UILabel new];

	[self generalConfigForNameLabel:_directorNameLabel];

	[self addSubview:_directorNameLabel];
}

- (void)setupWritersTitleLabel
{
	_writersTitleLabel = [UILabel new];

	_writersTitleLabel.text = @"WRITERS";
	[self generalConfigForTitleLabel:_writersTitleLabel];

	[self addSubview:_writersTitleLabel];
}

- (void)setupWritersNameLabel
{
	_writersNameLabel = [UILabel new];

	[self generalConfigForNameLabel:_writersNameLabel];

	[self addSubview:_writersNameLabel];
}

- (void)setupActorsTitleLabel
{
	_actorsTitleLabel = [UILabel new];

	_actorsTitleLabel.text = @"ACTORS";
	[self generalConfigForTitleLabel:_actorsTitleLabel];

	[self addSubview:_actorsTitleLabel];
}

- (void)setupActorsNameLabel
{
	_actorsNameLabel = [UILabel new];

	[self generalConfigForNameLabel:_actorsNameLabel];

	[self addSubview:_actorsNameLabel];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
	[super setupConstraints];

	[self setupDirectorTitleLabelConstraints];
	[self setupDirectorNameLabelConstraints];
	[self setupWritersTitleLabelConstraints];
	[self setupWritersNameLabelConstraints];
	[self setupActorsTitleLabelConstraints];
	[self setupActorsNameLabelConstraints];
}

- (void)setupDirectorTitleLabelConstraints
{
	_directorTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;

	[_directorTitleLabel addCenterYConstraintToView:_directorNameLabel relation:NSLayoutRelationEqual constant:0.0];
	[_directorTitleLabel addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:kNormalHorizontalMargin];
}

- (void)setupDirectorNameLabelConstraints
{
	_directorNameLabel.translatesAutoresizingMaskIntoConstraints = NO;

	[_directorNameLabel addTopConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_directorNameLabel addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:kNameLabelsLeftMargin];
	[_directorNameLabel addRightConstraintToView:self relation:NSLayoutRelationEqual constant:-kNormalHorizontalMargin];
}

- (void)setupWritersTitleLabelConstraints
{
	_writersTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;

	[_writersTitleLabel addLeftConstraintToView:_directorTitleLabel relation:NSLayoutRelationEqual constant:0.0];
	[_writersTitleLabel addCenterYConstraintToView:_writersNameLabel relation:NSLayoutRelationEqual constant:0.0];
}

- (void)setupWritersNameLabelConstraints
{
	_writersNameLabel.translatesAutoresizingMaskIntoConstraints = NO;

	[_writersNameLabel addTopConstraintToView:_directorNameLabel attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:10.0];
	[_writersNameLabel addLeftConstraintToView:_directorNameLabel relation:NSLayoutRelationEqual constant:0.0];
	[_writersNameLabel addRightConstraintToView:_directorNameLabel relation:NSLayoutRelationEqual constant:0.0];
}

- (void)setupActorsTitleLabelConstraints
{
	_actorsTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;

	[_actorsTitleLabel addLeftConstraintToView:_directorTitleLabel relation:NSLayoutRelationEqual constant:0.0];
	[_actorsTitleLabel addCenterYConstraintToView:_actorsNameLabel relation:NSLayoutRelationEqual constant:0.0];
}

- (void)setupActorsNameLabelConstraints
{
	_actorsNameLabel.translatesAutoresizingMaskIntoConstraints = NO;

	[_actorsNameLabel addTopConstraintToView:_writersNameLabel attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:10.0];
	[_actorsNameLabel addLeftConstraintToView:_directorNameLabel relation:NSLayoutRelationEqual constant:0.0];
	[_actorsNameLabel addRightConstraintToView:_directorNameLabel relation:NSLayoutRelationEqual constant:0.0];
	[_actorsNameLabel addBottomConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
}

#pragma mark - Helpers

- (void)generalConfigForTitleLabel:(UILabel *)label
{
	label.textColor = [UIColor blackColor];
	label.font = [UIFont boldSystemFontOfSize:15.0];
}

- (void)generalConfigForNameLabel:(UILabel *)label
{
	label.textColor = [UIColor blackColor];
	label.font = [UIFont systemFontOfSize:15.0];
	label.numberOfLines = 0;
	label.lineBreakMode = NSLineBreakByWordWrapping;

	CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
	label.preferredMaxLayoutWidth = screenWidth - kNameLabelsLeftMargin - kNormalHorizontalMargin * 2;
}

#pragma mark - Setters

- (void)setDataSource:(OMCMovieDetailModel *)dataSource
{
	_dataSource = dataSource;

	_directorNameLabel.text = _dataSource.director;
	_writersNameLabel.text = _dataSource.writer;
	_actorsNameLabel.text = _dataSource.actors;
}

@end
