//
//  NSDate+JXVertification.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSDate+JXVertification.h"

@implementation NSDate (JXVertification)

- (BOOL)isToday
{
    return [[NSDate acquireDayMonthYearFromDate:self] isEqualToDate:[NSDate acquireDayMonthYearFromDate:[NSDate date]]];
}
- (BOOL)isYesterday
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [newDate isToday];
}

+ (BOOL)isSameDayWithDate:(NSDate *)firstDate andDate:(NSDate *)secondDate {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:firstDate];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:secondDate];
    
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year] == [comp2 year];
}

+ (NSInteger)compareTwoTimesOneTime:(NSString *)oneTime AnotherTime:(NSString *)anotherTime TimeDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:dateFormat];
    NSDate *oneDate =[format dateFromString:oneTime];
    NSDate *anotherDate = [format dateFromString:anotherTime];
    NSComparisonResult result = [oneDate compare:anotherDate];
    switch (result) {
        case NSOrderedAscending:{
            // oneDate 小于 anotherDate
            return -1;
        }
            break;
        case NSOrderedSame:{
            // oneDate 等于 anotherDate
            return 0;
        }
            break;
        case NSOrderedDescending:{
            // oneDate 大于 anotherDate
            return 1;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - private
/**
 获取日期年月日
 */
+ (NSDate*)acquireDayMonthYearFromDate:(NSDate*)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comps = [calendar components:unitFlags fromDate:date];
    NSDate* result = [calendar dateFromComponents:comps];
    return result;
}
- (void)pleaseInsertStarTimeo:(NSString *)time1 andInsertEndTime:(NSString *)time2
{
    // 1.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
    // 2.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 3.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    // 4.输出结果
    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
}

@end
