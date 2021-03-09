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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSelector1:) name:notificationNameTest1 object:nil];
}

- (void)tearDown {
}

- (void)test_JXGeneral
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSNotification *noti = [[NSNotification alloc] initWithName:notificationNameTest1 object:nil userInfo:nil];
        
        [NSNotificationCenter  jx_postNotificationOnMainThread:noti waitUntilDone:true];
        [NSNotificationCenter jx_postNotificationOnMainThread:noti];
        
        [NSNotificationCenter jx_postNotificationOnMainThreadWithName:notificationNameTest1 object:nil userInfo:@{@"name":@"test"} waitUntilDone:true];
        [NSNotificationCenter jx_postNotificationOnMainThreadWithName:notificationNameTest1 object:nil userInfo:@{@"name":@"test"}];
        [NSNotificationCenter jx_postNotificationOnMainThreadWithName:notificationNameTest1 object:nil];
    });
}

#pragma mark - selector
- (void)notificationSelector1:(NSNotification *)noti
{
    NSLog(@"%@------%d----------%@",[NSThread currentThread],[NSThread currentThread].isMainThread,noti.userInfo);
}

@end
