//
//  NSNotificationCenterTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2020/4/29.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSNotificationCenter+JXGeneral.h"

static NSString *const notificationNameTest1 = @"notificationNameTest1";

@interface NSNotificationCenterTests : XCTestCase

@end

@implementation NSNotificationCenterTests

- (void)setUp {
    NSLog(@"准备----------------------------------------------------------------------");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSelector1:) name:notificationNameTest1 object:nil];
}

- (void)tearDown {
    NSLog(@"结束----------------------------------------------------------------------");
}

- (void)test_JXGeneral
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSNotification *noti = [[NSNotification alloc] initWithName:notificationNameTest1 object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] jx_postNotificationOnMainThread:noti waitUntilDone:true];
        
        [[NSNotificationCenter defaultCenter] postNotification:noti];
        
        [[NSNotificationCenter defaultCenter] jx_postNotificationOnMainThreadWithName:notificationNameTest1 object:nil userInfo:nil waitUntilDone:true];
    });
}

#pragma mark - selector
- (void)notificationSelector1:(NSNotification *)noti
{
    NSLog(@"%@------%d",[NSThread currentThread],[NSThread currentThread].isMainThread);
}

@end
