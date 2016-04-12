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
#import "OMCSearchMovieFooterView.h"

// Model
#import "OMCSearchModel.h"

// Manager
#import "OMCAPIManager.h"

// Controller
#import "OMCMovieDetailViewController.h"

// Constant
static CGFloat const kMovieCellHeight = 132.0;
static CGFloat const kTableViewHeaderViewHeight = 60.0;
static CGFloat const kTableViewFooterViewHeight = 40.0;

@interface OMCSearchMovieViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, OMCSearchMovieFooterViewDelegate>

@property (nonatomic, strong) OMCSearchMovieView *view;
@property (nonatomic, strong) NSTimer *delaySearchTimer;
@property (nonatomic, strong) NSURLSessionTask *currentTask;
@property (nonatomic, strong) OMCSearchMovieHeaderView *headerView;
@property (nonatomic, strong) OMCSearchMovieFooterView *footerView;
@property (nonatomic, strong) NSMutableArray<OMCMovieModel *> *dataSource;
@property (nonatomic, strong) NSString *currentSearch;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalResults;

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
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	OMCMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:[OMCMovieCell reuseIdentifier]];

    [cell setModel:[self.dataSource objectAtIndex:indexPath.row] searchText:self.view.searchTextField.text];

	return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kMovieCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	OMCMovieModel *movie = [self.dataSource objectAtIndex:indexPath.row];

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

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self shouldShowFooter]) {
        
        return self.footerView;
        
    } else {
        
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self shouldShowFooter]) {
        
        return kTableViewFooterViewHeight;
        
    } else {
        
        return 0.0001;
    }
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
    
    if (![_currentSearch isEqualToString:self.view.searchTextField.text]) {
        
        [self.dataSource removeAllObjects];
        _currentPage = 0;
        _totalResults = 0;
    }
    
    if ([self.view.searchTextField.text length] == 0) {
        
        self.headerView.status = OMCSearchMovieHeaderViewStatusStartNewSearch;
       [self.view.tableView reloadData];
        
    } else if ([self.view.searchTextField.text length] == 1) {
        
        self.headerView.status = OMCSearchMovieHeaderViewStatusTooManyResults;
        [self.view.tableView reloadData];
        
    } else {
        
        self.headerView.status = OMCSearchMovieHeaderViewStatusSearching;
        self.footerView.status = OMCSearchMovieFooterViewStatusLoading;
        _currentPage++;
        _currentTask = [OMCAPIManager searchWithTitle:self.view.searchTextField.text
                                                 page:_currentPage
                                              success:^(NSData *data, OMCSearchModel *dataModel)
                        {
                            _currentTask = nil;
                            _totalResults = dataModel.totalResults;
                            [self.dataSource addObjectsFromArray:dataModel.movies];
                            [self reloadInMainQueue];
                        }
                                              failure:^(NSData *data, NSError *error, OMCAPIModel *dataModel)
                        {
                            _currentTask = nil;
                            [self.dataSource removeAllObjects];
                            [self reloadInMainQueue];
                        }];
    }
    
    _currentSearch = self.view.searchTextField.text;
}

- (void)reloadInMainQueue
{
	dispatch_async(dispatch_get_main_queue(), ^
				   {
                       if (self.dataSource.count) {
                           
                           self.headerView.status = OMCSearchMovieHeaderViewStatusNormal;
                           
                       } else {
                           
                           self.headerView.status = OMCSearchMovieHeaderViewStatusNoResult;
                       }
                       
                       self.footerView.status = OMCSearchMovieFooterViewStatusNormal;
                       
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

- (BOOL)shouldShowFooter
{
    return (self.dataSource.count < _totalResults);
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

- (OMCSearchMovieFooterView *)footerView
{
    if (!_footerView) {
        
        _footerView = [OMCSearchMovieFooterView new];
        _footerView.delegate = self;
    }
    
    return _footerView;
}

- (NSMutableArray<OMCMovieModel *> *)dataSource
{
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray new];
    }
    
    return _dataSource;
}

#pragma mark - <OMCSearchMovieFooterViewDelegate>

- (void)viewDidTap:(OMCSearchMovieFooterView *)view
{
    [self performSearch];
}

@end
