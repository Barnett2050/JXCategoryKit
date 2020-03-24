//
//  NSArray+JXSafe.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/3/24.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSArray+JXSafe.h"

@implementation NSArray (JXSafe)

- (NSArray *)jx_removeTheSameElement
{
    NSMutableSet *set = [NSMutableSet set];
    for (NSObject *obj in self) {
        [set addObject:obj];
    }
    return [set allObjects];
}

- (NSMutableArray *)jx_removeDuplicatesWithKey:(NSString *)key {
    if (self.count < 2) {
        return [[NSMutableArray alloc] initWithArray:self];
    }
    NSMutableArray *arrayResult = [NSMutableArray new];
    NSMutableArray *arrayPk = [NSMutableArray new];
    
    NSObject *obj = self[0];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        if (key.length > 0) {
            for (NSDictionary *dic in self) {
                NSString *pk = dic[key];
                if (![arrayPk containsObject:pk]) {
                    [arrayResult addObject:dic];
                    [arrayPk addObject:pk];
                }
            }
            return arrayResult;
        } else {
            return [[NSMutableArray alloc] initWithArray:self];
        }
    } else if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]]) {
        for (NSObject *obj in self) {
            if (![arrayResult containsObject:obj]) {
                [arrayResult addObject:obj];
            }
        }
    } else {
        if (key.length > 0) {
            for (NSObject *obj in self) {
                NSString *pk = [obj valueForKey:key];
                if (![arrayPk containsObject:pk]) {
                    [arrayResult addObject:obj];
                    [arrayPk addObject:pk];
                }
            }
            return arrayResult;
        } else {
            return [[NSMutableArray alloc] initWithArray:self];
        }
    }
    return arrayResult;
}

- (NSArray *)jx_arrayByReplacingNullsWithBlanks
{
    NSMutableArray *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[self jx_dictionaryByReplacingNullsWithBlanks:object]];
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[object jx_arrayByReplacingNullsWithBlanks]];
    }
    return [replaced copy];
}

- (NSMutableArray *)jx_Mutable {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSObject *obj in self) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mDic = [self jx_MutableWith:(NSDictionary *)obj];
            [tempArray addObject:mDic];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [(NSArray *)obj jx_Mutable];
            [tempArray addObject:mArr];
            
        } else {
            [tempArray addObject:obj];
        }
    }
    
    return tempArray;
}

#pragma mark - private
/// 字典转换为可变字典
/// @param dic 字典
- (NSMutableDictionary *)jx_MutableWith:(NSDictionary *)dic
{
    NSMutableDictionary *dicResult = [[NSMutableDictionary alloc] init];
    for (NSString *key in dic.allKeys) {
        NSObject *obj = dic[key];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mDic = [self jx_MutableWith:(NSDictionary *)obj];
            [dicResult setValue:mDic forKey:key];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [(NSArray *)obj jx_Mutable];
            [dicResult setValue:mArr forKey:key];
        } else {
            [dicResult setValue:obj forKey:key];
        }
    }
    return dicResult;
}

- (NSDictionary *)jx_dictionaryByReplacingNullsWithBlanks:(NSDictionary *)dic
{
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        id object = [dic objectForKey:key];
        if (object == nul) [replaced setValue:blank forKey:key];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setValue:[self jx_dictionaryByReplacingNullsWithBlanks:object] forKey:key];
        else if ([object isKindOfClass:[NSArray class]])
            [replaced setValue:[object jx_arrayByReplacingNullsWithBlanks] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}

@end
