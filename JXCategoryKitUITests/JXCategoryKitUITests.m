//
//  JXCategoryKitUITests.m
//  JXCategoryKitUITests
//
//  Created by Barnett on 2021/4/14.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface JXCategoryKitUITests : XCTestCase

@end

@implementation JXCategoryKitUITests

- (void)setUp {
    // 在这个类中这个方法会在所有test方法调用之前先调用，相关设置代码可以写在这里
    // 在UI测试中，通常最好在发生故障时立即停止。
    self.continueAfterFailure = NO;

    // 在UI测试中，在测试运行之前设置测试所需的初始状态（如接口）很重要。
}

- (void)tearDown {
    // 在调用类中的每个测试方法之后调用此方法。
}

- (void)testExample {
    // UI测试必须启动测试的应用程序。
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // 使用录制开始编写UI测试。
    // 使用xctasert和相关函数来验证测试是否产生正确的结果。
}

- (void)testLaunchPerformance {
    if (@available(macOS 10.15, iOS 13.0, tvOS 13.0, *)) {
        // This measures how long it takes to launch your application.
        [self measureWithMetrics:@[[[XCTApplicationLaunchMetric alloc] init]] block:^{
            [[[XCUIApplication alloc] init] launch];
        }];
    }
}

@end
