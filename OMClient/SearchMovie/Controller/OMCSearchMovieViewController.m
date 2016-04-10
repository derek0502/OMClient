//
//  OMCSearchMovieViewController.m
//  OMClient
//
//  Created by Derek Cheung on 10/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCSearchMovieViewController.h"

// View
#import "OMCSearchMovieView.h"

@interface OMCSearchMovieViewController ()

@property (nonatomic, strong) OMCSearchMovieView *view;

@end

@implementation OMCSearchMovieViewController

@dynamic view;

#pragma mark - View Lifecycle

- (void)loadView
{
	self.view = [OMCSearchMovieView new];
}

@end
