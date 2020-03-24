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
 scheduled方法快速创建timer
 */
+ (NSTimer *)jx_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval repeats:(BOOL)inRepeats block:(void (^)(NSTimer *timer))inBlock;

/**
 timer方法快速创建timer
 */
+ (NSTimer *)jx_timerWithTimeInterval:(NSTimeInterval)inTimeInterval repeats:(BOOL)inRepeats block:(void (^)(NSTimer *timer))inBlock;

/// 暂停Timer
- (void)jx_pauseTimer;

/// 恢复Timer
- (void)jx_resumeTimer;

/// 过一段时间继续Timer
/// @param interval 时间间隔
- (void)jx_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end

NS_ASSUME_NONNULL_END
