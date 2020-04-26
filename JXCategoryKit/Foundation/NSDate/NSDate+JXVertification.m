//
//  NSDate+JXVertification.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSDate+JXVertification.h"

@implementation NSDate (JXVertification)

- (BOOL)jx_isToday
{
    return [[NSDate p_acquireDayMonthYearFromDate:self] isEqualToDate:[NSDate p_acquireDayMonthYearFromDate:[NSDate date]]];
}
- (BOOL)jx_isYesterday
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [newDate jx_isToday];
}

+ (BOOL)jx_isSameDayWithDate:(NSDate *)firstDate andDate:(NSDate *)secondDate {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:firstDate];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:secondDate];
    
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year] == [comp2 year];
}

+ (NSInteger)jx_compareTwoTimesOneTime:(NSString *)oneTime AnotherTime:(NSString *)anotherTime TimeDateFormat:(NSString *)dateFormat
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
+ (NSDate*)p_acquireDayMonthYearFromDate:(NSDate*)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comps = [calendar components:unitFlags fromDate:date];
    NSDate* result = [calendar dateFromComponents:comps];
    return result;
}


@end
