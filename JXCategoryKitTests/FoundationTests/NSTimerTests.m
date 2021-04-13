//
//  NSTimerTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2021/3/8.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSTimer+JXGeneral.h"
@interface NSTimerTests : XCTestCase

@end

@implementation NSTimerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_General {
    __block NSInteger index = 0;
    XCTestExpectation *expectation = [self expectationWithDescription:@"timer"];
    [NSTimer jx_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        index++;
        NSLog(@"timer0运行");
        if (index == 3) {
            [timer jx_pauseTimer];
            [timer jx_resumeTimerAfterTimeInterval:3];
        } else if (index == 5) {
            [expectation fulfill];
            [timer invalidate];
            timer = nil;
        }
    }];
    
    
    __block NSInteger count = 0;
    XCTestExpectation *expectation1 = [self expectationWithDescription:@"timer1"];
    NSTimer *timer1 = [NSTimer jx_timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        count++;
        NSLog(@"timer1运行");
        if (count == 3) {
            [timer jx_pauseTimer];
            [timer jx_resumeTimerAfterTimeInterval:3];
        } else if (count == 5) {
            [expectation1 fulfill];
            [timer invalidate];
            timer = nil;
        }
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer1 forMode:NSRunLoopCommonModes];
    
    [self waitForExpectationsWithTimeout:15 handler:NULL];
    
}

@end
