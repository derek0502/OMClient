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
    self.view.dataSource = self.dataSource;
    
    // Back button
    [self.view.backButton addTarget:self action:@selector(backPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Share button
    [self.view.shareButton addTarget:self action:@selector(sharePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Like button
    [self.view.likeButton addTarget:self action:@selector(likePressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.view updateContentSize];
}

#pragma mark - Actions

- (void)backPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sharePressed:(UIButton *)sender
{
    [self showGeneralAlertWithText:@"Coming soon😁"];
}

- (void)likePressed:(UIButton *)sender
{
    [self showGeneralAlertWithText:@"Coming soon😁"];
}

@end
