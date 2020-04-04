//
//  NSMutableArray+JXSafe.m
//  CustomCategory
//
//  Created by edz on 2019/10/9.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSMutableArray+JXSafe.h"
#import "NSObject+JXRuntime.h"
#import <objc/runtime.h>

#define NSArrayM "__NSArrayM"

@implementation NSMutableArray (JXSafe)

- (void)jx_addObject:(id)anObject withKey:(NSString *)key {
    if (self.count < 1) {
        [self addObject:anObject];
    } else {
        if ([anObject isKindOfClass:[NSDictionary class]]) {
            if (key.length > 0) {
                BOOL has = NO;
                for (NSDictionary *dic in self) {
                    NSString *pk = dic[key];
                    if ([pk isEqualToString:((NSDictionary *)anObject)[key]]) {
                        has = YES;
                        break;
                    }
                }
                if (!has) {
                    [self addObject:anObject];
                }
                
            } else {
                [self addObject:anObject];
            }
        } else if ([anObject isKindOfClass:[NSString class]] || [anObject isKindOfClass:[NSNumber class]]) {
            if (![self containsObject:anObject]) {
                [self addObject:anObject];
            }
        } else {
            if (key.length > 0) {
                BOOL has = NO;
                for (NSObject *obj in self) {
                    NSString *pk = [obj valueForKey:key];
                    if ([pk isEqualToString:[anObject valueForKey:key]]) {
                        has = YES;
                        break;
                    }
                }
                if (!has) {
                    [self addObject:anObject];
                }
                
            } else {
                [self addObject:anObject];
            }
        }
    }
}

#pragma mark - load runtime
+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSMutableArray swizzleNSArrayMMethod];
    });
}

