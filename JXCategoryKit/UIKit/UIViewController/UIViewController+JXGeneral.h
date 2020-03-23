//
//  UIViewController+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/24.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JXGeneral)

/**
 设置标题颜色和字体
 */
- (void)jx_setNavigationBarTitleColor:(nullable UIColor *)color titleFont:(nullable UIFont *)titleFont;

/// 设置状态栏背景颜色
- (void)jx_setStatusBarBackgroundColor:(UIColor *)color;

/// 返回按钮点击
- (void)jx_clickReturnBarButtonItemAction:(UIButton *)sender;

/**
 隐藏返回按钮
 */
- (void)jx_hiddenLeftBarButtonItem;
@end

NS_ASSUME_NONNULL_END
