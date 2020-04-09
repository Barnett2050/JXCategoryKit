//
//  NSArray+JXSafe.m
//  CustomCategory
//
//  Created by edz on 2019/10/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "NSArray+JXSafe.h"
#import "NSObject+JXRuntime.h"
#import <objc/runtime.h>

/* NSArray 的三个子类
 __NSArray0 : 空数组
 __NSSingleObjectArrayI : 含有一个元素的数组
 __NSArrayI : 含有多个元素的数组
 */

static const char *NSArray0 = "__NSArray0";
static const char *NSSingleObjectArrayI = "__NSSingleObjectArrayI";
static const char *NSArrayI = "__NSArrayI";

@implementation NSArray (JXSafe)

#pragma mark - public
- (NSArray *)jx_removeTheSameElement
{
    NSMutableSet *set = [NSMutableSet set];
    for (NSObject *obj in self) {
        [set addObject:obj];
    }
    return [set allObjects];
}

- (NSMutableArray *)jx_removeDuplicatesWithKey:(NSString *)key {
    if (self.count < 2) {
        return [[NSMutableArray alloc] initWithArray:self];
    }
    NSMutableArray *arrayResult = [NSMutableArray new];
    NSMutableArray *arrayPk = [NSMutableArray new];
    
    NSObject *obj = self[0];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        if (key.length > 0) {
            for (NSDictionary *dic in self) {
                NSString *pk = dic[key];
                if (![arrayPk containsObject:pk]) {
                    [arrayResult addObject:dic];
                    [arrayPk addObject:pk];
                }
            }
            return arrayResult;
        } else {
            return [[NSMutableArray alloc] initWithArray:self];
        }
    } else if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]]) {
        for (NSObject *obj in self) {
            if (![arrayResult containsObject:obj]) {
                [arrayResult addObject:obj];
            }
        }
    } else {
        if (key.length > 0) {
            for (NSObject *obj in self) {
                NSString *pk = [obj valueForKey:key];
                if (![arrayPk containsObject:pk]) {
                    [arrayResult addObject:obj];
                    [arrayPk addObject:pk];
                }
            }
            return arrayResult;
        } else {
            return [[NSMutableArray alloc] initWithArray:self];
        }
    }
    return arrayResult;
}

- (NSArray *)jx_arrayByReplacingNullsWithBlanks
{
    NSMutableArray *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    for (int idx = 0; idx < [replaced count]; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul) [replaced replaceObjectAtIndex:idx withObject:blank];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[self dictionaryByReplacingNullsWithBlanks:object]];
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[object jx_arrayByReplacingNullsWithBlanks]];
    }
    return [replaced copy];
}

- (NSMutableArray *)jx_Mutable {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSObject *obj in self) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mDic = [self jx_MutableWith:(NSDictionary *)obj];
            [tempArray addObject:mDic];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [(NSArray *)obj jx_Mutable];
            [tempArray addObject:mArr];
            
        } else {
            [tempArray addObject:obj];
        }
    }
    
    return tempArray;
}

#pragma mark - load runtime

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSArray swizzleNSArray0Method];
        [NSArray swizzleNSSingleObjectArrayIMethod];
        [NSArray swizzleNSArrayIMethod];
    });
}