+ (void)swizzleNSArrayMMethod
{
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(objectAtIndex:) swizzleSel:@selector(arrayM_objectAtIndex:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(subarrayWithRange:) swizzleSel:@selector(arrayM_subarrayWithRange:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexOfObject:inRange:) swizzleSel:@selector(arrayM_indexOfObject:inRange:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(objectsAtIndexes:) swizzleSel:@selector(arrayM_objectsAtIndexes:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(objectAtIndexedSubscript:) swizzleSel:@selector(arrayM_objectAtIndexedSubscript:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(enumerateObjectsAtIndexes:options:usingBlock:) swizzleSel:@selector(arrayM_enumerateObjectsAtIndexes:options:usingBlock:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexOfObjectAtIndexes:options:passingTest:) swizzleSel:@selector(arrayM_indexOfObjectAtIndexes:options:passingTest:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexesOfObjectsAtIndexes:options:passingTest:) swizzleSel:@selector(arrayM_indexesOfObjectsAtIndexes:options:passingTest:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexOfObject:inSortedRange:options:usingComparator:) swizzleSel:@selector(arrayM_indexOfObject:inSortedRange:options:usingComparator:)];
    // 增删改查
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(insertObject:atIndex:) swizzleSel:@selector(arrayM_insertObject:atIndex:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(removeObjectAtIndex:) swizzleSel:@selector(arrayM_removeObjectAtIndex:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceObjectAtIndex:withObject:) swizzleSel:@selector(arrayM_replaceObjectAtIndex:withObject:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(exchangeObjectAtIndex:withObjectAtIndex:) swizzleSel:@selector(arrayM_exchangeObjectAtIndex:withObjectAtIndex:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(removeObject:inRange:) swizzleSel:@selector(arrayM_removeObject:inRange:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(removeObjectIdenticalTo:inRange:) swizzleSel:@selector(arrayM_removeObjectIdenticalTo:inRange:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(removeObjectsInRange:) swizzleSel:@selector(arrayM_removeObjectsInRange:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceObjectsInRange:withObjectsFromArray:range:) swizzleSel:@selector(arrayM_replaceObjectsInRange:withObjectsFromArray:range:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceObjectsInRange:withObjectsFromArray:) swizzleSel:@selector(arrayM_replaceObjectsInRange:withObjectsFromArray:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(insertObjects:atIndexes:) swizzleSel:@selector(arrayM_insertObjects:atIndexes:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(removeObjectsAtIndexes:) swizzleSel:@selector(arrayM_removeObjectsAtIndexes:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceObjectsAtIndexes:withObjects:) swizzleSel:@selector(arrayM_replaceObjectsAtIndexes:withObjects:)];
    [objc_getClass(NSArrayM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(setObject:atIndexedSubscript:) swizzleSel:@selector(arrayM_setObject:atIndexedSubscript:)];
}

#pragma mark - NSArrayM
- (id)arrayM_objectAtIndex:(NSUInteger)index
{
    if (index > self.count || self.count == 0) {
        return nil;
    }
    return [self arrayM_objectAtIndex:index];
}
- (NSArray *)arrayM_subarrayWithRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        return [self arrayM_subarrayWithRange:[self getNewRangeWith:range]];
    }else
    {
        return nil;
    }
}
- (NSUInteger)arrayM_indexOfObject:(id)anObject inRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        return [self arrayM_indexOfObject:anObject inRange:[self getNewRangeWith:range]];
    }else
    {
        return NSNotFound;
    }
}

- (NSArray *)arrayM_objectsAtIndexes:(NSIndexSet *)indexes
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:indexes];
    if (newIndexes.count == 0) {
        return nil;
    }
    return [self arrayM_objectsAtIndexes:newIndexes];
}

- (id)arrayM_objectAtIndexedSubscript:(NSUInteger)idx
{
    /*
    -objectAtIndexedSubscript：提供对obj-c下标的支持的方法。换句话说，这个方法是编译器使用的方法，如果你说数组[3]。但是对于NSArray *，它与-objectAtIndex：完全相同。为什么它是一个不同的方法的原因是其他类可以实现这一点，以便支持obj-c下标，而不必使用通用命名的-objectAtIndex：。
    */
    if (idx > self.count) {
        return nil;
    }
    return [self arrayM_objectAtIndexedSubscript:idx];
}

- (void)arrayM_enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count != 0) {
        [self arrayM_enumerateObjectsAtIndexes:newIndexes options:opts usingBlock:block];
    }
}
- (NSUInteger)arrayM_indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count == 0) {
        return NSNotFound;
    }
    return [self arrayM_indexOfObjectAtIndexes:newIndexes options:opts passingTest:predicate];
}
- (NSIndexSet *)arrayM_indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count == 0) {
        return [NSIndexSet indexSet];
    }
    return [self arrayM_indexesOfObjectsAtIndexes:newIndexes options:opts passingTest:predicate];
}
- (NSUInteger)arrayM_indexOfObject:(id)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmp
{
    if ([self rangeIsAvailable:r]) {
        return [self arrayM_indexOfObject:obj inSortedRange:[self getNewRangeWith:r] options:opts usingComparator:cmp];
    }else
    {
        return NSNotFound;
    }
}

