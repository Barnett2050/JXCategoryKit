//
//  UITableView+JXGeneral.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/22.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "UITableView+JXGeneral.h"

@implementation UITableView (JXGeneral)

- (void)jx_updateWithBlock:(void (^)(UITableView *tableView))block
{
    [self beginUpdates];
    block(self);
    [self endUpdates];
}

- (void)jx_clearSelectedRowsAnimated:(BOOL)animated
{
    NSArray *indexs = [self indexPathsForSelectedRows];
    [indexs enumerateObjectsUsingBlock:^(NSIndexPath* path, NSUInteger idx, BOOL *stop) {
        [self deselectRowAtIndexPath:path animated:animated];
    }];
}

@end
