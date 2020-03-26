//
//  NSDate+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSDate+JXGeneral.h"

@implementation NSDate (JXGeneral)

+ (NSTimeInterval)getLocalTimestamp
{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [dat timeIntervalSince1970];
    return time;
}
- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] day];
}

- (NSInteger)week
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] weekday];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}
- (NSDate *)jx_dateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)jx_dateByAddingMonths:(NSInteger)months {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)jx_dateByAddingYears:(NSInteger)years {
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

#pragma mark - 与世界标准时间的时差
+ (NSString *)getTimeDifferenceString
{
    //系统时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //时间差
    NSString *abbStr = [zone abbreviation];
    return abbStr;
}

+ (CGFloat)getTimeDifferenceWithUTCTime
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval time = [zone secondsFromGMTForDate:date];
    CGFloat hourTime = time*1.0 / 3600.;
    return hourTime;
}

/**
 计算于现在的时间差
 */
+ (NSInteger)getTimeIntervalWithCurrent:(NSDate *)date
{
    UInt64 time = [date timeIntervalSince1970];
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval currentTime = [nowDate timeIntervalSince1970];
    return (NSInteger)(currentTime - time);
}

/**
 计算时间差
 */
+ (NSInteger)calculatedTimeDifferenceWith:(UInt64)startTime endTime:(UInt64)endTime
{
    if (startTime >= endTime) {
        return 0;
    }else
    {
        NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:startTime];
        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endTime];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        
        NSDateComponents *cmps = [calendar components:type fromDate:startDate toDate:endDate options:0];
        NSInteger day = cmps.day;
        if (cmps.hour > 12 && cmps.hour < 24) {
            day = cmps.day + 1;
        }
        return day;
    }
}

@end
