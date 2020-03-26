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

/**
 获取本地时间戳
 */
+ (NSTimeInterval)getLocalTimestamp;

/**
 获取当前日期的星期，日，月，年
 */
- (NSInteger)week;// 国外星期日视为第一天
- (NSInteger)day;
- (NSInteger)month;
- (NSInteger)year;

/// 当前日期添加日，月，年
- (NSDate *)jx_dateByAddingDays:(NSInteger)days;
- (NSDate *)jx_dateByAddingMonths:(NSInteger)months;
- (NSDate *)jx_dateByAddingYears:(NSInteger)years;

/**
 与世界标准时间的时差
 */
+ (NSString *)getTimeDifferenceString;

/**
 获取当前时区的差值
 */
+ (CGFloat)getTimeDifferenceWithUTCTime;

/**
 计算于现在的时间差
 */
+ (NSInteger)getTimeIntervalWithCurrent:(NSDate *)date;

/**
 计算时间差(单位天)
 */
+ (NSInteger)calculatedTimeDifferenceWith:(UInt64)startTime endTime:(UInt64)endTime;

@end

NS_ASSUME_NONNULL_END
