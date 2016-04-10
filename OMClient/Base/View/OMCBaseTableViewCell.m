//
//  OMCBaseTableViewCell.m
//  OMClient
//
//  Created by Derek Cheung on 10/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseTableViewCell.h"

@implementation OMCBaseTableViewCell

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

	if (self) {

		self.backgroundColor = [UIColor clearColor];
		[self setup];
		[self setupConstraints];
	}
	return self;
}

#pragma mark - Setup

- (void)setup
{
	// Abstract method.
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
	// Abstract method.
}

#pragma mark - Layout

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self.contentView setNeedsLayout];
	[self.contentView layoutIfNeeded];
}

#pragma mark - Pubilc

+ (NSString *)reuseIdentifier
{
	return NSStringFromClass([self class]);
}

@end
