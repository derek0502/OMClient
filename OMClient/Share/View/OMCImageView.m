//
//  OMCImageView.m
//  OMClient
//
//  Created by Derek Cheung on 10/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCImageView.h"

// Manager
#import "OMCAPIManager.h"

@interface OMCImageView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *progressView;
@property (nonatomic, strong) UILabel *noImageLabel;
@property (nonatomic, strong) NSURLSessionDownloadTask *currentTask;

@end

@implementation OMCImageView

#pragma mark - Setup

- (void)setup
{
	[super setup];

	[self setupImageView];
	[self setupProgressView];
	[self setupNoImageLabel];
}

- (void)setupImageView
{
	_imageView = [UIImageView new];

	_imageView.backgroundColor = [UIColor lightGrayColor];
	_imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;

	[self addSubview:_imageView];
}

- (void)setupProgressView
{
	_progressView = [UIActivityIndicatorView new];

	_progressView.hidden = YES;

	[self addSubview:_progressView];
}

- (void)setupNoImageLabel
{
	_noImageLabel = [UILabel new];

	_noImageLabel.text = @"No\nImage";
	_noImageLabel.numberOfLines = 2;
	_noImageLabel.font = [UIFont systemFontOfSize:8.0];
	_noImageLabel.hidden = NO;
	_noImageLabel.textColor = [UIColor darkGrayColor];
	_noImageLabel.textAlignment = NSTextAlignmentCenter;

	[self addSubview:_noImageLabel];
}

#pragma mark - Setup Constraints

- (void)setupConstraints
{
	[super setupConstraints];

	[self setupImageViewConstraints];
	[self setupProgressViewConstraints];
	[self setupNoImageLabelConstraints];
}

- (void)setupImageViewConstraints
{
	_imageView.translatesAutoresizingMaskIntoConstraints = NO;

    [_imageView addWidthConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_imageView addHeightConstraintToView:self relation:NSLayoutRelationEqual constant:0.0];
    [_imageView addCenterXConstraintToView:self];
    [_imageView addCenterYConstraintToView:self];
}

- (void)setupProgressViewConstraints
{
	_progressView.translatesAutoresizingMaskIntoConstraints = NO;

	[_progressView addCenterXConstraintToView:self];
	[_progressView addCenterYConstraintToView:self];

}

- (void)setupNoImageLabelConstraints
{
	_noImageLabel.translatesAutoresizingMaskIntoConstraints = NO;

	[_noImageLabel addCenterXConstraintToView:self];
	[_noImageLabel addCenterYConstraintToView:self];
}

#pragma mark - Setters

- (void)setImageUrl:(NSString *)imageUrl
{
	_imageUrl = imageUrl;

	if (_currentTask) {

		[_currentTask cancel];
		_currentTask = nil;
	}

	if ([imageUrl length] > 0) {

		_progressView.hidden = NO;
		[_progressView startAnimating];
		_noImageLabel.hidden = YES;
		_currentTask = [OMCAPIManager downloadImageWithUrl:imageUrl
												   success:^(NSData *imageData)
						{
							[self setImageWithData:imageData];
						}
												   failure:^(NSData *data, NSError *error)
						{
							[self setImageWithData:nil];
						}];
	} else {

		[self setImageWithData:nil];
	}
}

#pragma mark - Accessors

- (BOOL)isLoading
{
	return !_progressView.hidden;
}

#pragma mark - Helpers

- (void)setImageWithData:(NSData *)data
{
	_currentTask = nil;

	UIImage *image = nil;

	if (data) {

		image = [UIImage imageWithData:data];
	}

	dispatch_async(dispatch_get_main_queue(), ^
				   {
					   _imageView.image = image;
					   _progressView.hidden = YES;
					   [_progressView stopAnimating];
					   _noImageLabel.hidden = image;
				   });
}

@end
