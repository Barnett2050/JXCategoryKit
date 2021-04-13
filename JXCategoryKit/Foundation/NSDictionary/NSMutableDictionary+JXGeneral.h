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

/// 删除并返回与给定key关联的值。
- (nullable id)jx_popObjectForKey:(id)aKey;

/// 根据给定key的数组返回一个新的字典
- (NSDictionary *)jx_popDictionaryForKeys:(NSArray *)keys;

@end

NS_ASSUME_NONNULL_END
