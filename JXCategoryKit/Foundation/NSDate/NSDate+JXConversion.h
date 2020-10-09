//
//  NSDate+JXConversion.h
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (JXConversion)

#pragma mark - NSDate
/// 根据日期格式获取系统时间
/// @param format 日期格式
+ (NSString *)jx_getSystemDateTimeWithFormat:(NSString *)format;

/// 根据日期格式时间字符串转NSDate
+ (NSDate *)jx_getDateFromDateString:(NSString *)string format:(NSString *)format;

/// 根据日期格式转化时间戳(UTC)
/// @param timestamp 时间戳,秒，毫秒均可
/// @param format 时间格式
+ (NSString *)jx_getDateTimeStringFromTimestamp:(NSTimeInterval)timestamp format:(NSString *)format;

/// 根据日期格式转化时间戳字符串(UTC)
/// @param timestamp 时间戳字符串
/// @param format 时间格式
+ (NSString *)jx_getDateTimeStringFromTimestampString:(NSString *)timestamp format:(NSString *)format;

/// 根据日期格式转化时间字符串为时间戳(UTC)
/// @param timeStr 时间字符串
/// @param format 时间格式
/// @param isMilliSecond 是否为毫秒
+ (NSTimeInterval)jx_getTimestampFromString:(NSString *)timeStr format:(NSString *)format isMilliSecond:(BOOL)isMilliSecond;

/// 时间戳转n小时、分钟、秒前 或者yyyy-MM-dd HH:mm:ss
/// @param timestamp 时间戳
+ (NSString *)jx_getBeforeTimeFromTimestamp:(NSString *)timestamp;

/// 将秒根据格式转换，限于时分秒
/// @param totalSecond 秒
/// @param format 格式,h小时 m分钟 s秒，hh代表不够补零,默认hh:mm:ss
+ (NSString *)jx_getHHMMSSFromSS:(NSInteger)totalSecond format:(nullable NSString *)format;

/**  时间戳根据格式返回数据 HH:mm / 昨天 HH:mm / MM月dd日 HH:mm / yyyy年MM月dd日 */
+ (NSString *)jx_getVariableFormatDateStringFromTimestamp:(NSString *)timestamp;

/// 根据日期格式Date转时间字符串
/// @param format 格式
- (NSString *)jx_getDateTimeStringWithformat:(NSString *)format;

#pragma mark - NSCalendar
/// 时间戳UTC转换为本地时间，例：几分钟前，几小时前，几天前，几月前，几年前
/// @param timestamp 时间戳
+ (NSString *)jx_getLocalPopularTimeFromTimestamp:(NSString *)timestamp;

@end

NS_ASSUME_NONNULL_END
