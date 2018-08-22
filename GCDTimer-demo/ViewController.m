//
//  ViewController.m
//  GCDTimer-demo
//
//  Created by dzw on 2018/8/22.
//  Copyright © 2018年 dzw. All rights reserved.
//

#import "ViewController.h"
#import "GCDTimer.h"
@interface ViewController ()
@property (nonatomic, strong) GCDTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.timer = [GCDTimer scheduledTimerWithTimerInterval:1 repeats:YES block:^(dispatch_source_t timer) {
//        NSLog(@"Hello GCDTimer");
//    }];

    dispatch_queue_t queue = dispatch_queue_create("timerQueue", DISPATCH_QUEUE_CONCURRENT);
    self.timer = [GCDTimer timerWithTimeInterval:1 leeway:0 queue:queue repeats:YES block:^(dispatch_source_t timer) {
        NSLog(@"Hello GCDTimer");
    }];
    
//    self.timer = [[GCDTimer alloc]initWithTimerInterval:1 leeway:0 queue:nil repeats:YES block:^(dispatch_source_t timer) {
//        NSLog(@"Hello GCDTimer");
//    }];
}

- (IBAction)resume:(UIButton *)sender {
    [self.timer resume];
}

- (IBAction)pause:(UIButton *)sender {
    [self.timer pause];
}

- (IBAction)cancel:(UIButton *)sender {
    [self.timer cancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
