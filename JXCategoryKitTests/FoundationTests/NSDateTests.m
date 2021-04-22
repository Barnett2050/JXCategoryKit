//
//  NSDateTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2020/5/7.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSDate+JXConversion.h"
#import "NSDate+JXGeneral.h"
#import "NSDate+JXVertification.h"
#import "NSDateFormatter+JXConversion.h"

@interface NSDateTests : XCTestCase

@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NSString *currentDateString;
@property (nonatomic, assign) NSTimeInterval currentTimeInterval;

@property (nonatomic, strong) NSDate *ascendingDate;
@property (nonatomic, strong) NSString *ascendingDateString;
@property (nonatomic, assign) NSTimeInterval ascendingTimeInterval;

@property (nonatomic, strong) NSDate *descendingDate;
@property (nonatomic, strong) NSString *descendingDateString;
@property (nonatomic, assign) NSTimeInterval descendingTimeInterval;

@end

@implementation NSDateTests

- (void)setUp {
    self.currentTimeInterval = 1615182888000;
    self.currentDate = [[NSDate alloc] initWithTimeIntervalSince1970:self.currentTimeInterval / 1000];
    self.currentDateString = @"2021-03-08 13:54:48";
    
    self.descendingTimeInterval = 1615097111000;
    self.descendingDate = [[NSDate alloc] initWithTimeIntervalSince1970:self.descendingTimeInterval / 1000];
    self.descendingDateString = @"2021-03-07 14:05:11";
    
    self.ascendingTimeInterval = 1615097111000;
    self.ascendingDate = [[NSDate alloc] initWithTimeIntervalSince1970:self.ascendingTimeInterval / 1000];
    self.ascendingDateString = @"2021-03-07 14:05:11";
}

- (void)tearDown {
}