+ (void)swizzleNSArray0Method
{
    [objc_getClass(NSArray0) jx_swizzleClassInstanceMethodWithOriginSel:@selector(objectAtIndex:) swizzleSel:@selector(array0_objectAtIndex:)];
    [objc_getClass(NSArray0) jx_swizzleClassInstanceMethodWithOriginSel:@selector(subarrayWithRange:) swizzleSel:@selector(array0_subarrayWithRange:)];
    [objc_getClass(NSArray0) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexOfObject:inRange:) swizzleSel:@selector(array0_indexOfObject:inRange:)];
    [objc_getClass(NSArray0) jx_swizzleClassInstanceMethodWithOriginSel:@selector(objectsAtIndexes:) swizzleSel:@selector(array0_objectsAtIndexes:)];
    [objc_getClass(NSArray0) jx_swizzleClassInstanceMethodWithOriginSel:@selector(objectAtIndexedSubscript:) swizzleSel:@selector(array0_objectAtIndexedSubscript:)];
    [objc_getClass(NSArray0) jx_swizzleClassInstanceMethodWithOriginSel:@selector(enumerateObjectsAtIndexes:options:usingBlock:) swizzleSel:@selector(array0_enumerateObjectsAtIndexes:options:usingBlock:)];
    [objc_getClass(NSArray0) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexOfObjectAtIndexes:options:passingTest:) swizzleSel:@selector(array0_indexOfObjectAtIndexes:options:passingTest:)];
    [objc_getClass(NSArray0) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexesOfObjectsAtIndexes:options:passingTest:) swizzleSel:@selector(array0_indexesOfObjectsAtIndexes:options:passingTest:)];
    [objc_getClass(NSArray0) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexOfObject:inSortedRange:options:usingComparator:) swizzleSel:@selector(array0_indexOfObject:inSortedRange:options:usingComparator:)];
}
+ (void)swizzleNSSingleObjectArrayIMethod
{
    [objc_getClass(NSSingleObjectArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(objectAtIndex:) swizzleSel:@selector(singleObjectArrayI_objectAtIndex:)];
    [objc_getClass(NSSingleObjectArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(subarrayWithRange:) swizzleSel:@selector(singleObjectArrayI_subarrayWithRange:)];
    [objc_getClass(NSSingleObjectArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexOfObject:inRange:) swizzleSel:@selector(singleObjectArrayI_indexOfObject:inRange:)];
    [objc_getClass(NSSingleObjectArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(objectsAtIndexes:) swizzleSel:@selector(singleObjectArrayI_objectsAtIndexes:)];
    [objc_getClass(NSSingleObjectArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(objectAtIndexedSubscript:) swizzleSel:@selector(singleObjectArrayI_objectAtIndexedSubscript:)];
    [objc_getClass(NSSingleObjectArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(enumerateObjectsAtIndexes:options:usingBlock:) swizzleSel:@selector(singleObjectArrayI_enumerateObjectsAtIndexes:options:usingBlock:)];
    [objc_getClass(NSSingleObjectArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexOfObjectAtIndexes:options:passingTest:) swizzleSel:@selector(singleObjectArrayI_indexOfObjectAtIndexes:options:passingTest:)];
    [objc_getClass(NSSingleObjectArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexesOfObjectsAtIndexes:options:passingTest:) swizzleSel:@selector(singleObjectArrayI_indexesOfObjectsAtIndexes:options:passingTest:)];
    [objc_getClass(NSSingleObjectArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexOfObject:inSortedRange:options:usingComparator:) swizzleSel:@selector(singleObjectArrayI_indexOfObject:inSortedRange:options:usingComparator:)];
}

+ (void)swizzleNSArrayIMethod
{
    [objc_getClass(NSArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(objectAtIndex:) swizzleSel:@selector(arrayI_objectAtIndex:)];
    [objc_getClass(NSArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(subarrayWithRange:) swizzleSel:@selector(arrayI_subarrayWithRange:)];
    [objc_getClass(NSArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexOfObject:inRange:) swizzleSel:@selector(arrayI_indexOfObject:inRange:)];
    [objc_getClass(NSArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(objectsAtIndexes:) swizzleSel:@selector(arrayI_objectsAtIndexes:)];
    [objc_getClass(NSArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(objectAtIndexedSubscript:) swizzleSel:@selector(arrayI_objectAtIndexedSubscript:)];
    [objc_getClass(NSArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(enumerateObjectsAtIndexes:options:usingBlock:) swizzleSel:@selector(arrayI_enumerateObjectsAtIndexes:options:usingBlock:)];
    [objc_getClass(NSArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexOfObjectAtIndexes:options:passingTest:) swizzleSel:@selector(arrayI_indexOfObjectAtIndexes:options:passingTest:)];
    [objc_getClass(NSArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexesOfObjectsAtIndexes:options:passingTest:) swizzleSel:@selector(arrayI_indexesOfObjectsAtIndexes:options:passingTest:)];
    [objc_getClass(NSArrayI) jx_swizzleClassInstanceMethodWithOriginSel:@selector(indexOfObject:inSortedRange:options:usingComparator:) swizzleSel:@selector(arrayI_indexOfObject:inSortedRange:options:usingComparator:)];
}

#pragma mark - NSArray0
- (id)array0_objectAtIndex:(NSUInteger)index
{
    return nil;
}
- (NSArray *)array0_subarrayWithRange:(NSRange)range
{
    return nil;
}
- (NSUInteger)array0_indexOfObject:(id)anObject inRange:(NSRange)range
{
    return NSNotFound;
}

- (NSArray *)array0_objectsAtIndexes:(NSIndexSet *)indexes
{
    return nil;
}

- (id)array0_objectAtIndexedSubscript:(NSUInteger)idx
{
    /*
    -objectAtIndexedSubscript：提供对obj-c下标的支持的方法。换句话说，这个方法是编译器使用的方法，如果你说数组[3]。但是对于NSArray *，它与-objectAtIndex：完全相同。为什么它是一个不同的方法的原因是其他类可以实现这一点，以便支持obj-c下标，而不必使用通用命名的-objectAtIndex：。
    */
    return nil;
}

- (void)array0_enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block
{}
- (NSUInteger)array0_indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return NSNotFound;
}
- (NSIndexSet *)array0_indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    return [NSIndexSet indexSet];
}
- (NSUInteger)array0_indexOfObject:(id)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmp
{
    return NSNotFound;
}

#pragma mark - NSSingleObjectArrayI
- (id)singleObjectArrayI_objectAtIndex:(NSUInteger)index
{
    if (index > self.count || self.count == 0) {
        return nil;
    }
    return [self singleObjectArrayI_objectAtIndex:index];
}
- (NSArray *)singleObjectArrayI_subarrayWithRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        return [self singleObjectArrayI_subarrayWithRange:[self getNewRangeWith:range]];
    }else
    {
        return nil;
    }
}
- (NSUInteger)singleObjectArrayI_indexOfObject:(id)anObject inRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        return [self singleObjectArrayI_indexOfObject:anObject inRange:[self getNewRangeWith:range]];
    }else
    {
        return NSNotFound;
    }
}

- (NSArray *)singleObjectArrayI_objectsAtIndexes:(NSIndexSet *)indexes
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:indexes];
    if (newIndexes.count == 0) {
        return nil;
    }
    return [self singleObjectArrayI_objectsAtIndexes:newIndexes];
}

- (id)singleObjectArrayI_objectAtIndexedSubscript:(NSUInteger)idx
{
    /*
    -objectAtIndexedSubscript：提供对obj-c下标的支持的方法。换句话说，这个方法是编译器使用的方法，如果你说数组[3]。但是对于NSArray *，它与-objectAtIndex：完全相同。为什么它是一个不同的方法的原因是其他类可以实现这一点，以便支持obj-c下标，而不必使用通用命名的-objectAtIndex：。
    */
    if (idx > self.count) {
        return nil;
    }
    return [self singleObjectArrayI_objectAtIndexedSubscript:idx];
}

- (void)singleObjectArrayI_enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count != 0) {
        [self singleObjectArrayI_enumerateObjectsAtIndexes:newIndexes options:opts usingBlock:block];
    }
}
- (NSUInteger)singleObjectArrayI_indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count == 0) {
        return NSNotFound;
    }
    return [self singleObjectArrayI_indexOfObjectAtIndexes:newIndexes options:opts passingTest:predicate];
}
- (NSIndexSet *)singleObjectArrayI_indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count == 0) {
        return [NSIndexSet indexSet];
    }
    return [self singleObjectArrayI_indexesOfObjectsAtIndexes:newIndexes options:opts passingTest:predicate];
}
- (NSUInteger)singleObjectArrayI_indexOfObject:(id)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmp
{
    if ([self rangeIsAvailable:r]) {
        return [self singleObjectArrayI_indexOfObject:obj inSortedRange:[self getNewRangeWith:r] options:opts usingComparator:cmp];
    }else
    {
        return NSNotFound;
    }
}
#pragma mark - NSArrayI
- (id)arrayI_objectAtIndex:(NSUInteger)index
{
    if (index > self.count || self.count == 0) {
        return nil;
    }
    return [self arrayI_objectAtIndex:index];
}
- (NSArray *)arrayI_subarrayWithRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        return [self arrayI_subarrayWithRange:[self getNewRangeWith:range]];
    }else
    {
        return nil;
    }
}
- (NSUInteger)arrayI_indexOfObject:(id)anObject inRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        return [self arrayI_indexOfObject:anObject inRange:[self getNewRangeWith:range]];
    }else
    {
        return NSNotFound;
    }
}

