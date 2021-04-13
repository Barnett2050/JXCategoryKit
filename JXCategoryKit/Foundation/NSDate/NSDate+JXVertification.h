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

/// 时间的早晚比较
/// @param oneTime 时间戳字符串，时间字符串
/// @param anotherTime 时间戳字符串，时间字符串
/// @param format 传入format为nil时比较时间字符串，有相应值时比较时间戳字符串
/// @param compare 比较结果，数组为从小到大排序
+ (void)jx_compareTwoTimesOneTime:(NSString *)oneTime anotherTime:(NSString *)anotherTime format:(NSString *)format compare:(void(^)(NSComparisonResult comparisionResult,NSArray *resultArray))compare;

@end

NS_ASSUME_NONNULL_END
