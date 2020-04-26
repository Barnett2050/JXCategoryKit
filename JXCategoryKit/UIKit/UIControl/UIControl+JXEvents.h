//
//  UIControl+JXEvents.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/21.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (JXEvents)

/// 从内部调度表中删除所有目标和操作。
- (void)jx_removeAllTargets;

/// 将特定事件（或多个事件）的目标和操作 添加或替换 到内部调度表中。
/// @param target 目标对象
/// @param action 方法
/// @param controlEvents 动作事件
- (void)jx_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/// 将一个或多个特定事件的块添加到内部调度表中。
/// @param controlEvents 动作事件
/// @param block 回调
- (void)jx_addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

/// 将特定事件（或多个事件）的块添加或替换到内部调度表中。
/// @param controlEvents 动作事件
/// @param block 回调
- (void)jx_setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;

/// 从内部调度表中删除特定事件（或多个事件）的所有block。
/// @param controlEvents 动作事件
- (void)jx_removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
