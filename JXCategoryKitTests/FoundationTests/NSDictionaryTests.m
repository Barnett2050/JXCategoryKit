//
//  NSDictionaryTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2021/4/1.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+JXGeneral.h"
#import "NSDictionary+JXSafe.h"
#import "NSMutableDictionary+JXGeneral.h"
//#import "NSMutableDictionary+JXSafe.h"

@interface NSDictionaryTests : XCTestCase

@end

@implementation NSDictionaryTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_DictionaryGeneral {
    NSDictionary *dictionary = @{@"999":@"999",@"555":@"555",@"239":@"239",@"789":@"789",@"123":@"123",@"666":@"666",@"222":@"222",@"444":@"444",@"888":@"888"};
    NSLog(@"jx_allKeysSorted : %@",dictionary.jx_allKeysSorted);
    NSLog(@"jx_allValuesSortedByKeys : %@",dictionary.jx_allValuesSortedByKeys);
    NSLog(@"jx_dictionaryForKeys : %@",[dictionary jx_dictionaryForKeys:@[@"222",@"444",@"555"]]);
}
- (void)test_DictionarySafe {
    NSDictionary *dictionary = @{@"string":@"字符串",
                                 @"integer":@(999),
                                 @"float":@(33.897),
                                 @"Bool":@(YES),
                                 @"array":@[@"1",@"2",@"3"],
                                 @"dictionary":@{@"1":@"1"},
                                 @"long":@999999999999999,
                                 @"null":[NSNull null]};
    for (NSString *key in dictionary.allKeys) {
        NSLog(@"------  %@  ------",key);
        NSLog(@"string : %@",[dictionary jx_stringForKey:key]);
        NSLog(@"integer : %ld",[dictionary jx_integerForKey:key]);
        NSLog(@"float : %f",[dictionary jx_floatForKey:key]);
        NSLog(@"Bool : %d",[dictionary jx_boolForKey:key]);
        NSLog(@"array : %@",[dictionary jx_arrayForKey:key]);
        NSLog(@"dictionary : %@",[dictionary jx_dictionaryKey:key]);
        NSLog(@"long : %lld",[dictionary jx_longLongForKey:key]);
        NSLog(@"------  %@  ------",key);
    }
    dictionary = [dictionary jx_dictionaryByReplacingNullsWithBlanks];
    NSLog(@"jx_dictionaryByReplacingNullsWithBlanks : %@",dictionary);
    
    NSDictionary *dictionary1 = @{@"string1":@"字符串",
                                  @"integer1":@(999),
                                  @"float1":@(33.897),
                                  @"Bool1":@(YES),
                                  @"array1":@[@"1",@"2",@"3"],
                                  @"dictionary1":@{@"1":@"1"},
                                  @"long1":@999999999999999};
    
    NSDictionary *dictionary2 = [dictionary jx_mergingWithDictionary:dictionary1];
    NSLog(@"jx_mergingWithDictionary : %@",dictionary2);
    
    NSDictionary *dictionary3 = [dictionary jx_mergingWithDictionary:dictionary1 ignoredKeyArr:@[@"float1",@"long1"]];
    NSLog(@"jx_mergingWithDictionary:ignoredKeyArr : %@",dictionary3);
}
- (void)test_MutableDictionaryGeneral {
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"字符串",@"string",@(999),@"integer",@(33.897),@"float",@(YES),@"Bool",@[@"1",@"2",@"3"],@"array",@{@"1":@"1"},@"dictionary", nil];
    NSArray *arr = [mutableDictionary jx_popObjectForKey:@"array"];
    NSLog(@"jx_popObjectForKey : %@ \n %@",arr,mutableDictionary);
    
    NSDictionary *newDic = [mutableDictionary jx_popDictionaryForKeys:@[@"integer",@"float"]];
    NSLog(@"jx_popDictionaryForKeys : %@",newDic);
    
}
- (void)test_MutableDictionarySafe {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:nil forKey:@"name"];
}

@end
