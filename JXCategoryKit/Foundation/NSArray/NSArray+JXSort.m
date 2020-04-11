//
//  NSArray+JXSort.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/10.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSArray+JXSort.h"

@implementation NSArray (JXSort)

- (NSArray *)jx_sortNSIndexArray
{
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"section" ascending:YES];
    NSSortDescriptor *sorter1 = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
    NSArray *arr = [self sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sorter,sorter1,nil]];
    return arr;
}

@end
