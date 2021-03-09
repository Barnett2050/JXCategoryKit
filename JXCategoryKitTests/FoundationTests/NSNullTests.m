//
//  NSNullTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2021/3/8.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSNullTests : XCTestCase

@end

@implementation NSNullTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_safe {
    NSDictionary *dictionary = @{@"name" : @"test",@"selector":[NSNull null]};
    NSString *string = [dictionary objectForKey:@"selector"];
    NSDictionary *dic = [dictionary objectForKey:@"selector"];
    NSArray *arr = [dictionary objectForKey:@"selector"];
    NSInteger num = [[dictionary objectForKey:@"selector"] integerValue];
    NSDate *date = [dictionary objectForKey:@"selector"];
    NSData *data = [dictionary objectForKey:@"selector"];
    
    BOOL result = [string isEqualToString:@"test"];
    XCTAssertFalse(result,@"NSNull 调用错误处理");
    XCTAssertNil([dic objectForKey:@"name"],@"");
    XCTAssertNil([arr objectAtIndex:5],@"");
    XCTAssertTrue(num == 0,@"");
    XCTAssertTrue(date.timeIntervalSinceReferenceDate == 0,@"");
    XCTAssertTrue(data.length == 0,@"");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
