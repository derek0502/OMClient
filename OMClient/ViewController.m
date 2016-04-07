//
//  ViewController.m
//  OMClient
//
//  Created by Derek Cheung on 7/4/2016.
//  Copyright © 2016 Derek Cheung. All rights reserved.
//

#import "ViewController.h"

#import "OMCAPIManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [OMCAPIManager taskWithURL:@"http://www.omdbapi.com/?s=batman&type=movie"
                       success:^(NSData *data, OMCAPIModel *dataModel)
     {
         
     }
                       failure:^(NSData *data, NSError *error, OMCAPIModel *dataModel)
     {
         
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