- (NSArray *)arrayI_objectsAtIndexes:(NSIndexSet *)indexes
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:indexes];
    if (newIndexes.count == 0) {
        return nil;
    }
    return [self arrayI_objectsAtIndexes:newIndexes];
}

- (id)arrayI_objectAtIndexedSubscript:(NSUInteger)idx
{
    /*
    -objectAtIndexedSubscript：提供对obj-c下标的支持的方法。换句话说，这个方法是编译器使用的方法，如果你说数组[3]。但是对于NSArray *，它与-objectAtIndex：完全相同。为什么它是一个不同的方法的原因是其他类可以实现这一点，以便支持obj-c下标，而不必使用通用命名的-objectAtIndex：。
    */
    if (idx > self.count) {
        return nil;
    }
    return [self arrayI_objectAtIndexedSubscript:idx];
}

- (void)arrayI_enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count != 0) {
        [self arrayI_enumerateObjectsAtIndexes:newIndexes options:opts usingBlock:block];
    }
}
- (NSUInteger)arrayI_indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count == 0) {
        return NSNotFound;
    }
    return [self arrayI_indexOfObjectAtIndexes:newIndexes options:opts passingTest:predicate];
}
- (NSIndexSet *)arrayI_indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate
{
    NSIndexSet *newIndexes = [self filterIndexSetWith:s];
    if (newIndexes.count == 0) {
        return [NSIndexSet indexSet];
    }
    return [self arrayI_indexesOfObjectsAtIndexes:newIndexes options:opts passingTest:predicate];
}
- (NSUInteger)arrayI_indexOfObject:(id)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmp
{
    if ([self rangeIsAvailable:r]) {
        return [self arrayI_indexOfObject:obj inSortedRange:[self getNewRangeWith:r] options:opts usingComparator:cmp];
    }else
    {
        return NSNotFound;
    }
}
#pragma mark - private
/// 字典转换为可变字典
/// @param dic 字典
- (NSMutableDictionary *)jx_MutableWith:(NSDictionary *)dic
{
    NSMutableDictionary *dicResult = [[NSMutableDictionary alloc] init];
    for (NSString *key in dic.allKeys) {
        NSObject *obj = dic[key];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mDic = [self jx_MutableWith:(NSDictionary *)obj];
            [dicResult setValue:mDic forKey:key];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSMutableArray *mArr = [(NSArray *)obj jx_Mutable];
            [dicResult setValue:mArr forKey:key];
        } else {
            [dicResult setValue:obj forKey:key];
        }
    }
    return dicResult;
}

- (NSDictionary *)dictionaryByReplacingNullsWithBlanks:(NSDictionary *)dic
{
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        id object = [dic objectForKey:key];
        if (object == nul) [replaced setValue:blank forKey:key];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setValue:[self dictionaryByReplacingNullsWithBlanks:object] forKey:key];
        else if ([object isKindOfClass:[NSArray class]])
            [replaced setValue:[object jx_arrayByReplacingNullsWithBlanks] forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}

- (BOOL)rangeIsAvailable:(NSRange)range
{
    BOOL flag = true;
    if (range.location < 0 || range.length <= 0 || range.location > self.count) {
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

@end
