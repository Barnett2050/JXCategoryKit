//
//  NSMutableDictionary+JXGeneral.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/17.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (JXGeneral)

/// 根据指定的属性列表数据创建并返回字典。
/// @param plist 属性列表数据，其根对象是字典。
+ (nullable NSMutableDictionary *)jx_dictionaryWithPlistData:(NSData *)plist;

/// 从指定的属性列表xml字符串创建并返回字典。
+ (nullable NSMutableDictionary *)jx_dictionaryWithPlistString:(NSString *)plist;

/// 删除并返回与给定key关联的值。
- (nullable id)jx_popObjectForKey:(id)aKey;

/// 根据给定key的数组返回一个新的字典
- (NSDictionary *)jx_popEntriesForKeys:(NSArray *)keys;


@end

NS_ASSUME_NONNULL_END
