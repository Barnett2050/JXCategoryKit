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

/// 返回一个新数组，其中包含已排序的字典键。key应为NSString，并将按升序排序。
- (NSArray *)jx_allKeysSorted;

/// 字典中的value按keys的升序排序数组返回
- (NSArray *)jx_allValuesSortedByKeys;

/// 根据key的数组返回一个字典
- (NSDictionary *)jx_dictionaryForKeys:(NSArray *)keys;

@end

NS_ASSUME_NONNULL_END