- (void)test_JXConversion
{
    NSString *current = [NSDate jx_getSystemDateTimeWithFormat:@"yyyy-MM-dd a HH:mm:ss EEEE"];
    NSLog(@"系统日期 = %@",current);
    
    NSDate *date = [NSDate jx_getDateFromDateString:self.currentDateString format:@"yyyy-MM-dd HH:mm:ss"];
    XCTAssertTrue(date != nil && [date isKindOfClass:[NSDate class]],@"时间字符串转为date");
    
    NSString *timeString = [NSDate jx_getDateTimeStringFromTimestampString:@"1615182888000" format:@"yyyy-MM-dd HH:mm:ss"];
    XCTAssertTrue(timeString.length != 0 && [timeString isEqualToString:self.currentDateString],@"时间戳字符串转为时间字符串");
    
    double timestamp = [NSDate jx_getTimestampFromString:self.currentDateString format:@"yyyy-MM-dd HH:mm:ss" isMilliSecond:true];
    XCTAssertTrue(timestamp != 0 && timestamp == self.currentTimeInterval,@"时间字符串转为时间戳");
    
    NSTimeInterval timeInterval = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString *timeIntervalString1 = [NSString stringWithFormat:@"%f",timeInterval];
    XCTAssertTrue([[NSDate jx_getBeforeTimeFromTimestamp:timeIntervalString1] isEqualToString:@"刚刚"],@"");
    
    NSString *timeIntervalString2 = [NSString stringWithFormat:@"%f",timeInterval - 30];
    XCTAssertTrue([[NSDate jx_getBeforeTimeFromTimestamp:timeIntervalString2] isEqualToString:@"30秒前"],@"");
    
    NSString *timeIntervalString3 = [NSString stringWithFormat:@"%f",timeInterval - 300];
    XCTAssertTrue([[NSDate jx_getBeforeTimeFromTimestamp:timeIntervalString3] isEqualToString:@"5分钟前"],@"");
    
    NSString *timeIntervalString4 = [NSString stringWithFormat:@"%f",timeInterval - 7200];
    XCTAssertTrue([[NSDate jx_getBeforeTimeFromTimestamp:timeIntervalString4] isEqualToString:@"2小时前"],@"");
    
    NSString *secondString1 = [NSDate jx_getHHMMSSFromSS:3596 format:nil];
    NSString *secondString2 = [NSDate jx_getHHMMSSFromSS:3546 format:@"mm:ss"];
    NSString *secondString3 = [NSDate jx_getHHMMSSFromSS:3546 format:@"m:s"];
    XCTAssertTrue([secondString1 isEqualToString:@"00:59:56"],@"秒转换为固定格式");
    XCTAssertTrue([secondString2 isEqualToString:@"59:06"],@"秒转换为固定格式");
    XCTAssertTrue([secondString3 isEqualToString:@"59:6"],@"秒转换为固定格式");

    
    NSString *timestampString = [NSString stringWithFormat:@"%.f",timeInterval];
    NSDate *currentDate = [[NSDate alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    XCTAssertTrue([[NSDate jx_getVariableFormatDateStringFromTimestamp:timestampString] isEqualToString:[formatter stringFromDate:currentDate]],@"");
    XCTAssertTrue([[NSDate jx_getLocalPopularTimeFromTimestamp:timestampString] isEqualToString:@"刚刚"]);
    
    timeInterval = timeInterval - 60 * 60 * 24;
    currentDate = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterval];
    timestampString = [NSString stringWithFormat:@"%.f",timeInterval];
    formatter.dateFormat = @"昨天 HH:mm";
    XCTAssertTrue([[NSDate jx_getVariableFormatDateStringFromTimestamp:timestampString] isEqualToString:[formatter stringFromDate:currentDate]],@"");
    XCTAssertTrue([[NSDate jx_getLocalPopularTimeFromTimestamp:timestampString] isEqualToString:@"1天前"]);
    
    timeInterval = timeInterval - 30 * 60 * 60 * 24;
    currentDate = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterval];
    timestampString = [NSString stringWithFormat:@"%.f",timeInterval];
    formatter.dateFormat = @"M月dd日 HH:mm";
    XCTAssertTrue([[NSDate jx_getVariableFormatDateStringFromTimestamp:timestampString] isEqualToString:[formatter stringFromDate:currentDate]],@"");
    XCTAssertTrue([[NSDate jx_getLocalPopularTimeFromTimestamp:timestampString] isEqualToString:@"1月前"]);
 
    timeInterval = timeInterval - 12 * 30 * 60 * 60 * 24;
    currentDate = [[NSDate alloc] initWithTimeIntervalSince1970:timeInterval];
    timestampString = [NSString stringWithFormat:@"%.f",timeInterval];
    formatter.dateFormat = @"yyyy年M月dd日";
    XCTAssertTrue([[NSDate jx_getVariableFormatDateStringFromTimestamp:timestampString] isEqualToString:[formatter stringFromDate:currentDate]],@"");
    XCTAssertTrue([[NSDate jx_getLocalPopularTimeFromTimestamp:timestampString] isEqualToString:@"1年前"]);
    
    XCTAssertTrue([[self.currentDate jx_getDateTimeStringWithformat:@"yyyy-MM-dd HH:mm:ss"] isEqualToString:self.currentDateString],@"根据日期格式Date转时间字符串");
}

