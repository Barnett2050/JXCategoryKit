//
//  NSDictionary+JXGeneral.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/17.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSDictionary+JXGeneral.h"

@implementation NSDictionary (JXGeneral)

- (NSArray *)jx_allKeysSorted {
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}
- (NSArray *)jx_allValuesSortedByKeys {
    NSArray *sortedKeys = [self jx_allKeysSorted];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id key in sortedKeys) {
        [arr addObject:self[key]];
    }
    return arr;
}

- (NSDictionary *)jx_dictionaryForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) dic[key] = value;
    }
    return dic;
}

@end
