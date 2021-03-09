//
//  NSArrayTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2021/3/9.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSMutableArray+JXSafe.h"

@interface NSArrayTests : XCTestCase

@end

@implementation NSArrayTests

- (void)setUp {
}

- (void)tearDown {
}

- (void)testExample {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:
                                    @[@"123",
                                      [NSNumber numberWithInt:123],
                                    @{@"123":@"345"},
                                    @[@"567"]]
                                    ];
    XCTAssertNil([mutableArray objectAtIndex:-10]);
    XCTAssertEqualObjects([mutableArray objectAtIndex:10], nil);
    XCTAssertEqualObjects([mutableArray objectAtIndex:1], [NSNumber numberWithInt:123]);
}

@end
