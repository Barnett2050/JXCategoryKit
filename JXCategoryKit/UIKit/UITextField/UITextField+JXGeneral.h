//
//  UITextField+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (JXGeneral)

/// 当前输入是否高亮 true 高亮 false 无高亮
- (BOOL)jx_isTextPosition;

/// 选中所有文本
- (void)jx_selectAllText;

/// 设定选中文本
/// @param range 范围
- (void)jx_setSelectedRange:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
