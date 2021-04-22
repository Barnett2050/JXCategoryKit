//
//  NSDateFormatter+JXConversion.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/10.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSDateFormatter+JXConversion.h"

@implementation NSDateFormatter (JXConversion)

- (NSDate *)jx_getDateFromDateString:(NSString *)string format:(NSString *)format
{
    if (string.length < 1 || !string) return [NSDate date];
    
    self.dateFormat = format;
    NSDate *date = [self dateFromString:string];
    return date;
}
- (NSString *)jx_getDateTimeStringFromTimestamp:(NSTimeInterval)timestamp format:(NSString *)format
{
    BOOL isMilliSecond = timestamp > 140000000000;
    NSDate *date;
    if (isMilliSecond) {
        date = [NSDate dateWithTimeIntervalSince1970:(timestamp/1000)];
    }else
    {
        date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    }
    self.dateFormat = format;
    NSString *dateStr = [self stringFromDate:date];
    return dateStr;
}

- (NSString *)jx_getDateTimeStringFromTimestampString:(NSString *)timestamp format:(NSString *)format
{
    if (timestamp.length < 1 || !timestamp) return @"";
    double time = [timestamp doubleValue];
    return [self jx_getDateTimeStringFromTimestamp:time format:format];
}

- (NSTimeInterval)jx_getTimestampFromString:(NSString *)timeStr format:(NSString *)format isMilliSecond:(BOOL)isMilliSecond
{
    if (timeStr.length < 1 || !timeStr) return 0;
    
    NSDate *date = [self p_dateFromString:timeStr format:format];
    UInt64 time;
    if (isMilliSecond) {
        time = [date timeIntervalSince1970]*1000;
    }else
    {
        time = [date timeIntervalSince1970];
    }
    return time;
}

- (NSString *)jx_getBeforeTimeFromTimestamp:(NSString *)timestamp
{
    if (timestamp.length < 1 || !timestamp) return @"";
    NSDate *date;
    BOOL isMilliSecond = [timestamp doubleValue] > 140000000000;
    if (isMilliSecond) {
        date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue/1000];
    }else
    {
        date = [NSDate dateWithTimeIntervalSince1970:timestamp.doubleValue];
    }
    NSString * strBefore = @"";
    if (date && (id)date != [NSNull null]) {
        NSInteger interval = fabsl([date timeIntervalSinceNow]);
        NSInteger nDay = interval / (60 * 60 * 24);
        NSInteger nHour = interval / (60 * 60);
        NSInteger nMin = interval / 60;
        NSInteger nSec = interval;
        
        if (nDay > 0) {
            self.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            strBefore = [self stringFromDate:date];
        }else if (nHour > 0) {
            strBefore = [NSString stringWithFormat:@"%li小时前",(long)nHour];
        }else if (nMin > 0) {
            strBefore = [NSString stringWithFormat:@"%li分钟前",(long)nMin];
        }else if (nSec > 0) {
            strBefore = [NSString stringWithFormat:@"%li秒前",(long)nSec];
        }else
            strBefore = @"刚刚";
    }
    return strBefore;
}
- (NSString *)jx_getVariableFormatDateStringFromTimestamp:(NSString *)timestamp
{
    if (timestamp.length < 1 || !timestamp) return @"";
    BOOL isMilliSecond = [timestamp doubleValue] > 140000000000;
    NSDate *date;
    if (isMilliSecond) {
        date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue] / 1000];
    }else
    {
        date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    }
    
    if ([self p_isToday:date]) {
        // 同一天
        [self setDateFormat:@"HH:mm"];
        return [self stringFromDate:date];
    } else if ([self p_isYesterday:date]) {
        // 昨天
        [self setDateFormat:@"昨天 HH:mm"];
        return [self stringFromDate:date];
    } else if ([self p_isSameYear:[NSDate date] date2:date]) {
        // 同一年
        [self setDateFormat:@"M月dd日 HH:mm"];
        return [self stringFromDate:date];
    } else {
        // 不同年
        [self setDateFormat:@"yyyy年M月dd日"];
        return [self stringFromDate:date];
    }
}

#pragma mark - private
- (NSDate *)p_dateFromString:(NSString *)timeStr
                    format:(NSString *)format
{
    self.dateFormat = format;
    NSDate *date = [self dateFromString:timeStr];
    return date;
}

- (BOOL)p_isToday:(NSDate*)date {
    if (fabs(date.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    NSInteger day = [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date] day];
    NSInteger nowDay = [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:[NSDate new]] day];
    return nowDay == day;
}

- (BOOL)p_isYesterday:(NSDate *)date {
    NSTimeInterval aTimeInterval = [date timeIntervalSinceReferenceDate] + 86400 * 1;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self p_isToday:newDate];
}

- (BOOL)p_isSameYear:(NSDate *)date1 date2:(NSDate*)date2 {
    NSInteger year1 = [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date1] year];
    NSInteger year2 = [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date2] year];
    if (year1 != year2) {
        return NO;
    }
    return YES;
}

@end
