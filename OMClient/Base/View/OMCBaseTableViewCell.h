//
//  OMCBaseTableViewCell.h
//  OMClient
//
//  Created by Derek Cheung on 10/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import <UIKit/UIKit.h>

// Category
#import "UIView+AutoLayoutHelper.h"

@interface OMCBaseTableViewCell : UITableViewCell

- (void)setup;

- (void)setupConstraints;

+ (NSString *)reuseIdentifier;

@end
