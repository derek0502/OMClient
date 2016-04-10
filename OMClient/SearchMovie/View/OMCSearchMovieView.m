//
//  OMCSearchMovieView.m
//  OMClient
//
//  Created by Derek Cheung on 10/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCSearchMovieView.h"

@interface OMCSearchMovieView ()

@property (nonatomic, strong) UIView *searchContainerView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation OMCSearchMovieView

#pragma mark - Setup

- (void)setup
{
	[super setup];

	[self setupSearchContainerView];
	[self setupSearchTextField];
	[self setupClearButton];
	[self setupSeparatorView];
	[self setupTableView];
}

- (void)setupSearchContainerView
{
	_searchContainerView = [UIView new];

	[self addSubview:_searchContainerView];
}

- (void)setupSearchTextField
{
	_searchTextField = [UITextField new];

	_searchTextField.placeholder = @"Movie title";
	_searchTextField.font = [UIFont boldSystemFontOfSize:30];
	_searchTextField.textColor = [UIColor blackColor];
	_searchTextField.tintColor = [UIColor grayColor];

	[_searchContainerView addSubview:_searchTextField];
}

- (void)setupClearButton
{
	_clearButton = [UIButton new];

	UIImage *image = [UIImage imageNamed:@"delete"];
	[_clearButton setImage:image forState:UIControlStateNormal];

	[_searchContainerView addSubview:_clearButton];
}

- (void)setupSeparatorView
{
	_separatorView = [UIView new];

	_separatorView.backgroundColor = [UIColor redColor];

	[self addSubview:_separatorView];
}

- (void)setupTableView
{
	_tableView = [UITableView new];

	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

	[self addSubview:_tableView];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
	[super setupConstraints];

	[self setupSearchContainerViewConstraints];
	[self setupSearchTextFieldConstraints];
	[self setupClearButtonConstraints];
	[self setupSeparatorViewConstraints];
	[self setupTableViewConstraints];
}

- (void)setupSearchContainerViewConstraints
{
	_searchContainerView.translatesAutoresizingMaskIntoConstraints = NO;

	[_searchContainerView addTopConstraintToView:self relation:NSLayoutRelationEqual constant:kNormalStatusBarHeight];
	[_searchContainerView addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_searchContainerView addRightConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_searchContainerView addHeightConstraintWithRelation:NSLayoutRelationEqual constant:kNormalNavigationBarHeight];
}

- (void)setupSearchTextFieldConstraints
{
	_searchTextField.translatesAutoresizingMaskIntoConstraints = NO;

	[_searchTextField addLeftConstraintToView:_searchContainerView relation:NSLayoutRelationEqual constant:kNormalHorizontalMargin];
	[_searchTextField addCenterYConstraintToView:_searchContainerView];
}

- (void)setupClearButtonConstraints
{
	_clearButton.translatesAutoresizingMaskIntoConstraints = NO;

	[_clearButton addLeftConstraintToView:_searchTextField attribute:NSLayoutAttributeRight relation:NSLayoutRelationEqual constant:15.0];
	[_clearButton addCenterYConstraintToView:_searchContainerView];
	[_clearButton addRightConstraintToView:_searchContainerView relation:NSLayoutRelationEqual constant:-kNormalHorizontalMargin];
	[_clearButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setupSeparatorViewConstraints
{
	_separatorView.translatesAutoresizingMaskIntoConstraints = NO;

	[_separatorView addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_separatorView addRightConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_separatorView addTopConstraintToView:_searchContainerView attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:0.0];
	[_separatorView addHeightConstraintWithRelation:NSLayoutRelationEqual constant:4.0];
}

- (void)setupTableViewConstraints
{
	_tableView.translatesAutoresizingMaskIntoConstraints = NO;

	[_tableView addTopConstraintToView:_separatorView attribute:NSLayoutAttributeBottom relation:NSLayoutRelationEqual constant:0.0];
	[_tableView addLeftConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_tableView addRightConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
	[_tableView addBottomConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
}

@end
