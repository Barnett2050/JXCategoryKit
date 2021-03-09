//
//  NSDate+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSDate (JXGeneral)

@property (nonatomic, readonly) NSInteger year; /// 年
@property (nonatomic, readonly) NSInteger month; /// 月
@property (nonatomic, readonly) NSInteger day; /// 日
@property (nonatomic, readonly) NSInteger hour; /// 小时
@property (nonatomic, readonly) NSInteger minute; /// 分钟
@property (nonatomic, readonly) NSInteger second; /// 秒
@property (nonatomic, readonly) NSInteger nanosecond; /// 纳秒
@property (nonatomic, readonly) NSInteger weekday; /// 星期单位。范围为1-7 （一个星期有七天）
@property (nonatomic, readonly) NSInteger weekdayOrdinal; /// 每月以7天为单位，范围为1-5 （1-7号为第1个7天，8-14号为第2个7天...）
@property (nonatomic, readonly) NSInteger weekOfMonth; /// 当前月的周数,实际
@property (nonatomic, readonly) NSInteger weekOfYear; /// 当前年的周数
@property (nonatomic, readonly) NSInteger quarter; /// 刻钟单位。范围为1-4 （1刻钟等于15分钟）

/// 当前日期添加年，月，周，日，时，分，秒
- (nullable NSDate *)jx_dateByAddingYears:(NSInteger)years;
- (nullable NSDate *)jx_dateByAddingMonths:(NSInteger)months;
- (nullable NSDate *)jx_dateByAddingWeeks:(NSInteger)weeks;
- (nullable NSDate *)jx_dateByAddingDays:(NSInteger)days;
- (nullable NSDate *)jx_dateByAddingHours:(NSInteger)hours;
- (nullable NSDate *)jx_dateByAddingMinutes:(NSInteger)minutes;
- (nullable NSDate *)jx_dateByAddingSeconds:(NSInteger)seconds;

/**
 获取本地时间戳，单位秒
 */
+ (NSTimeInterval)jx_getLocalTimestamp;
/**
 与世界标准时间的时差
 */
+ (NSString *)jx_getTimeDifferenceString;

/**
 获取当前时区的差值
 */
+ (CGFloat)jx_getTimeDifferenceWithUTCTime;

/**
 计算相对现在的时间差，单位秒，大于0表示小于当前时间，小于0表示大于当前时间
 */
+ (NSTimeInterval)jx_getTimeIntervalWithCurrent:(NSDate *)date;

/**
 计算时间差(单位天)
 */
+ (NSInteger)jx_calculatedTimeDifferenceWith:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime;

@end

NS_ASSUME_NONNULL_END
