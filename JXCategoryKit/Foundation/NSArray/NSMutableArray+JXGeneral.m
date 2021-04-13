//
//  NSMutableArray+JXGeneral.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/13.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSMutableArray+JXGeneral.h"

@implementation NSMutableArray (JXGeneral)

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
