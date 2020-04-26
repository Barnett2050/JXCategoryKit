//
//  UITableView+JXGeneral.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/22.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (JXGeneral)

/// tableView更新block，例如insert, delete, 或者 select
/// @param block 执行操作
- (void)jx_updateWithBlock:(void (^)(UITableView *tableView))block;

/// 取消tableView所有行的选中
/// @param animated 动画效果
- (void)jx_clearSelectedRowsAnimated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
