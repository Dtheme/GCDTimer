//
//  GCDTimer.m
//  Test
//
//  Created by dzw on 2018/8/22.
//  Copyright © 2018年 dzw. All rights reserved.
//

#import "GCDTimer.h"
@interface GCDTimer()
@property (nonatomic, strong) dispatch_source_t  timer;
@property (nonatomic, assign) float timeInterval;
@property (nonatomic, assign) float leewayValue;
@end

@implementation GCDTimer

+(instancetype)scheduledTimerWithTimerInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats block:(timerAction)block{
    
    return [GCDTimer timerWithTimeInterval:timeInterval leeway:0 queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) repeats:repeats block:block];
}

+(instancetype)timerWithTimeInterval:(NSTimeInterval)timeInterval leeway:(float)leeway queue:(dispatch_queue_t)queue repeats:(BOOL)repeats block:(timerAction)block{
    
    GCDTimer *timer = [[GCDTimer alloc]initWithTimerInterval:timeInterval leeway:leeway queue:queue repeats:repeats block:block];
    [timer resume];
    return timer;
}

-(instancetype)initWithTimerInterval:(NSTimeInterval)timeInterval leeway:(float)leeway queue:(dispatch_queue_t)queue repeats:(BOOL)repeats block:(timerAction)block{
    if (self = [super init]) {
        
        self.timeInterval = timeInterval;
        self.leewayValue = leeway;
        self.ac = block;
        
        dispatch_queue_t timerQueue = queue?(queue):(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    
        self.timer =  dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, timerQueue);
        dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, self.timeInterval * NSEC_PER_SEC, leeway * NSEC_PER_SEC);
        dispatch_source_set_event_handler(self.timer, ^{
            if (block) {
                block(self.timer);
            }
            if (!repeats) {
                dispatch_source_cancel(self.timer);
            }
        });
        
    }
    return self;
}
- (void)resume{
    
    //如果已经被取消需要重新创建timer
    if (dispatch_testcancel(self.timer)) {
        NSLog(@"------GCDtimer has been canceled!-----");
    }else{
        dispatch_resume(self.timer);
    }
}

-(void)pause{
    dispatch_suspend(self.timer);
}

- (void)cancel{
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
}

- (dispatch_source_t)timer{
    if (!_timer) {
        _timer =  dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    }
    return _timer;
}

@end
