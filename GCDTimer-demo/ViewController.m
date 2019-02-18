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
@property (nonatomic, strong) GCDTimer *GCD_Timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:244.0/255.0 green:245.0/255.0 blue:246.0/255.0 alpha:255.0/255.0];

    [self _GCDTimer3];
}

-(void)_GCDTimer1{
    //1.默认使用
    self.GCD_Timer = [GCDTimer scheduledTimerWithTimerInterval:1 repeats:YES block:^(dispatch_source_t timer) {
        NSLog(@"Hello GCDTimer");
    }];
}

-(void)_GCDTimer2{
    //2.在自定义队列中加载timer
    dispatch_queue_t queue = dispatch_queue_create("timerQueue", DISPATCH_QUEUE_CONCURRENT);
    self.GCD_Timer = [GCDTimer timerWithTimeInterval:1 leeway:0 queue:queue repeats:YES block:^(dispatch_source_t timer) {
        NSLog(@"Hello GCDTimer");
        NSLog(@"%@",[NSThread currentThread]);
    }];
    
}

-(void)_GCDTimer3{
    //3.使用实例方法初始化timer对象使用
    self.GCD_Timer = [[GCDTimer alloc]initWithTimerInterval:1 leeway:0 queue:nil repeats:YES block:^(dispatch_source_t timer) {
        NSLog(@"Hello GCDTimer");
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.GCD_Timer cancel];
}

- (IBAction)resume:(UIButton *)sender {
    [self.GCD_Timer resume];
}

- (IBAction)pause:(UIButton *)sender {
    [self.GCD_Timer pause];
}

- (IBAction)cancel:(UIButton *)sender {
    [self.GCD_Timer cancel];
}



@end
