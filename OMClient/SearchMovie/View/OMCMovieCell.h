//
//  OMCMovieCell.h
//  OMClient
//
//  Created by Derek Cheung on 10/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseTableViewCell.h"

// Model
#import "OMCMovieModel.h"

@interface OMCMovieCell : OMCBaseTableViewCell

@property (nonatomic, strong) OMCMovieModel *model;

@end
