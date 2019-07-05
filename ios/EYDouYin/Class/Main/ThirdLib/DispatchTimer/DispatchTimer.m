//
//  DispatchTimer.m
//  DispatchTimer
//
//  Created by lieryang on 17/3/20.
//  Copyright © 2017年 lieryang. All rights reserved.
//

#import "DispatchTimer.h"

@implementation DispatchTimer

static NSMutableDictionary * timerContainer;

+ (void)initialize
{
    timerContainer = [NSMutableDictionary dictionary];
}

+ (void)scheduleDispatchTimerWithName:(NSString *)timerName timeInterval:(double)interval queue:(dispatch_queue_t)queue repeats:(BOOL)repeats action:(dispatch_block_t)action
{
    if (nil == timerName) {
        return;
    }
    
    if (nil == queue) {//默认为全局并发队列
        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    dispatch_source_t timer = [
                               timerContainer objectForKey:timerName];
    if (timer == nil) {//创建
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        [timerContainer setObject:timer forKey:timerName];
        //执行timer 一定放在这里 放下面会造成野地址
        dispatch_resume(timer);
    }
    
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC);
    dispatch_source_set_timer(timer, start, interval * NSEC_PER_SEC, 0);
    
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(timer, ^{
        action();
        if (!repeats) {
            [weakSelf cancelTimerWithName:timerName];
        }
    });
}

+ (void)cancelTimerWithName:(NSString *)timerName
{
    dispatch_source_t timer = [timerContainer objectForKey:timerName];
    
    if (timer == nil) {
        return;
    }
    
    [timerContainer removeObjectForKey:timerName];
    dispatch_source_cancel(timer);
}
+ (void)cancelAllTimer
{
    [timerContainer enumerateKeysAndObjectsUsingBlock:^(NSString * timerName, dispatch_source_t timer, BOOL * _Nonnull stop) {
        [timerContainer removeObjectForKey:timerName];
        dispatch_source_cancel(timer);
    }];
}

@end
