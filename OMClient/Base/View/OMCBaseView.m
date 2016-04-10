//
//  OMCBaseView.m
//  OMClient
//
//  Created by Derek Cheung on 10/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseView.h"

@implementation OMCBaseView

#pragma mark - Initialization

- (instancetype)init
{
	self = [super init];

	if (self) {

		[self setup];
		[self setupConstraints];
	}

	return self;
}

- (void)awakeFromNib
{
	[self setup];
	[self setupConstraints];
}

#pragma mark - Setup

- (void)setup
{
	// Override hook
	self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
	// Override hook
}

@end
