//
//  NSDateFormatter+JXConversion.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/10.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (JXConversion)

/// 根据日期格式时间字符串转NSDate
- (NSDate *)jx_getDateFromDateString:(NSString *)string format:(NSString *)format;

/// 根据日期格式转化时间戳(UTC)
/// @param timestamp 时间戳,秒，毫秒均可
/// @param format 时间格式
- (NSString *)jx_getDateTimeStringFromTimestamp:(NSTimeInterval)timestamp format:(NSString *)format;

/// 根据日期格式转化时间戳字符串(UTC)
/// @param timestamp 时间戳字符串
/// @param format 时间格式
- (NSString *)jx_getDateTimeStringFromTimestampString:(NSString *)timestamp format:(NSString *)format;

/// 根据日期格式转化时间字符串为时间戳(UTC)
/// @param timeStr 时间字符串
/// @param format 时间格式
/// @param isMilliSecond 是否为毫秒
- (NSTimeInterval)jx_getTimestampFromString:(NSString *)timeStr format:(NSString *)format isMilliSecond:(BOOL)isMilliSecond;

/// 时间戳转n小时、分钟、秒前 或者yyyy-MM-dd HH:mm:ss
/// @param timestamp 时间戳
- (NSString *)jx_getBeforeTimeFromTimestamp:(NSString *)timestamp;

@end

NS_ASSUME_NONNULL_END
