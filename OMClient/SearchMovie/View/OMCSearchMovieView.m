//
//  OMCSearchMovieView.m
//  OMClient
//
//  Created by Derek Cheung on 10/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCSearchMovieView.h"

// View
#import "OMCNavigationView.h"

@interface OMCSearchMovieView ()

@property (nonatomic, strong) OMCNavigationView *navigationView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *dismissKeyboardButton;

@end

@implementation OMCSearchMovieView

#pragma mark - Setup

- (void)setup
{
	[super setup];

	[self setupNavigationView];
	[self setupSearchTextField];
	[self setupClearButton];
	[self setupTableView];
	[self setupDismissKeyboardButton];
}

- (void)setupNavigationView
{
	_navigationView = [OMCNavigationView new];

	[self addSubview:_navigationView];
}

- (void)setupSearchTextField
{
	_searchTextField = [UITextField new];

	_searchTextField.placeholder = @"Movie title";
	_searchTextField.font = [UIFont boldSystemFontOfSize:30];
	_searchTextField.textColor = [UIColor blackColor];
	_searchTextField.tintColor = [UIColor grayColor];

	[_navigationView.contentView addSubview:_searchTextField];
}

- (void)setupClearButton
{
	_clearButton = [UIButton new];

	UIImage *image = [UIImage imageNamed:@"delete"];
	[_clearButton setImage:image forState:UIControlStateNormal];

	[_navigationView.contentView addSubview:_clearButton];
}

- (void)setupTableView
{
	_tableView = [UITableView new];

	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

	[self addSubview:_tableView];
}

- (void)setupDismissKeyboardButton
{
	_dismissKeyboardButton = [UIButton new];

	_dismissKeyboardButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
	_dismissKeyboardButton.hidden = YES;

	[self addSubview:_dismissKeyboardButton];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
	[super setupConstraints];

	[self setupNavigationViewConstraints];
	[self setupSearchTextFieldConstraints];
	[self setupClearButtonConstraints];
	[self setupTableViewConstraints];
	[self setupDismissKeyboardButtonConstraints];
}

- (void)setupNavigationViewConstraints
{
	_navigationView.translatesAutoresizingMaskIntoConstraints = NO;

	[_navigationView addTopConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_navigationView addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_navigationView addRightConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
}

- (void)setupSearchTextFieldConstraints
{
	_searchTextField.translatesAutoresizingMaskIntoConstraints = NO;

	[_searchTextField addLeftConstraintToView:_searchTextField.superview relation:NSLayoutRelationEqual constant:kNormalHorizontalMargin];
	[_searchTextField addCenterYConstraintToView:_searchTextField.superview];
}

- (void)setupClearButtonConstraints
{
	_clearButton.translatesAutoresizingMaskIntoConstraints = NO;

	[_clearButton addLeftConstraintToView:_searchTextField attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:15.0];
	[_clearButton addCenterYConstraintToView:_clearButton.superview];
	[_clearButton addRightConstraintToView:_clearButton.superview relation:NSLayoutRelationEqual constant:-kNormalHorizontalMargin];
	[_clearButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setupTableViewConstraints
{
	_tableView.translatesAutoresizingMaskIntoConstraints = NO;

	[_tableView addTopConstraintToView:_navigationView attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:0.0];
	[_tableView addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_tableView addRightConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_tableView addBottomConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
}

- (void)setupDismissKeyboardButtonConstraints
{
	_dismissKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;

	[_dismissKeyboardButton addTopConstraintToView:_navigationView attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:0.0];
	[_dismissKeyboardButton addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_dismissKeyboardButton addRightConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_dismissKeyboardButton addBottomConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
}

@end
