//
//  OMCImageView.h
//  OMClient
//
//  Created by Derek Cheung on 10/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseView.h"

@interface OMCImageView : OMCBaseView

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign, readonly) BOOL isLoading;

@end
