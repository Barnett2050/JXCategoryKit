//
//  NSDate+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSDate+JXGeneral.h"

@implementation NSDate (JXGeneral)

- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (NSDate *)jx_dateByAddingYears:(NSInteger)years
{
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)jx_dateByAddingMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)jx_dateByAddingWeeks:(NSInteger)weeks
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)jx_dateByAddingDays:(NSInteger)days
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)jx_dateByAddingHours:(NSInteger)hours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 3600 * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)jx_dateByAddingMinutes:(NSInteger)minutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 60 * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)jx_dateByAddingSeconds:(NSInteger)seconds
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSTimeInterval)jx_getLocalTimestamp
{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [dat timeIntervalSince1970];
    return time;
}

+ (NSString *)jx_getTimeDifferenceString
{
    //系统时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //时间差
    NSString *abbStr = [zone abbreviation];
    return abbStr;
}

+ (CGFloat)jx_getTimeDifferenceWithUTCTime
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
+ (NSInteger)jx_getTimeIntervalWithCurrent:(NSDate *)date
{
    UInt64 time = [date timeIntervalSince1970];
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval currentTime = [nowDate timeIntervalSince1970];
    return (NSInteger)(currentTime - time);
}

/**
 计算时间差
 */
+ (NSInteger)jx_calculatedTimeDifferenceWith:(UInt64)startTime endTime:(UInt64)endTime
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
