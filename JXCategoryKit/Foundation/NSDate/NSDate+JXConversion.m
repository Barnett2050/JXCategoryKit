//
//  NSDate+JXConversion.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSDate+JXConversion.h"

@implementation NSDate (JXConversion)

+ (NSString *)jx_getSystemDateTimeWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // HH是24进制，hh是12进制 EEEE是星期 a是AM或PM  @"yyyy-MM-dd a HH:mm:ss EEEE"
    formatter.dateFormat = format;
    NSString *dateStr = [formatter stringFromDate:[self date]];
    return dateStr;
}

+ (NSDate *)jx_getDateFromDateString:(NSString *)string format:(NSString *)format
{
    if (string.length < 1 || !string) return [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

+ (NSString *)jx_getDateTimeStringFromTimestamp:(NSTimeInterval)timestamp format:(NSString *)format
{
    BOOL isMilliSecond = timestamp > 140000000000;
    NSDate *date;
    if (isMilliSecond) {
        date = [NSDate dateWithTimeIntervalSince1970:(timestamp/1000)];
    }else
    {
        date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSString *)jx_getDateTimeStringFromTimestampString:(NSString *)timestamp format:(NSString *)format
{
    if (timestamp.length < 1 || !timestamp) return @"";
    
    double time = [timestamp doubleValue];
    return [NSDate jx_getDateTimeStringFromTimestamp:time format:format];
}

+ (NSTimeInterval)jx_getTimestampFromString:(NSString *)timeStr format:(NSString *)format isMilliSecond:(BOOL)isMilliSecond
{
    if (timeStr.length < 1 || !timeStr) return 0;
    
    NSDate *date = [NSDate dateFromString:timeStr format:format];
    UInt64 time;
    if (isMilliSecond) {
        time = [date timeIntervalSince1970]*1000;
    }else
    {
        time = [date timeIntervalSince1970];
    }
    return time;
}

+ (NSString *)jx_getBeforeTimeFromTimestamp:(NSString *)timestamp
{
    if (timestamp.length < 1 || !timestamp) return @"";
    NSDate *date;
    BOOL isMilliSecond = [timestamp doubleValue] > 140000000000;
    if (isMilliSecond) {
        date = [NSDate dateWithTimeIntervalSince1970:timestamp.longLongValue/1000];
    }else
    {
        date = [NSDate dateWithTimeIntervalSince1970:timestamp.longLongValue];
    }
    NSString * strBefore = @"";
    if (date && (id)date != [NSNull null]) {
        NSInteger interval = -(NSInteger)[date timeIntervalSinceNow];
        NSInteger nDay = interval / (60 * 60 * 24);
        NSInteger nHour = interval / (60 * 60);
        NSInteger nMin = interval / 60;
        NSInteger nSec = interval;
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        if (nDay > 0) {
            strBefore = [df stringFromDate:date];
        }
        else if (nHour > 0) {
            strBefore = [NSString stringWithFormat:@"%li小时前",(long)nHour];
        }
        else if (nMin > 0) {
            strBefore = [NSString stringWithFormat:@"%li分钟前",(long)nMin];
        }
        else if (nSec > 0) {
            strBefore = [NSString stringWithFormat:@"%li秒前",(long)nSec];
        }
        else
            strBefore = @"刚刚";
    }
    return strBefore;
}

+ (NSString *)jx_getHHMMSSFromSS:(NSInteger)totalSecond format:(nullable NSString *)format
{
    if (totalSecond <= 0) {
        return @"";
    }
    NSString *formatStr;
    if (format == nil) {
        formatStr = @"hh:mm:ss";
    }else
    {
        formatStr = format;
    }
    
    formatStr = [formatStr lowercaseString];
    NSString *format_time;
    
    NSInteger seconds = totalSecond % 60;
    NSInteger minutes = (totalSecond / 60) % 60;
    NSInteger hours = ((totalSecond / 60) / 60) % 24;
    
    //format of hour
    NSString *str_hour;
    if ([formatStr containsString:@"hh"]) {
        str_hour = [NSString stringWithFormat:@"%02ld",hours];
        format_time = [formatStr stringByReplacingOccurrencesOfString:@"hh" withString:str_hour];
    }else if ([formatStr containsString:@"h"])
    {
        str_hour = [NSString stringWithFormat:@"%ld",hours];
        format_time = [formatStr stringByReplacingOccurrencesOfString:@"h" withString:str_hour];
    }
    //format of minute
    NSString *str_minute;
    if ([formatStr containsString:@"mm"]) {
        str_minute = [NSString stringWithFormat:@"%02ld",minutes];
        format_time = [format_time stringByReplacingOccurrencesOfString:@"mm" withString:str_minute];
    }else if ([formatStr containsString:@"m"])
    {
        str_minute = [NSString stringWithFormat:@"%ld",minutes];
        format_time = [format_time stringByReplacingOccurrencesOfString:@"m" withString:str_minute];
    }
    //format of second
    NSString *str_second;
    if ([formatStr containsString:@"ss"]) {
        str_second = [NSString stringWithFormat:@"%02ld",seconds];
        format_time = [format_time stringByReplacingOccurrencesOfString:@"ss" withString:str_second];
    }else if ([formatStr containsString:@"s"])
    {
        str_second = [NSString stringWithFormat:@"%ld",seconds];
        format_time = [format_time stringByReplacingOccurrencesOfString:@"s" withString:str_second];
    }

    return format_time;
}

/**  时间戳根据格式返回数据 HH:mm、昨天 HH:mm、MM月dd日 HH:mm、yyyy年MM月dd日)*/
+ (NSString *)getVariableFormatDateStringFromTimestamp:(NSString *)timestamp
{
    if (timestamp.length < 1 || !timestamp) return @"";
    BOOL isMilliSecond = [timestamp doubleValue] > 140000000000;
    NSDate *date;
    if (isMilliSecond) {
        date = [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue] / 1000];
    }else
    {
        date = [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue]];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([NSDate isToday:date]) {
        // 同一天
        [formatter setDateFormat:@"HH:mm"];
        return [formatter stringFromDate:date];
    } else if ([NSDate isYesterday:date]) {
        // 昨天
        [formatter setDateFormat:@"昨天 HH:mm"];
        return [formatter stringFromDate:date];
    } else if ([NSDate isSameYear:[NSDate date] date2:date]) {
        // 同一年
        [formatter setDateFormat:@"M月dd日 HH:mm"];
        return [formatter stringFromDate:date];
    } else {
        // 不同年
        [formatter setDateFormat:@"yyyy年M月dd日"];
        return [formatter stringFromDate:date];
    }
}

- (NSString *)getDateTimeStringWithformat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *currentDate = [dateFormatter stringFromDate:self];
    return currentDate;
}

+ (NSString *)jx_getLocalPopularTimeFromTimestamp:(NSString *)timestamp
{
    if (timestamp.length < 1 || !timestamp) return @"";
    
    double value = timestamp.doubleValue;
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [dat timeIntervalSince1970];
    if (time <= value) {
        return @"刚刚";
    }

    BOOL isMilliSecond = [timestamp doubleValue] > 140000000000;
    NSDate *expireDate;
    if (isMilliSecond) {
        expireDate = [NSDate dateWithTimeIntervalSince1970:value/1000];
    }else
    {
        expireDate = [NSDate dateWithTimeIntervalSince1970:value];
    }
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];
    
    NSString *returnStr;
    int jxYear = abs((int)dateCom.year);
    int jxMonth = abs((int)dateCom.month);
    int jxDay = abs((int)dateCom.day);
    int jxHour = abs((int)dateCom.hour);
    int jxMinute = abs((int)dateCom.minute);
    
    if(jxYear != 0)
    {
        returnStr = [NSString stringWithFormat:@"%d年前",jxYear];
    }else if (jxMonth != 0)
    {
        returnStr = [NSString stringWithFormat:@"%d月前",jxMonth];
    }else if (jxDay != 0)
    {
        returnStr = [NSString stringWithFormat:@"%d天前",jxDay];
    }
    else if(jxHour != 0)
    {
        returnStr = [NSString stringWithFormat:@"%d小时前",jxHour];
    }else if(jxMinute > 1 && jxMinute < 60)
    {
        returnStr = [NSString stringWithFormat:@"%d分钟前",jxMinute];
    }else
    {
        returnStr = @"刚刚";
    }
    return returnStr;
}

#pragma mark - private
+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}
+ (BOOL)isToday:(NSDate*)date {
    if (fabs(date.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    NSInteger day = [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date] day];
    NSInteger nowDay = [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:[NSDate new]] day];
    return nowDay == day;
}

+ (BOOL)isYesterday:(NSDate*)date {
    NSTimeInterval aTimeInterval = [date timeIntervalSinceReferenceDate] + 86400 * 1;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [NSDate isToday:newDate];
}

+ (BOOL)isSameYear:(NSDate *)date1 date2:(NSDate*)date2 {
    NSInteger year1 = [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date1] year];
    NSInteger year2 = [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:date2] year];
    if (year1 != year2) {
        return NO;
    }
    return YES;
}
@end
