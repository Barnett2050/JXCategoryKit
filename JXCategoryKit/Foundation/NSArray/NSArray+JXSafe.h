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


/*
 - (void)arrayTest
 {
     NSArray *arr0 = [NSArray alloc];
 //    NSArray *arr1 = [arr0 init];
 //    NSArray *arr1 = [arr0 initWithObjects:@"2020", nil];
     NSArray *arr1 = [arr0 initWithObjects:@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027",@"2028",@"2029", nil];
     
     NSMutableIndexSet *mutableIndexSet = [NSMutableIndexSet indexSet];
     [mutableIndexSet addIndex:0];
     [mutableIndexSet addIndexesInRange:NSMakeRange(100, 200)];
     [mutableIndexSet addIndexesInRange:NSMakeRange(5, 100)];
     [mutableIndexSet addIndexes:[NSIndexSet indexSetWithIndex:50]];
     
     NSLog(@"objectAtIndex: = %@",[arr1 objectAtIndex:5]);
     NSLog(@"subarrayWithRange: = %@",[arr1 subarrayWithRange:NSMakeRange(1, 10)]);
     NSLog(@"indexOfObject:inRange: = %d",[arr1 indexOfObject:@"2" inRange:NSMakeRange(0, 1)] == NSNotFound);
     NSLog(@"objectsAtIndexes: = %@",[arr1 objectsAtIndexes:mutableIndexSet]);
     NSLog(@"objectAtIndexedSubscript: = %@",arr1[5]);
     [arr1 enumerateObjectsAtIndexes:mutableIndexSet options:0 usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         
     }];
     NSInteger num = [arr1 indexOfObjectAtIndexes:mutableIndexSet options:0 passingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         return false;
     }];
     NSLog(@"indexOfObjectAtIndexes: = %d",num == NSNotFound);
     NSIndexSet *indexSet = [arr1 indexesOfObjectsAtIndexes:mutableIndexSet options:0 passingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return false;
     }];
     NSLog(@"indexesOfObjectsAtIndexes: = %@",indexSet);
     
     num = [arr1 indexOfObject:@"2020" inSortedRange:NSMakeRange(0, 100) options:0 usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
         return NSOrderedSame;
     }];
     NSLog(@"indexOfObject:inSortedRange: = %d",num==NSNotFound);
 }
 */
NS_ASSUME_NONNULL_END
