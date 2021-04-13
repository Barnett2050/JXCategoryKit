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

/// 返回数组任意位置对象
- (nullable id)jx_randomObject;

@end

NS_ASSUME_NONNULL_END