- (void)test_JXGeneral
{
    NSDate *date = self.currentDate;
    XCTAssertTrue(date.year == 2021,@"年");
    XCTAssertTrue(date.month == 3,@"月");
    XCTAssertTrue(date.day == 8,@"日");
    XCTAssertTrue(date.hour == 13,@"小时");
    XCTAssertTrue(date.minute == 54,@"分");
    XCTAssertTrue(date.second == 48,@"秒");
    XCTAssertTrue(date.weekday == 2,@"星期单位");
    XCTAssertTrue(date.weekdayOrdinal == 2,@"第几个星期");
    XCTAssertTrue(date.weekOfMonth == 2,@"一个月中第几个星期");
    XCTAssertTrue(date.weekOfYear == 11,@"一年中第几个星期");
    XCTAssertTrue(date.quarter == 0,@"一小时中第几个刻钟");
    
    date = [date jx_dateByAddingYears:5];
    XCTAssertTrue(date.year == 2026,@"年");
    date = [date jx_dateByAddingMonths:5];
    XCTAssertTrue(date.month == 8,@"月");
    date = [date jx_dateByAddingDays:10];
    XCTAssertTrue(date.day == 18,@"日");
    date = [date jx_dateByAddingHours:3];
    XCTAssertTrue(date.hour == 16,@"小时");
    date = [date jx_dateByAddingMinutes:16];
    XCTAssertTrue(date.minute == 10,@"分");
    date = [date jx_dateByAddingSeconds:22];
    XCTAssertTrue(date.second == 10,@"秒");
    date = [date jx_dateByAddingWeeks:0];
    XCTAssertTrue(date.weekdayOrdinal == 3,@"第几个星期");
    XCTAssertTrue(date.weekOfMonth == 4,@"一个月中第几个星期");
    NSLog(@"========%@",date.description);
    
    NSLog(@"本地时间戳：%f",[NSDate jx_getLocalTimestamp]);
    XCTAssertTrue([[NSDate jx_getTimeDifferenceString] isEqualToString:@"GMT+8"],@"时差");
    XCTAssertTrue([NSDate jx_getTimeDifferenceWithUTCTime] == 8,@"获取当前时区的差值");
    NSLog(@"计算相对现在的时间差:%f",[NSDate jx_getTimeIntervalWithCurrent:self.currentDate]);
    XCTAssertTrue([NSDate jx_calculatedTimeDifferenceWith:self.currentTimeInterval endTime:self.ascendingTimeInterval] == 1,@"计算时间差(单位天)");
    XCTAssertTrue([NSDate jx_calculatedTimeDifferenceWith:self.currentTimeInterval endTime:self.descendingTimeInterval] == 1,@"计算时间差(单位天)");
}

- (void)test_JXVertification
{
    NSDate *date = [[NSDate alloc] init];
    NSDate *newDate = [date jx_dateByAddingDays:-1];
    XCTAssertTrue([date jx_isToday],@"日期是今天");
    XCTAssertFalse([newDate jx_isToday],@"日期不是今天");
    XCTAssertTrue([newDate jx_isYesterday],@"日期是否为昨天");
    XCTAssertFalse([date jx_isYesterday],@"日期是否为昨天");
    
    XCTAssertTrue([NSDate jx_isSameDayWithDate:date andDate:[date jx_dateByAddingHours:-1]],@"日期为同一天");
    XCTAssertFalse([NSDate jx_isSameDayWithDate:date andDate:newDate],@"日期不为同一天");
    
    
    [NSDate jx_compareTwoTimesOneTime:@"2021-03-08 13:54:48" anotherTime:@"2021-03-07 14:05:11" format:@"yyyy-HH-dd HH:mm:ss" compare:^(NSComparisonResult comparisionResult, NSArray * _Nonnull resultArray) {
        XCTAssertTrue(comparisionResult == NSOrderedDescending);
        NSLog(@"%@",resultArray);
    }];
    
    [NSDate jx_compareTwoTimesOneTime:@"2020-5-8" anotherTime:@"2020-05-09" format:@"yyyy-HH-dd" compare:^(NSComparisonResult comparisionResult, NSArray * _Nonnull resultArray) {
        XCTAssertTrue(comparisionResult == NSOrderedAscending);
        NSLog(@"%@",resultArray);
    }];
    
    [NSDate jx_compareTwoTimesOneTime:@"2020-5-8" anotherTime:@"2020-05-08" format:@"yyyy-HH-dd" compare:^(NSComparisonResult comparisionResult, NSArray * _Nonnull resultArray) {
        XCTAssertTrue(comparisionResult == NSOrderedSame);
        NSLog(@"%@",resultArray);
    }];
    
    [NSDate jx_compareTwoTimesOneTime:@"1615182888000" anotherTime:@"1615097111000" format:@"" compare:^(NSComparisonResult comparisionResult, NSArray * _Nonnull resultArray) {
        XCTAssertTrue(comparisionResult == NSOrderedDescending);
        NSLog(@"%@",resultArray);
    }];
    
    [NSDate jx_compareTwoTimesOneTime:@"1615182888000" anotherTime:@"1615182888000" format:@"" compare:^(NSComparisonResult comparisionResult, NSArray * _Nonnull resultArray) {
        XCTAssertTrue(comparisionResult == NSOrderedSame);
        NSLog(@"%@",resultArray);
    }];
    
    [NSDate jx_compareTwoTimesOneTime:@"1615182888000" anotherTime:@"1615282888000" format:@"" compare:^(NSComparisonResult comparisionResult, NSArray * _Nonnull resultArray) {
        XCTAssertTrue(comparisionResult == NSOrderedAscending);
        NSLog(@"%@",resultArray);
    }];
    
}

