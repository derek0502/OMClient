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

@interface OMCSearchMovieViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) OMCSearchMovieView *view;
@property (nonatomic, strong) OMCSearchModel *searchResult;
@property (nonatomic, strong) NSTimer *delaySearchTimer;
@property (nonatomic, strong) NSURLSessionTask *currentTask;

@end

@implementation OMCSearchMovieViewController

@dynamic view;

#pragma mark - View Lifecycle

- (void)loadView
{
	self.view = [OMCSearchMovieView new];

	// Clear button
	[self.view.clearButton addTarget:self action:@selector(clearPressed:) forControlEvents:UIControlEventTouchUpInside];

	// Dismiss keyboard button
	[self.view.dismissKeyboardButton addTarget:self action:@selector(dismissKeyboardPressed:) forControlEvents:UIControlEventTouchUpInside];

	// TableView
	self.view.tableView.dataSource = self;
	self.view.tableView.delegate = self;
	[self.view.tableView registerClass:[OMCMovieCell class] forCellReuseIdentifier:[OMCMovieCell reuseIdentifier]];

	// Textfield
	self.view.searchTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillHide:)
												 name:UIKeyboardWillHideNotification object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillShow:)
												 name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillHideNotification
												  object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillShowNotification
												  object:nil];

}
#pragma mark - Actions

- (void)clearPressed:(UIButton *)sender
{
	self.view.searchTextField.text = @"";
}

- (void)dismissKeyboardPressed:(UIButton *)sender
{
	[self.view.searchTextField resignFirstResponder];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	OMCMovieModel *movie = [_searchResult.movies objectAtIndex:indexPath.row];

	[self getMovieDetailById:movie.imdbID];
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if (_delaySearchTimer) {

		[_delaySearchTimer invalidate];
		_delaySearchTimer = nil;
	}

	_delaySearchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
														 target:self
													   selector:@selector(performSearch)
													   userInfo:nil
														repeats:NO];

	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];

	return NO;
}

#pragma mark - Helpers

- (void)performSearch
{
	if (_currentTask) {

		[_currentTask cancel];
		_currentTask = nil;
	}
	_currentTask = [OMCAPIManager searchWithTitle:self.view.searchTextField.text
											 page:1
										  success:^(NSData *data, OMCSearchModel *dataModel)
					{
						_searchResult = dataModel;
						_currentTask = nil;
						[self reloadInMainQueue];
					}
										  failure:^(NSData *data, NSError *error, OMCAPIModel *dataModel)
					{
						_searchResult = nil;
						_currentTask = nil;
						[self reloadInMainQueue];
					}];
}

- (void)reloadInMainQueue
{
	dispatch_async(dispatch_get_main_queue(), ^
				   {
					   [self.view.tableView reloadData];
				   });
}

- (BOOL)isSearching
{
	return _currentTask;
}

- (void)getMovieDetailById:(NSString *)imdbID
{
	[OMCAPIManager searchDetailWithId:imdbID
							  success:^(NSData *data, OMCMovieDetailModel *dataModel)
	 {

	 }
							  failure:^(NSData *data, NSError *error, OMCAPIModel *dataModel)
	 {
		 
	 }];
}

#pragma mark - Notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
	self.view.dismissKeyboardButton.hidden = NO;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	self.view.dismissKeyboardButton.hidden = YES;
}

@end
