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
#import "OMCMovieCell.h"

// Model
#import "OMCSearchModel.h"

// Manager
#import "OMCAPIManager.h"

// Constant
static CGFloat const kMovieCellHeight = 132.0;

@interface OMCSearchMovieViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) OMCSearchMovieView *view;
@property (nonatomic, strong) OMCSearchModel *searchResult;

@end

@implementation OMCSearchMovieViewController

@dynamic view;

#pragma mark - View Lifecycle

- (void)loadView
{
	self.view = [OMCSearchMovieView new];

	// Clear button
	[self.view.clearButton addTarget:self action:@selector(clearPressed:) forControlEvents:UIControlEventTouchUpInside];

	// TableView
	self.view.tableView.dataSource = self;
	self.view.tableView.delegate = self;
	[self.view.tableView registerClass:[OMCMovieCell class] forCellReuseIdentifier:[OMCMovieCell reuseIdentifier]];
}

#pragma mark - Actions

- (void)clearPressed:(UIButton *)sender
{
	[OMCAPIManager searchWithTitle:self.view.searchTextField.text
							  page:1
						   success:^(NSData *data, OMCSearchModel *dataModel)
	 {
		 _searchResult = dataModel;
		 dispatch_async(dispatch_get_main_queue(), ^
						{
							[self.view.tableView reloadData];
						});
	 }
						   failure:^(NSData *data, NSError *error, OMCAPIModel *dataModel)
	 {
		 _searchResult = nil;
		 dispatch_async(dispatch_get_main_queue(), ^
						{
							[self.view.tableView reloadData];
						});
	 }];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (_searchResult) {

		return _searchResult.movies.count;

	} else {

		return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	OMCMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:[OMCMovieCell reuseIdentifier]];

	cell.model = [_searchResult.movies objectAtIndex:indexPath.row];

	return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kMovieCellHeight;
}

@end
