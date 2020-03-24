//
//  NSTimer+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (JXGeneral)

/**
 scheduled方法创建timer
 */
+ (NSTimer *)bk_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval repeats:(BOOL)inRepeats block:(void (^)(NSTimer *timer))inBlock;

/**
 timer方法创建timer
 */
+ (NSTimer *)bk_timerWithTimeInterval:(NSTimeInterval)inTimeInterval repeats:(BOOL)inRepeats block:(void (^)(NSTimer *timer))inBlock;

/// 暂停
- (void)pauseTimer;

/// 恢复
- (void)resumeTimer;

/// 过一段时间继续
/// @param interval 时间间隔
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end

NS_ASSUME_NONNULL_END
