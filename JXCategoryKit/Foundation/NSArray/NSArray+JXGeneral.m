//
//  NSArray+JXGeneral.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/13.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSArray+JXGeneral.h"

@implementation NSArray (JXGeneral)

- (NSArray *)jx_sortNSIndexArray
{
    if (self.count == 0) { return nil; }
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"section" ascending:YES];
    NSSortDescriptor *sorter1 = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
    NSArray *arr = [self sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sorter,sorter1,nil]];
    return arr;
}

- (id)jx_randomObject
{
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

@end
