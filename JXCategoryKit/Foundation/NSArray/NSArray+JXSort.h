//
//  NSArray+JXSort.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/10.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JXSort)

#pragma mark - 实例方法
/**
 排序对象是NSIndex的数组
 */
- (NSArray *)jx_sortNSIndexArray;

@end

NS_ASSUME_NONNULL_END
