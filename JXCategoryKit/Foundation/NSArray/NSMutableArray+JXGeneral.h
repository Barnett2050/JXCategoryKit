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
