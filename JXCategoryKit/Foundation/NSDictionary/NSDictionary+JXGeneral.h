//
//  NSDictionary+JXGeneral.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/17.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JXGeneral)

/// 根据指定的属性列表数据创建并返回字典。
/// @param plist 属性列表数据，其根对象是字典。
+ (nullable NSDictionary *)jx_dictionaryWithPlistData:(NSData *)plist;

/// 从指定的属性列表xml字符串创建并返回字典。
/// @param plist 属性列表xml字符串，其根对象是字典。
+ (nullable NSDictionary *)jx_dictionaryWithPlistString:(NSString *)plist;

/// 将字典序列化为二进制属性列表数据。
- (nullable NSData *)jx_plistData;

/// 将字典序列化为xml属性列表字符串。
- (nullable NSString *)jx_plistString;

/// 返回一个新数组，其中包含已排序的字典键。key应为NSString，并将按升序排序。
- (NSArray *)jx_allKeysSorted;

///  数组中值的顺序由key定义。key应为NSString，并将按升序排序。
- (NSArray *)jx_allValuesSortedByKeys;

/// 根据key的数组返回一个字典
- (NSDictionary *)jx_entriesForKeys:(NSArray *)keys;
@end

NS_ASSUME_NONNULL_END
