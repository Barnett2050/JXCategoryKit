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

@interface NSDateTests : XCTestCase

@end

@implementation NSDateTests

- (void)setUp {
    NSLog(@"NSDateTests准备----------------------------------------------------------------------");
}

- (void)tearDown {
    NSLog(@"NSDateTests结束----------------------------------------------------------------------");
}

- (void)test_JXConversion
{
    NSString *current = [NSDate jx_getSystemDateTimeWithFormat:@"yyyy-MM-dd a HH:mm:ss EEEE"];
    NSLog(@"系统日期 = %@",current);
    NSDate *date = [NSDate jx_getDateFromDateString:current format:@"yyyy-MM-dd a HH:mm:ss EEEE"];
    NSLog(@"系统date = %@",date);
    
    NSString *timeString = [NSDate jx_getDateTimeStringFromTimestampString:@"1508838709650" format:@"yyyy-MM-dd a HH:mm:ss EEEE"];
    NSLog(@"时间戳 = %@",timeString);
    
    double timestamp = [NSDate jx_getTimestampFromString:timeString format:@"yyyy-MM-dd a HH:mm:ss EEEE" isMilliSecond:true];
    NSLog(@"时间戳（毫秒） = %.f",timestamp);
    
    NSTimeInterval timeInterval = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString *timeIntervalString = [NSString stringWithFormat:@"%f",timeInterval-300];
    NSLog(@"之前的时间 = %@",[NSDate jx_getBeforeTimeFromTimestamp:timeIntervalString]);
    
    NSLog(@"秒数转换 = %@",[NSDate jx_getHHMMSSFromSS:3596 format:nil]);
    
    NSLog(@"之前的时间 = %@",[NSDate jx_getVariableFormatDateStringFromTimestamp:timeIntervalString]);
    
    NSLog(@"实例方法系统时间 = %@",[[[NSDate alloc] init] jx_getDateTimeStringWithformat:@"yyyy-MM-dd a HH:mm:ss EEEE"]);
    
    NSLog(@"之前时间 = %@",[NSDate jx_getLocalPopularTimeFromTimestamp:timeIntervalString]);
}

- (void)test_JXGeneral
{
    NSDate *date = [[NSDate alloc] init];
    
    date = [date jx_dateByAddingYears:5];
    date = [date jx_dateByAddingMonths:10];
    date = [date jx_dateByAddingDays:10];
    date = [date jx_dateByAddingHours:3];
    date = [date jx_dateByAddingMinutes:30];
    date = [date jx_dateByAddingSeconds:30];
    date = [date jx_dateByAddingWeeks:1];
    
    NSLog(@"年：%ld",date.year);
    NSLog(@"月：%ld",date.month);
    NSLog(@"日：%ld",date.day);
    NSLog(@"时：%ld",date.hour);
    NSLog(@"分：%ld",date.minute);
    NSLog(@"秒：%ld",date.second);
    NSLog(@"纳秒：%ld",date.nanosecond);
    NSLog(@"周：%ld",date.weekday);
    NSLog(@"第几个七天：%ld",date.weekdayOrdinal);
    NSLog(@"当前月周数：%ld",date.weekOfMonth);
    NSLog(@"当前年周数：%ld",date.weekOfYear);
    NSLog(@"刻钟：%ld",date.quarter);
    
    NSLog(@"本地时间戳：%f",[NSDate jx_getLocalTimestamp]);
    NSLog(@"与世界标准时间的时差:%@",[NSDate jx_getTimeDifferenceString]);
    NSLog(@"获取当前时区的差值:%f",[NSDate jx_getTimeDifferenceWithUTCTime]);
    NSLog(@"计算相对现在的时间差:%f",[NSDate jx_getTimeIntervalWithCurrent:date]);
    NSLog(@"时间差：%ld",[NSDate jx_calculatedTimeDifferenceWith:[[[NSDate alloc] init] timeIntervalSince1970] endTime:[date timeIntervalSince1970]]);
}

- (void)test_JXVertification
{
    NSDate *date = [[NSDate alloc] init];
    XCTAssertTrue([date jx_isToday],@"日期是否为今天");
    
    NSDate *newDate = [date jx_dateByAddingDays:-1];
    XCTAssertTrue([newDate jx_isYesterday],@"日期是否为昨天");
    
    XCTAssertFalse([NSDate jx_isSameDayWithDate:date andDate:newDate],@"日期是否为同一天");
    
    XCTAssertTrue([NSDate jx_compareTwoTimesOneTime:@"2020-5-9" anotherTime:@"2020-05-09" dateFormat:@"yyyy-HH-dd"] == 0,@"两个日期相同");
    XCTAssertTrue([NSDate jx_compareTwoTimesOneTime:@"2020-5-8" anotherTime:@"2020-05-09" dateFormat:@"yyyy-HH-dd"] < 0,@"第一个时间小");
    XCTAssertTrue([NSDate jx_compareTwoTimesOneTime:@"2020-5-10" anotherTime:@"2020-05-09" dateFormat:@"yyyy-HH-dd"] > 0,@"第一个时间大");
}

@end
