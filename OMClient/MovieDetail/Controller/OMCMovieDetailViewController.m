//
//  OMCMovieDetailViewController.m
//  OMClient
//
//  Created by Derek Cheung on 11/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCMovieDetailViewController.h"

// View
#import "OMCMovieDetailView.h"

@interface OMCMovieDetailViewController ()

@property (nonatomic, strong) OMCMovieDetailView *view;
@property (nonatomic, strong) OMCMovieDetailModel *dataSource;

@end

@implementation OMCMovieDetailViewController

@dynamic view;

#pragma mark - Initialization

- (instancetype)initWithDataSource:(OMCMovieDetailModel *)dataSource
{
    if (self = [self init]) {
        
        self.dataSource = dataSource;
    }
    
    return self;
}

#pragma mark - View Lifecycle

- (void)loadView
{
    self.view = [OMCMovieDetailView new];
    
    // Back button
    [self.view.backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Actions

- (void)backPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
