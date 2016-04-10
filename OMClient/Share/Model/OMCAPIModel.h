//
//  OMCAPIModel.h
//  OMClient
//
//  Created by Derek Cheung on 7/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseModel.h"

@interface OMCAPIModel : OMCBaseModel

@property (nonatomic, assign) BOOL response;
@property (nonatomic, strong) NSString *errorMessage;

@end
