//
//  NSDate+JXVertification.h
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (JXVertification)

/// 当前日期是否为今天
- (BOOL)jx_isToday;

/// 当前日期是否为昨天
- (BOOL)jx_isYesterday;

/// 两个日期是否为相同一天
+ (BOOL)jx_isSameDayWithDate:(NSDate*)firstDate andDate:(NSDate*)secondDate;

/**
 时间的早晚比较
 
 @param oneTime 时间
 @param anotherTime 时间
 @param dateFormat 时间类型
 @return (-1 oneTime小于anotherTime)(0 oneTime等于anotherTime)(1 oneTime大于anotherTime)
 */
+ (NSInteger)jx_compareTwoTimesOneTime:(NSString *)oneTime anotherTime:(NSString *)anotherTime dateFormat:(NSString *)dateFormat;
@end

NS_ASSUME_NONNULL_END
