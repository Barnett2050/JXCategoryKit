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
    XCUIApplication *applicaiton = [[XCUIApplication alloc] init];
    [applicaiton launch];
    
//    [self buttonTestExample];
//    [self controlTestExample];
}

- (void)controlTestExample {
    
}

- (void)buttonTestExample {
    // 使用录制开始编写UI测试。录制功能自动生成代码只限于真机运行，模拟器运行无法自动生成。
    // 使用xctasert和相关函数来验证测试是否产生正确的结果。
    
    XCUIApplication *applicaiton = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = applicaiton.tables;

    XCUIElement *cell = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"ButtonViewController"]/*[[".cells.staticTexts[@\"ButtonViewController\"]",".staticTexts[@\"ButtonViewController\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    XCTAssert(cell.exists,@"获取Element失败！");
    [cell tap];

    // 按钮点击范围和延时测试
    XCUIElement *button = applicaiton.buttons[@"点击"];
    XCTAssert(button.exists,@"获取button失败！");
    [self customTapElementAtPoint:CGPointMake(10, 99)];

    XCUIElement *button1 = applicaiton.buttons[@"1"];
    XCTAssert([button1 waitForExistenceWithTimeout:3],@"点击间隔");
    [self wait:3];
    [self customTapElementAtPoint:CGPointMake(10, 188 + 40)];

    XCUIElement *button2 = applicaiton.buttons[@"2"];
    XCTAssert(button2.exists,@"获取button2失败！");
    [self wait:3];
    [self customTapElementAtPoint:CGPointMake(290, 99)];

    XCUIElement *button3 = applicaiton.buttons[@"3"];
    XCTAssert(button3.exists,@"获取button3失败！");
    [self wait:3];
    [self customTapElementAtPoint:CGPointMake(290, 188 + 40)];

    XCUIElement *button4 = applicaiton.buttons[@"4"];
    XCTAssert(button4.exists,@"获取button4失败！");

    XCUIElement *button5 = applicaiton.buttons[@"文字"];
    XCTAssert(button5.exists,@"获取button5失败！");
    for (int i = 0; i < 5; i++) {
        [button5 tap];
        [self wait:1];
    }
    
    [applicaiton.navigationBars[@"ButtonViewController"].buttons[@"Back"] tap];
    [self wait:1];
}

#pragma mark - private 
// 等待
- (void)wait:(NSUInteger)interval {

    // 第一种
    XCTestExpectation *expectation = [self expectationWithDescription:@"wait"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [expectation fulfill];
    });
    [self waitForExpectationsWithTimeout:interval handler:nil];
    
    // 第二种
//    [XCTWaiter waitForExpectations:@[[[XCTestExpectation alloc] initWithDescription:@"wait"]] timeout:interval];
}

// 点击屏幕上的某个点
- (void)customTapElementAtPoint:(CGPoint)point {
    
    CGPoint originalP = point;
    XCUIApplication *application = [[XCUIApplication alloc] init];
    XCUICoordinate *normalizedCoordinate = [application coordinateWithNormalizedOffset:CGVectorMake(0, 0)];
    XCUICoordinate *coordinate = [normalizedCoordinate coordinateWithOffset:CGVectorMake(originalP.x, originalP.y)];
    [coordinate tap];
}

@end
