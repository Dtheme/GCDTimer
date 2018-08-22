# GCDTimer-demo
A timer implementation that uses dispatch_source_t(GCD)，API is just like NSTimer.

####  为什么要封装GCDTimer
 NSTimer、CADisplayLink的一些众所周知的不便
- 在常用场景下对self强引用，引起的循环引用
- 由于Runloop在任务繁重时所引起的timer时间不准

针对第一个问题解决方案有很多：

- 使用第三方对象T作为Timer的target，然后弱引用T，通过T消息转发到timer事件上，来打破循环。或者使用
- 使用block类型的NSTimer事件，并且使用__weak,__strong打破循环,如：

```objc
 __weak XXClass *weakSelf = self;
    timer = [NSTimer xx_scheduledTimerWithTimeInterval:.5 block:^{
                XXClass *strongSelf = weakSelf;
                [strongSelf doSomething];
            }repeats:YES];
```
如果你想要用好NSTimer或者想知道更多细节可以参考郭曜源大神开源的YYKit当中的对NSTimer的再封装[YYTimer](https://github.com/ibireme/YYKit/tree/3869686e0e560db0b27a7140188fad771e271508/YYKit/Utility)，不过，我在项目中使用GCD源定时器作为一般场景的定时器用作取代NSTimer的方案。

#### 使用
由于是一个比较简单的工具类就没有引入cocoaPod，将demo中的`GCDTimer`类拖到你的工程中就可以使用。
GCDTimer的接口是模仿NSTimer的设计的，分别提供了2个类方法1个实例方法。

```objc
GCDTimer *timer1 = [GCDTimer scheduledTimerWithTimerInterval:1 repeats:YES block:^(dispatch_source_t timer) {
        NSLog(@"Hello GCDTimer");
}];
    
//可以创建自己想要的指定队列传入queue初始化定时器，默认在全局并发队列中运行定时器
dispatch_queue_t queue = dispatch_queue_create("timerQueue", DISPATCH_QUEUE_CONCURRENT);
GCDTimer *timer2 = [GCDTimer timerWithTimeInterval:1 leeway:0 queue:queue repeats:YES block:^(dispatch_source_t timer) {
        NSLog(@"Hello GCDTimer");
}];
GCDTimer *timer13 = [[GCDTimer alloc]initWithTimerInterval:1 leeway:0 queue:nil repeats:YES block:^(dispatch_source_t timer) {
        NSLog(@"Hello GCDTimer");
}];
    
```
Timer的生命周期：
```objc
//启动timer
- (void)resume;
//暂停
- (void)pause;
//取消调度源
- (void)cancel;
```
如果觉得还行就拿去用吧，有问题欢迎issue，一起讨论。
