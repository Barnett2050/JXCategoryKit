//
//  NSDictionary+JXSafe.h
//  CustomCategory
//
//  Created by edz on 2019/10/10.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JXSafe)

/// 字典取string
/// @param key 键
- (NSString *)jx_stringForKey:(NSString *)key;

/// 字典取integer
/// @param key 键
- (NSInteger)jx_integerForKey:(NSString *)key;

/// 字典取float
/// @param key 键
- (float)jx_floatForKey:(NSString *)key;

/// 字典取bool
/// @param key 键
- (BOOL)jx_boolForKey:(NSString *)key;

/// 字典取array
/// @param key 键
- (NSMutableArray *)jx_arrayForKey:(NSString *)key;

/// 字典取dictionary
/// @param key 键
- (NSMutableDictionary *)jx_dictionaryKey:(NSString *)key;

/// 字典取long long
/// @param key 键
- (long long)jx_longLongForKey:(NSString *)key;

/**转成可变型数据，包括里面的字典、数组*/
- (NSMutableDictionary *)jx_Mutable;

/**
 替换字典中的NSNull为空字符串
 */
- (NSDictionary *)jx_dictionaryByReplacingNullsWithBlanks;

/**
 合并两个字典
 
 @param dict 被合并的字典
 */
- (NSDictionary *)jx_mergingWithDictionary:(NSDictionary *)dict;

/**
 合并两个字典
 
 @param dict       被合并的字典
 @param ignoredKeyArr 忽略的Key
 */
- (NSDictionary *)jx_mergingWithDictionary:(NSDictionary *)dict ignoredKeyArr:(NSArray *)ignoredKeyArr;
@end

NS_ASSUME_NONNULL_END
