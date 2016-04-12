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
#import "OMCSearchMovieHeaderView.h"

// Model
#import "OMCSearchModel.h"

// Manager
#import "OMCAPIManager.h"

// Controller
#import "OMCMovieDetailViewController.h"

// Constant
static CGFloat const kMovieCellHeight = 132.0;
static CGFloat const kTableViewHeaderViewHeight = 60.0;

@interface OMCSearchMovieViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) OMCSearchMovieView *view;
@property (nonatomic, strong) OMCSearchModel *searchResult;
@property (nonatomic, strong) NSTimer *delaySearchTimer;
@property (nonatomic, strong) NSURLSessionTask *currentTask;
@property (nonatomic, strong) OMCSearchMovieHeaderView *headerView;

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
    [self performSearch];
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

    [cell setModel:[_searchResult.movies objectAtIndex:indexPath.row] searchText:self.view.searchTextField.text];

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

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kTableViewHeaderViewHeight;
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if (_delaySearchTimer) {

		[_delaySearchTimer invalidate];
		_delaySearchTimer = nil;
	}

	_delaySearchTimer = [NSTimer scheduledTimerWithTimeInterval:0.3
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
    
    if ([self.view.searchTextField.text length] == 0) {
        
        self.headerView.status = OMCSearchMovieHeaderViewStatusStartNewSearch;
        _searchResult = nil;
       [self.view.tableView reloadData];
        
    } else if ([self.view.searchTextField.text length] == 1) {
        
        self.headerView.status = OMCSearchMovieHeaderViewStatusTooManyResults;
        _searchResult = nil;
        [self.view.tableView reloadData];
        
    } else {
        
        self.headerView.status = OMCSearchMovieHeaderViewStatusSearching;
    
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
}

- (void)reloadInMainQueue
{
	dispatch_async(dispatch_get_main_queue(), ^
				   {
                       if (_searchResult) {
                           
                           self.headerView.status = OMCSearchMovieHeaderViewStatusNormal;
                           
                       } else {
                           
                           self.headerView.status = OMCSearchMovieHeaderViewStatusNoResult;
                       }
					   [self.view.tableView reloadData];
				   });
}

- (BOOL)isSearching
{
	return _currentTask;
}

- (void)getMovieDetailById:(NSString *)imdbID
{
    [self startLoadingAnimation];
	[OMCAPIManager searchDetailWithId:imdbID
							  success:^(NSData *data, OMCMovieDetailModel *dataModel)
	 {
         OMCMovieDetailViewController *vc = [[OMCMovieDetailViewController alloc] initWithDataSource:dataModel];
         dispatch_async(dispatch_get_main_queue(), ^
         {
             [self.navigationController pushViewController:vc animated:YES];
             [self stopLoadingAnimation];
         });
	 }
							  failure:^(NSData *data, NSError *error, OMCAPIModel *dataModel)
	 {
         dispatch_async(dispatch_get_main_queue(), ^
                        {
                            [self showGeneralAlertWithText:@"Cannot not find its details😭"];
                            [self stopLoadingAnimation];
                        });
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

#pragma mark - Accessors

- (OMCSearchMovieHeaderView *)headerView
{
    if (!_headerView) {
        
        _headerView = [OMCSearchMovieHeaderView new];
    }
    
    return _headerView;
}

@end
