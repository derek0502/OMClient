//
//  OMCSearchMovieView.h
//  OMClient
//
//  Created by Derek Cheung on 10/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseView.h"

@interface OMCSearchMovieView : OMCBaseView

@property (nonatomic, strong, readonly) UITextField *searchTextField;
@property (nonatomic, strong, readonly) UIButton *clearButton;
@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, strong, readonly) UIButton *dismissKeyboardButton;


@end
