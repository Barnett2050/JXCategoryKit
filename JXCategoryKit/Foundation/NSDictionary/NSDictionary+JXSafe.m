//
//  NSDictionary+JXSafe.m
//  CustomCategory
//
//  Created by edz on 2019/10/10.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSDictionary+JXSafe.h"
#import <objc/runtime.h>
@implementation NSDictionary (JXSafe)

#pragma mark - public
- (NSString *)jx_stringForKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return @"";
    }
    if ([tmpValue isKindOfClass:[NSString class]]) {
        return tmpValue;
    } else {
        @try {
            return [NSString stringWithFormat:@"%@",tmpValue];
        }
        @catch (NSException *exception) {
            return @"";
        }
    }
}

- (NSInteger)jx_integerForKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return 0;
    }
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue integerValue];
    } else {
        @try {
            return [tmpValue integerValue];
        }
        @catch (NSException *exception) {
            return 0;
        }
    }
}

- (float)jx_floatForKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return 0.0;
    }
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue floatValue];
    } else {
        @try {
            return [tmpValue floatValue];
        }
        @catch (NSException *exception) {
            return 0.0;
        }
    }
}

- (BOOL)jx_boolForKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return false;
    }
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue boolValue];
    } else {
        @try {
            return [tmpValue boolValue];
        }
        @catch (NSException *exception) {
            return false;
        }
    }
}

- (NSMutableArray *)jx_arrayForKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return [NSMutableArray new];
    }
    if ([tmpValue isKindOfClass:[NSArray class]]) {
        if ([tmpValue isKindOfClass:[NSMutableArray class]]) {
            return tmpValue;
        } else {
            return [[NSMutableArray alloc] initWithArray:(NSArray *)tmpValue];
        }
    } else {
        return [NSMutableArray new];
    }
}

- (NSMutableDictionary *)jx_dictionaryKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return [NSMutableDictionary new];
    }
    if ([tmpValue isKindOfClass:[NSDictionary class]]) {
        if ([tmpValue isKindOfClass:[NSMutableDictionary class]]) {
            return tmpValue;
        } else {
            return [[NSMutableDictionary alloc] initWithDictionary:(NSDictionary *)tmpValue];
        }
    } else {
        return [NSMutableDictionary new];
    }
}

- (long long)jx_longLongForKey:(NSString *)key {
    id tmpValue = [self objectForKey:key];
    if (tmpValue == nil || tmpValue == [NSNull null]) {
        return 0.0;
    }
    if ([tmpValue isKindOfClass:[NSNumber class]]) {
        return [tmpValue longLongValue];
    } else {
        @try {
            return [tmpValue longLongValue];
        }
        @catch (NSException *exception) {
            return 0.0;
        }
    }
}

- (NSMutableDictionary *)jx_Mutable {
    NSMutableDictionary *dicResult = [[NSMutableDictionary alloc] init];
    for (NSString *key in self.allKeys) {
        NSObject *obj = self[key];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mDic = [(NSDictionary *)obj jx_Mutable];
            [dicResult setValue:mDic forKey:key];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [self jx_MutableWith:(NSArray *)obj];
            [dicResult setValue:mArr forKey:key];
        } else {
            [dicResult setValue:obj forKey:key];
        }
        NSLog(@"-------%@",dicResult);
    }
    return dicResult;
}

- (NSDictionary *)jx_dictionaryByReplacingNullsWithBlanks {
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        id object = [self objectForKey:key];
        if (object == nul) [replaced setValue:blank forKey:key];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setValue:[object jx_dictionaryByReplacingNullsWithBlanks] forKey:key];
        else if ([object isKindOfClass:[NSArray class]])
            [replaced setValue:[self jx_arrayByReplacingNullsWithBlanksWith:object] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}
/**
 合并两个字典
 
 @param dict 被合并的字典
 */
- (NSDictionary *)jx_mergingWithDictionary:(NSDictionary *)dict
{
    if (dict.count == 0) {
        return self;
    }
    if (self.count == 0) {
        return dict;
    }
    
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:self];
    for (id key in [dict allKeys]) {
        id obj = [self jx_mutableDictionaryCopyIfNeeded:[dict objectForKey:key]];
        id localObj = [self jx_mutableDictionaryCopyIfNeeded:[self objectForKey:key]];
        if ([obj isKindOfClass:[NSDictionary class]] &&
            [localObj isKindOfClass:[NSMutableDictionary class]]) {
            // Recursive merge for NSDictionary
            [localObj jx_mergingWithDictionary:obj];
        } else if (obj) {
            [mutableDic setValue:obj forKey:key];
        }
    }
    return (NSDictionary *)mutableDic;
}

/**
 合并两个字典
 
 @param dict       被合并的字典
 @param ignoredKeyArr 忽略的Key
 */
- (NSDictionary *)jx_mergingWithDictionary:(NSDictionary *)dict ignoredKeyArr:(NSArray *)ignoredKeyArr
{
    if (dict.count == 0) {
        return self;
    }
    if (self.count == 0) {
        return dict;
    }
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:self];
    for (id key in [dict allKeys]) {
        if ([ignoredKeyArr containsObject:key]) {
            continue;
        }
        id obj = [self jx_mutableDictionaryCopyIfNeeded:[dict objectForKey:key]];
        id localObj = [self jx_mutableDictionaryCopyIfNeeded:[self objectForKey:key]];
        if ([obj isKindOfClass:[NSDictionary class]] &&
            [localObj isKindOfClass:[NSMutableDictionary class]]) {
            // Recursive merge for NSDictionary
            [localObj jx_mergingWithDictionary:obj];
        } else if (obj) {
            [mutableDic setValue:obj forKey:key];
        }
    }
    return (NSDictionary *)mutableDic;
}
#pragma mark - private
- (NSMutableArray *)jx_MutableWith:(NSArray *)array {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSObject *obj in array) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mDic = [(NSDictionary *)obj jx_Mutable];
            [tempArray addObject:mDic];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [self jx_MutableWith:(NSArray *)obj];
            [tempArray addObject:mArr];
            
        } else {
            [tempArray addObject:obj];
        }
    }
    
    return tempArray;
}

- (NSArray *)jx_arrayByReplacingNullsWithBlanksWith:(NSArray *)tempArr
{
    NSMutableArray *replaced = [tempArr mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[object jx_dictionaryByReplacingNullsWithBlanks]];
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[self jx_arrayByReplacingNullsWithBlanksWith:object]];
    }
    return [replaced copy];
}

- (id)jx_mutableDictionaryCopyIfNeeded:(id)dictObj
{
    if ([dictObj isKindOfClass:[NSDictionary class]] &&
        ![dictObj isKindOfClass:[NSMutableDictionary class]]) {
        dictObj = [dictObj mutableCopy];
    }
    return dictObj;
}

@end
