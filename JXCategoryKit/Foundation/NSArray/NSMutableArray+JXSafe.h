//
//  NSMutableArray+JXSafe.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/3/24.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (JXSafe)

/// 加一个主键不重复的元素，如果元素是字符串key可以不用传；如果元素是字典，则传主键
/// @param anObject 参数
/// @param key 主键
- (void)jx_addObject:(id)anObject withKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
