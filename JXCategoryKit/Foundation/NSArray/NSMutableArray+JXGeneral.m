//
//  NSMutableArray+JXGeneral.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/13.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSMutableArray+JXGeneral.h"

@implementation NSMutableArray (JXGeneral)

+ (NSMutableArray *)jx_arrayWithPlistData:(NSData *)plist
{
    if (!plist) return nil;
    NSMutableArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    if ([array isKindOfClass:[NSMutableArray class]]) return array;
    return nil;
}

+ (NSMutableArray *)jx_arrayWithPlistString:(NSString *)plist
{
    if (!plist) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self jx_arrayWithPlistData:data];
}

- (void)jx_removeFirstObject
{
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (id)jx_popFirstObject
{
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self jx_removeFirstObject];
    }
    return obj;
}

- (id)jx_popLastObject
{
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self removeLastObject];
    }
    return obj;
}

- (void)jx_reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)jx_shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}


@end
