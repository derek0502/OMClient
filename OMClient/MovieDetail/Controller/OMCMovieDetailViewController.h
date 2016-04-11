//
//  OMCMovieDetailViewController.h
//  OMClient
//
//  Created by Derek Cheung on 11/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseViewController.h"

// Model
#import "OMCMovieDetailModel.h"

@interface OMCMovieDetailViewController : OMCBaseViewController

- (instancetype)initWithDataSource:(OMCMovieDetailModel *)dataSource;

@end