- (void)test_dateFormatter_JXConversion
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSDate *date = [dateFormatter jx_getDateFromDateString:self.currentDateString format:@"yyyy-MM-dd a HH:mm:ss EEEE"];
    XCTAssertTrue([date compare:self.currentDate] == NSOrderedSame,@"根据日期格式时间字符串转NSDate");
    
    XCTAssertTrue([dateFormatter jx_getDateTimeStringFromTimestamp:self.currentTimeInterval format:@"yyyy-MM-dd a HH:mm:ss EEEE"],@"根据日期格式转化时间戳字符串(UTC)");
    
    NSString *currentTimeIntervalStr = [NSString stringWithFormat:@"%.f",self.currentTimeInterval];
    XCTAssertTrue([dateFormatter jx_getDateTimeStringFromTimestampString:currentTimeIntervalStr format:@"yyyy-MM-dd a HH:mm:ss EEEE"],@"根据日期格式转化时间戳字符串(UTC)");
    
    NSTimeInterval time = [dateFormatter jx_getTimestampFromString:self.currentDateString format:@"yyyy-MM-dd HH:mm:ss" isMilliSecond:YES];
    XCTAssertTrue(time == self.currentTimeInterval,@"根据日期格式转化时间字符串为时间戳(UTC)");
    
    NSTimeInterval timeInterval = [NSDate jx_getLocalTimestamp];
    NSString *time1 = [NSString stringWithFormat:@"%.f",timeInterval];
    NSString *time2 = [NSString stringWithFormat:@"%.f",timeInterval - 5];
    NSString *time3 = [NSString stringWithFormat:@"%.f",timeInterval - 60];
    NSString *time4 = [NSString stringWithFormat:@"%.f",timeInterval - 60 * 60];
    NSString *time5 = [NSString stringWithFormat:@"%.f",timeInterval - 60 * 60 * 25];
    NSString *time6 = [NSString stringWithFormat:@"%.f",timeInterval - 60 * 60 * 24 * 30];
    NSString *time7 = [NSString stringWithFormat:@"%.f",timeInterval - 60 * 60 * 24 * 365];
    NSLog(@"====%@",[dateFormatter jx_getBeforeTimeFromTimestamp:time1]);
    NSLog(@"====%@",[dateFormatter jx_getBeforeTimeFromTimestamp:time2]);
    NSLog(@"====%@",[dateFormatter jx_getBeforeTimeFromTimestamp:time3]);
    NSLog(@"====%@",[dateFormatter jx_getBeforeTimeFromTimestamp:time4]);
    NSLog(@"====%@",[dateFormatter jx_getBeforeTimeFromTimestamp:time5]);
    NSLog(@"====%@",[dateFormatter jx_getVariableFormatDateStringFromTimestamp:time1]);
    NSLog(@"====%@",[dateFormatter jx_getVariableFormatDateStringFromTimestamp:time5]);
    NSLog(@"====%@",[dateFormatter jx_getVariableFormatDateStringFromTimestamp:time6]);
    NSLog(@"====%@",[dateFormatter jx_getVariableFormatDateStringFromTimestamp:time7]);
}

@end
