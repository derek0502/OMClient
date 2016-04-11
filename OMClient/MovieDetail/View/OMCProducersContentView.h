//
//  OMCProducersContentView.h
//  OMClient
//
//  Created by Derek Cheung on 12/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "OMCBaseView.h"

// Model
#import "OMCMovieDetailModel.h"

@interface OMCProducersContentView : OMCBaseView

@property (nonatomic, strong) OMCMovieDetailModel *dataSource;

@end
