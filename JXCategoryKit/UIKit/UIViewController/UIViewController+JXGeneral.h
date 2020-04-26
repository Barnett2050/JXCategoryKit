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

/// 设置系统标题颜色和字体
/// @param color 颜色
/// @param font 字体
- (void)jx_setNavigationBarTitleColor:(nullable UIColor *)color font:(nullable UIFont *)font;

/// 设置系统状态栏背景颜色
- (void)jx_setStatusBarBackgroundColor:(UIColor *)color;

/// 返回按钮点击事件
- (void)jx_clickReturnBarButtonItemAction:(UIButton *)sender;

/// 隐藏返回按钮
- (void)jx_hiddenLeftBarButtonItem;
@end

NS_ASSUME_NONNULL_END
