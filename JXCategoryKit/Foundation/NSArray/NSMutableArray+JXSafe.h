//
//  NSMutableArray+JXSafe.h
//  CustomCategory
//
//  Created by edz on 2019/10/9.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (JXSafe)

/// 加一个主键不重复的元素，如果元素是字符串key可以不用传；如果元素是字典，则传主键
/// @param anObject 参数
/// @param key 主键
- (void)jx_addObject:(id)anObject withKey:(NSString *)key;

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
 
 insertObject:atIndex:
 removeObjectAtIndex:
 replaceObjectAtIndex:withObject:
 exchangeObjectAtIndex:withObjectAtIndex:
 removeObject:inRange:
 removeObjectIdenticalTo:inRange:
 removeObjectsInRange:
 replaceObjectsInRange:withObjectsFromArray:range:
 replaceObjectsInRange:withObjectsFromArray:
 insertObjects:atIndexes:
 removeObjectsAtIndexes:
 replaceObjectsAtIndexes:withObjects:
 setObject:atIndexedSubscript:
 
 内部做了安全取值处理
*/

/*
 - (void)mutableArrayTest
 {
     NSMutableArray *arr0 = [NSMutableArray alloc];
 //    NSArray *arr1 = [arr0 init];
 //    NSArray *arr1 = [arr0 initWithObjects:@"2020", nil];
     NSMutableArray *arr1 = [arr0 initWithObjects:@"2020",@"2021",@"2022",@"2023",@"2024",@"2025",@"2026",@"2027",@"2028",@"2029", nil];
     
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
     
     [arr1 insertObject:@"2030" atIndex:10];
     NSLog(@"%@",arr1);
     
     [arr1 removeObjectAtIndex:10];
     NSLog(@"%@",arr1);
     
     [arr1 replaceObjectAtIndex:10 withObject:@"2030"];
     NSLog(@"%@",arr1);
     
     [arr1 exchangeObjectAtIndex:0 withObjectAtIndex:10];
     NSLog(@"%@",arr1);
     
     [arr1 removeObject:@"2020" inRange:NSMakeRange(5, 19)];
     NSLog(@"%@",arr1);
     
     [arr1 removeObjectIdenticalTo:@"2029" inRange:NSMakeRange(0, 1)];
     NSLog(@"%@",arr1);
     
     [arr1 removeObjectsInRange:NSMakeRange(15, 100)];
     NSLog(@"%@",arr1);
     
     [arr1 replaceObjectsInRange:NSMakeRange(10, 100) withObjectsFromArray:@[@1,@2,@3,@4] range:NSMakeRange(0, 100)];
     NSLog(@"%@",arr1);
     
     [arr1 replaceObjectsInRange:NSMakeRange(0, 100) withObjectsFromArray:@[@1,@2,@3,@4]];
     NSLog(@"%@",arr1);
     
     arr1[4] = @"测试";
     NSLog(@"%@",arr1);
 }
 */

NS_ASSUME_NONNULL_END
