//
//  NSMutableArray+JXGeneral.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/13.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (JXGeneral)

/// 根据指定的属性列表数据创建并返回一个数组。
/// @param plist 列表data
+ (nullable NSMutableArray *)jx_arrayWithPlistData:(NSData *)plist;

/// 从指定的属性列表xml字符串创建并返回一个数组。
/// @param plist xml字符串
+ (nullable NSMutableArray *)jx_arrayWithPlistString:(NSString *)plist;

/// 删除数组中索引值最低的对象。
- (void)jx_removeFirstObject;

/// 删除并返回数组中索引值最低的对象。如果数组为空，则仅返回nil。
- (nullable id)jx_popFirstObject;

/// 删除并返回数组中索引值最高的对象。如果数组为空，则仅返回nil。
- (nullable id)jx_popLastObject;

/// 数组反转
- (void)jx_reverse;

/// 随机排序
- (void)jx_shuffle;

@end

NS_ASSUME_NONNULL_END