- (void)arrayM_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (index >= 0 && index <= self.count && anObject != nil) {
        [self arrayM_insertObject:anObject atIndex:index];
    }
}
- (void)arrayM_removeObjectAtIndex:(NSUInteger)index
{
    if (index >= 0 && index < self.count) {
        [self arrayM_removeObjectAtIndex:index];
    }
}
- (void)arrayM_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index >= 0 && index < self.count && anObject != nil) {
        [self arrayM_replaceObjectAtIndex:index withObject:anObject];
    }
}
- (void)arrayM_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2
{
    if ((idx1 >= 0 && idx1 < self.count) && (idx2 >= 0 && idx2 < self.count)) {
        [self arrayM_exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
}
- (void)arrayM_removeObject:(id)anObject inRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        [self arrayM_removeObject:anObject inRange:[self getNewRangeWith:range]];
    }
}
- (void)arrayM_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        [self arrayM_removeObjectIdenticalTo:anObject inRange:[self getNewRangeWith:range]];
    }
}
- (void)arrayM_removeObjectsInRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        [self arrayM_removeObjectsInRange:[self getNewRangeWith:range]];
    }
}
- (void)arrayM_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange
{
    if ([self rangeIsAvailable:range] && [self rangeIsAvailable:otherRange max:otherArray.count]) {
        [self arrayM_replaceObjectsInRange:[self getNewRangeWith:range] withObjectsFromArray:otherArray range:[self getNewRangeWith:otherRange max:otherArray.count]];
    }
}
- (void)arrayM_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray
{
    if ([self rangeIsAvailable:range]) {
        [self arrayM_replaceObjectsInRange:[self getNewRangeWith:range] withObjectsFromArray:otherArray];
    }
}
- (void)arrayM_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    NSMutableIndexSet *mutableIndexSet = [NSMutableIndexSet indexSet];
    [indexes enumerateRangesUsingBlock:^(NSRange range, BOOL * _Nonnull stop) {
        if (range.location == NSNotFound || range.length == NSNotFound) {
            
        }else if (range.location <= self.count)
        {
            NSRange newRange = NSMakeRange(range.location, objects.count);
            [mutableIndexSet addIndexesInRange:newRange];
        }
    }];
    
    if (mutableIndexSet.count > 0) {
        [self arrayM_insertObjects:objects atIndexes:mutableIndexSet];
    }
}
- (void)arrayM_removeObjectsAtIndexes:(NSIndexSet *)indexes
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:indexes];
    if (newIndexes.count > 0) {
        [self arrayM_removeObjectsAtIndexes:newIndexes];
    }
}
- (void)arrayM_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:indexes];
    if (newIndexes.count > 0 && objects.count > 0) {
        [self arrayM_replaceObjectsAtIndexes:newIndexes withObjects:objects];
    }
}

- (void)arrayM_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    if (idx >=0 && idx <= self.count && obj != nil) {
        [self arrayM_setObject:obj atIndexedSubscript:idx];
    }
}
#pragma mark - private
/// 筛选NSIndexSet
- (NSIndexSet *)filterIndexSetWith:(NSIndexSet *)indexSet
{
    NSMutableIndexSet *mutableIndexSet = [NSMutableIndexSet indexSet];
    [indexSet enumerateRangesUsingBlock:^(NSRange range, BOOL * _Nonnull stop) {
        if (range.location == NSNotFound || range.length == NSNotFound) {
            
        }else if (range.location == self.count-1)
        {
            NSRange newRange = NSMakeRange(range.location, 1);
            [mutableIndexSet addIndexesInRange:newRange];
        }else if (range.location < self.count && range.location + range.length > self.count)
        {
            NSRange newRange = NSMakeRange(range.location, self.count - range.location);
            [mutableIndexSet addIndexesInRange:newRange];
        }else
        {
            [mutableIndexSet addIndexesInRange:range];
        }
    }];
    return mutableIndexSet;
}
- (BOOL)rangeIsAvailable:(NSRange)range
{
    BOOL flag = true;
    if (range.location < 0 || range.length <= 0 || range.location > self.count) {
        flag = false;
       
    }
    return flag;
}

- (BOOL)rangeIsAvailable:(NSRange)range max:(NSInteger)max
{
    BOOL flag = true;
    if (range.location < 0 || range.length <= 0 || range.location > max) {
        flag = false;
       
    }
    return flag;
}

- (NSRange)getNewRangeWith:(NSRange)range
{
    NSRange newRange;
    NSInteger length = range.length;
    if (length + range.location > self.count) {
        length = self.count - range.location;
    }
    newRange = NSMakeRange(range.location, length);
    return newRange;
}

- (NSRange)getNewRangeWith:(NSRange)range max:(NSInteger)max
{
    NSRange newRange;
    NSInteger length = range.length;
    if (length + range.location > max) {
        length = max - range.location;
    }
    newRange = NSMakeRange(range.location, length);
    return newRange;
}

@end
