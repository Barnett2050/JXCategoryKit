//
//  NSObjectTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2021/3/8.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSObject+JXRuntime.h"
#import "NSObject+JXKVO.h"
#import "NSObject+General.h"
#import "NSData+JXGeneral.h"

@interface NSObjectTests : XCTestCase

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger count;

@end

@implementation NSObjectTests

- (void)setUp {
    [self jx_setAssociateValue:@"test" withKey:@"name"];
    [self jx_setAssociateWeakValue:[NSNumber numberWithInt:18] withKey:@"age"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_Runtime {
    XCTAssertEqualObjects([self jx_getAssociatedValueForKey:@"name"], @"test",@"获取绑定属性");
    XCTAssertNotEqualObjects([self jx_getAssociatedValueForKey:@"name"], @"tes",@"获取绑定属性");
    XCTAssertEqual([[self jx_getAssociatedValueForKey:@"age"] integerValue], 18,@"获取绑定属性");
    XCTAssertNotEqual([[self jx_getAssociatedValueForKey:@"age"] integerValue], 16,"获取绑定属性");
    XCTAssertFalse([NSObjectTests jx_isMainBundleClass:self.class],@"判断当前类是否在主bundle里");
    
    [NSObjectTests jx_printClassMethodList];
    [NSObjectTests jx_printClassPropertyList];
    
    [self jx_removeAssociatedValues];
    NSLog(@"%@",[self jx_getAssociatedValueForKey:@"name"]);
    XCTAssertNil([self jx_getAssociatedValueForKey:@"name"],@"获取绑定属性");
    XCTAssertNil([self jx_getAssociatedValueForKey:@"age"],@"获取绑定属性");
}
- (void)test_KVO {
    XCTestExpectation *expectation1 = [self expectationWithDescription:@"kvo"];
    [self jx_addObserverBlockForKeyPath:@"title" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        XCTAssertTrue([obj isKindOfClass:[NSObjectTests class]],@"");
        XCTAssertNil(oldVal,@"");
        XCTAssertEqual(newVal, @"kvo",@"");
        [expectation1 fulfill];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.title = @"kvo";
        self.count = 20;
    });
    [self waitForExpectationsWithTimeout:10 handler:NULL];
}

- (void)test_General {
    XCTestExpectation *expectation = [self expectationWithDescription:@"general"];
    
    NSDictionary *dictionary = @{@"string1":@"字符串",
                                  @"integer1":@(999),
                                  @"float1":@(33.897),
                                  @"Bool1":@(YES),
                                  @"array1":@[@"1",@"2",@"3"],
                                  @"dictionary1":@{@"1":@"1"},
                                  @"long1":@999999999999999};
    NSArray *array = @[@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2025",@"2024",@"2023"];
    
    NSLog(@"jx_jsonStringEncoded : %@",[dictionary jx_jsonStringEncoded]);
    NSLog(@"jx_jsonStringEncoded : %@",[array jx_jsonStringEncoded]);
    
    NSData *arrayData = [NSData jx_mainBundleDataNamed:@"NSArrayList" type:@"plist"];
    [NSObject jx_convertWithPlistData:arrayData resultBlock:^(NSDictionary * _Nonnull plistDictionary, NSArray * _Nonnull plistArray) {
        XCTAssertTrue(plistArray.jx_plistData.length);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:1 handler:NULL];
}
@end
