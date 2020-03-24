//
//  NSTimer+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSTimer+JXGeneral.h"

@implementation NSTimer (JXGeneral)

+ (NSTimer *)bk_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval repeats:(BOOL)inRepeats block:(void (^)(NSTimer *timer))inBlock
{
    NSParameterAssert(inBlock != nil);
    // "scheduledTimer"前缀的为自动启动NSTimer的,(启动NSTimer本质上是将其加入RunLoop中)
    if (@available(iOS 10.0,*)) {
        return [self scheduledTimerWithTimeInterval:inTimeInterval repeats:inRepeats block:inBlock];
    }else
    {
        return [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(bk_executeBlockFromTimer:) userInfo:[inBlock copy] repeats:inRepeats];
    }
}

+ (NSTimer *)bk_timerWithTimeInterval:(NSTimeInterval)inTimeInterval repeats:(BOOL)inRepeats block:(void (^)(NSTimer *timer))inBlock
{
    NSParameterAssert(inBlock != nil);
    // "timer"前缀的为只构造不启用的
    if (@available(iOS 10.0,*)) {
        return [self timerWithTimeInterval:inTimeInterval repeats:inRepeats block:inBlock];
    }else
    {
        return [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(bk_executeBlockFromTimer:) userInfo:[inBlock copy] repeats:inRepeats];
    }
}

-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];//暂停， distantFuture（不可达到的未来的某个时间点）
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];//继续
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

#pragma mark - private
+ (void)bk_executeBlockFromTimer:(NSTimer *)aTimer {
    void (^block)(NSTimer *) = [aTimer userInfo];
    if (block) block(aTimer);
}

@end
