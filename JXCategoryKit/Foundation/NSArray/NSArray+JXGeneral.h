//
//  NSArray+JXGeneral.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/13.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JXGeneral)

/**
 排序对象是NSIndex的数组
 */
- (NSArray *)jx_sortNSIndexArray;

/// 根据指定的属性列表数据创建并返回一个数组。
/// @param plist 列表data
+ (nullable NSArray *)jx_arrayWithPlistData:(NSData *)plist;

/// 从指定的属性列表xml字符串创建并返回一个数组。
/// @param plist xml字符串
+ (nullable NSArray *)jx_arrayWithPlistString:(NSString *)plist;

/// 将数组序列化为二进制属性列表数据。
- (nullable NSData *)jx_plistData;

/// 将数组序列化为xml属性列表字符串。
- (nullable NSString *)jx_plistString;

/// 返回数组任意位置对象
- (nullable id)jx_randomObject;

/// All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
- (nullable NSString *)jx_jsonStringEncoded;

/// 格式化json串
- (nullable NSString *)jx_jsonPrettyStringEncoded;

@end

NS_ASSUME_NONNULL_END
