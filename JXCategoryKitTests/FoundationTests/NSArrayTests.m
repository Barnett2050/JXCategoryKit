//
//  NSArrayTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2021/3/9.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSMutableArray+JXSafe.h"
#import "NSArray+JXSafe.h"

@interface NSArrayTests : XCTestCase

@end

@implementation NSArrayTests

- (void)setUp {
}

- (void)tearDown {
}

- (void)test_MutableArray {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:
                                    @[@"123",
                                      [NSNumber numberWithInt:123],
                                    @{@"123":@"345"},
                                    @[@"567"]]
                                    ];

    XCTAssertNil([mutableArray objectAtIndex:10]);
    XCTAssertEqualObjects([mutableArray objectAtIndex:1], [NSNumber numberWithInt:123]);
    NSLog(@"%@",[mutableArray subarrayWithRange:NSMakeRange(1, 5)]);
    
    NSMutableArray *arr0 = [NSMutableArray alloc];
//    NSArray *arr1 = [arr0 init];
//    NSArray *arr1 = [arr0 initWithObjects:@"2020", nil];
    NSMutableArray *arr1 = [arr0 initWithObjects:@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027",@"2028",@"2029", nil];
    
    NSMutableIndexSet *mutableIndexSet = [NSMutableIndexSet indexSet];
    [mutableIndexSet addIndex:0];
    [mutableIndexSet addIndexesInRange:NSMakeRange(100, 200)];
    [mutableIndexSet addIndexesInRange:NSMakeRange(5, 100)];
    [mutableIndexSet addIndexes:[NSIndexSet indexSetWithIndex:50]];
    
    NSLog(@"objectAtIndex: = %@",[arr1 objectAtIndex:5]);
    NSLog(@"subarrayWithRange: = %@",[arr1 subarrayWithRange:NSMakeRange(1, 10)]);
    NSLog(@"indexOfObject:inRange: = %d",[arr1 indexOfObject:@"2" inRange:NSMakeRange(0, 1)] == NSNotFound);
    NSLog(@"objectsAtIndexes: = %@",[arr1 objectsAtIndexes:mutableIndexSet]);
    NSLog(@"objectAtIndexedSubscript: = %@",arr1[5]);
    [arr1 enumerateObjectsAtIndexes:mutableIndexSet options:0 usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    NSInteger num = [arr1 indexOfObjectAtIndexes:mutableIndexSet options:0 passingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return false;
    }];
    NSLog(@"indexOfObjectAtIndexes: = %d",num == NSNotFound);
    NSIndexSet *indexSet = [arr1 indexesOfObjectsAtIndexes:mutableIndexSet options:0 passingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       return false;
    }];
    NSLog(@"indexesOfObjectsAtIndexes: = %@",indexSet);
    
    num = [arr1 indexOfObject:@"2020" inSortedRange:NSMakeRange(0, 100) options:0 usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return NSOrderedSame;
    }];
    NSLog(@"indexOfObject:inSortedRange: = %d",num==NSNotFound);
    
    [arr1 insertObject:@"2030" atIndex:10];
    NSLog(@"%@",arr1);
    
    [arr1 removeObjectAtIndex:10];
    NSLog(@"%@",arr1);
    
    [arr1 replaceObjectAtIndex:10 withObject:@"2030"];
    NSLog(@"%@",arr1);
    
    [arr1 exchangeObjectAtIndex:0 withObjectAtIndex:10];
    NSLog(@"%@",arr1);
    
    [arr1 removeObject:@"2020" inRange:NSMakeRange(5, 19)];
    NSLog(@"%@",arr1);
    
    [arr1 removeObjectIdenticalTo:@"2029" inRange:NSMakeRange(0, 1)];
    NSLog(@"%@",arr1);
    
    [arr1 removeObjectsInRange:NSMakeRange(15, 100)];
    NSLog(@"%@",arr1);
    
    [arr1 replaceObjectsInRange:NSMakeRange(10, 100) withObjectsFromArray:@[@1,@2,@3,@4] range:NSMakeRange(0, 100)];
    NSLog(@"%@",arr1);
    
    [arr1 replaceObjectsInRange:NSMakeRange(0, 100) withObjectsFromArray:@[@1,@2,@3,@4]];
    NSLog(@"%@",arr1);
    
    arr1[4] = @"测试";
    NSLog(@"%@",arr1);
    
}

- (void)test_Array
{
    NSArray *arr0 = [NSArray alloc];
//    NSArray *arr1 = [arr0 init];
//    NSArray *arr1 = [arr0 initWithObjects:@"2020", nil];
    NSArray *arr1 = [arr0 initWithObjects:@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027",@"2028",@"2029", nil];
    
    NSMutableIndexSet *mutableIndexSet = [NSMutableIndexSet indexSet];
    [mutableIndexSet addIndex:0];
    [mutableIndexSet addIndexesInRange:NSMakeRange(100, 200)];
    [mutableIndexSet addIndexesInRange:NSMakeRange(5, 100)];
    [mutableIndexSet addIndexes:[NSIndexSet indexSetWithIndex:50]];
    
    NSLog(@"objectAtIndex: = %@",[arr1 objectAtIndex:5]);
    NSLog(@"subarrayWithRange: = %@",[arr1 subarrayWithRange:NSMakeRange(1, 10)]);
    NSLog(@"indexOfObject:inRange: = %d",[arr1 indexOfObject:@"2" inRange:NSMakeRange(0, 1)] == NSNotFound);
    NSLog(@"objectsAtIndexes: = %@",[arr1 objectsAtIndexes:mutableIndexSet]);
    NSLog(@"objectAtIndexedSubscript: = %@",arr1[5]);
    [arr1 enumerateObjectsAtIndexes:mutableIndexSet options:0 usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    NSInteger num = [arr1 indexOfObjectAtIndexes:mutableIndexSet options:0 passingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return false;
    }];
    NSLog(@"indexOfObjectAtIndexes: = %d",num == NSNotFound);
    NSIndexSet *indexSet = [arr1 indexesOfObjectsAtIndexes:mutableIndexSet options:0 passingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       return false;
    }];
    NSLog(@"indexesOfObjectsAtIndexes: = %@",indexSet);
    
    num = [arr1 indexOfObject:@"2020" inSortedRange:NSMakeRange(0, 100) options:0 usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return NSOrderedSame;
    }];
    NSLog(@"indexOfObject:inSortedRange: = %d",num==NSNotFound);
}

@end
