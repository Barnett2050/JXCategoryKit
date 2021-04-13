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
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    NSInteger day = [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
    NSInteger nowDay = [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:[NSDate new]] day];
    return nowDay == day;
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

+ (void)jx_compareTwoTimesOneTime:(NSString *)oneTime anotherTime:(NSString *)anotherTime format:(NSString *)format compare:(void(^)(NSComparisonResult comparisionResult,NSArray *resultArray))compare
{
    if (oneTime.length == 0 || anotherTime.length == 0) {
        return;
    }
    if (format != nil && format.length > 0) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        NSDate *oneDate = [formatter dateFromString:oneTime];
        NSDate *anotherDate = [formatter dateFromString:anotherTime];
        NSComparisonResult result = [oneDate compare:anotherDate];
        NSArray *array = nil;
        switch (result) {
            case NSOrderedAscending:
            case NSOrderedSame:
            {
                // 升序 oneTime 小于 anotherTime
                array = @[oneTime,anotherTime];
            }
                break;
            case NSOrderedDescending:{
                // 降序 oneTime 大于 oneTime
                array = @[anotherTime,oneTime];
            }
                break;
                
            default:
                break;
        }
        compare(result,array);
    } else {
        NSTimeInterval oneTimeInterval = [oneTime doubleValue];
        NSTimeInterval anotherTimeInterval = [anotherTime doubleValue];
        if (oneTimeInterval > 140000000000) {
            oneTimeInterval = oneTimeInterval / 1000;
        }
        if (anotherTimeInterval > 140000000000) {
            anotherTimeInterval = anotherTimeInterval / 1000;
        }
        NSArray *array = nil;
        NSComparisonResult comparisionResult = NSOrderedDescending;
        if (oneTimeInterval > anotherTimeInterval) {
            array = @[anotherTime,oneTime];
        } else if (oneTimeInterval == anotherTimeInterval) {
            comparisionResult = NSOrderedSame;
            array = @[oneTime,anotherTime];
        } else {
            comparisionResult = NSOrderedAscending;
            array = @[oneTime,anotherTime];
        }
        compare(comparisionResult,array);
    }
}

@end
