//
//  NSMutableDictionary+JXGeneral.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/17.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSMutableDictionary+JXGeneral.h"

@implementation NSMutableDictionary (JXGeneral)

- (id)jx_popObjectForKey:(id)aKey {
    if (!aKey) return nil;
    id value = self[aKey];
    [self removeObjectForKey:aKey];
    return value;
}

- (NSDictionary *)jx_popDictionaryForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) {
            [self removeObjectForKey:key];
            dic[key] = value;
        }
    }
    return dic;
}

@end
