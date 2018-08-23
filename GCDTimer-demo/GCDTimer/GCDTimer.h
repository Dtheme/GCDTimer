//
//  GCDTimer.h
//  Test
//
//  Created by dzw on 2018/8/22.
//  Copyright © 2018年 dzw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^timerAction)(dispatch_source_t timer);

@interface GCDTimer : NSObject
@property (nonatomic, copy) timerAction ac;



/**
 在全局并发线程中创建定时器

 @param timeInterval 定时器时间间隔
 @param repeats 定时器事件是否重复
 @param block 定时器事件
 @return 返回一个由全局并发线程下发的GCDTimer定时器对象
 */
+(instancetype)scheduledTimerWithTimerInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats block:(timerAction)block;

/**
 在自定义线程队列中创建定时器

 @param timeInterval 定时器
 @param leeway leeway是一个纳秒级的时间量，系统为了改进性能和介绍耗电，会根据这个时间量来推迟timer的执行以与其它系统活动同步。eg:一个程序可能执行一个5分钟为间隔的周期性任务，这个任务有30秒的容许值。要注意，所有timer都需要考虑一些潜在因素，哪怕leeway这个容许值被指定为0,也可能产生一些推迟。
 @param queue 自定义线程队列
 @param repeats 定时器事件是否重复
 @param block 定时器事件
 @return 返回一个运行在自定义线程队列中的GCDTimer对象的定时器
 */
+ (instancetype)timerWithTimeInterval:(NSTimeInterval)timeInterval leeway:(float)leeway queue:(dispatch_queue_t)queue repeats:(BOOL)repeats block:(timerAction)block;

/**
 在指定线程队列中创建定时器

 @param timeInterval 事件间隔
 @param leeway 正误差允许值 （纳秒）
 @param queue 队列
 @param repeats 事件是否重复
 @param block 定时器事件
 @return 返回一个在自定义队列创建的GCDTimer对象的定时器
 */
-(instancetype)initWithTimerInterval:(NSTimeInterval)timeInterval leeway:(float)leeway queue:(dispatch_queue_t)queue repeats:(BOOL)repeats block:(timerAction)block;


/**
 *  定时器 启动、暂停(挂起)、取消调度源
 *  使用类方法（+）初始化创建定时器不需要手动调用resume启动
 *  使用实例方法（-）初始化创建定时器需要手动调用resume启动
 */
- (void)resume;
- (void)pause;
- (void)cancel;


@end
