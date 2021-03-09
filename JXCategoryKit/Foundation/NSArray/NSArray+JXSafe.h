//
//  NSArray+JXSafe.h
//  CustomCategory
//
//  Created by edz on 2019/10/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JXSafe)

/// 去除重复元素
- (NSArray *)jx_removeTheSameElement;

/// 主键去重复，如果元素是字符串key可不传；如果元素是字典，则传主键
/// @param key 键值
- (NSMutableArray *)jx_removeDuplicatesWithKey:(NSString *)key;

/// 替换数组中的NSNull为空字符串
- (NSArray *)jx_arrayByReplacingNullsWithBlanks;

/// 转成可变型数据，包括里面的字典、数组
- (NSMutableArray *)jx_Mutable;

@end

/* hook方法如下：
 objectAtIndex:
 subarrayWithRange:
 indexOfObject:inRange:
 objectsAtIndexes:
 objectAtIndexedSubscript:
 enumerateObjectsAtIndexes:options:usingBlock:
 indexOfObjectAtIndexes:options:passingTest:
 indexesOfObjectsAtIndexes:options:passingTest:
 indexOfObject:inSortedRange:options:usingComparator:
 
 内部做了安全取值处理
*/

NS_ASSUME_NONNULL_END
