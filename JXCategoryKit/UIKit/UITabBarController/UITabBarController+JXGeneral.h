//
//  UITabBarController+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/24.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarController (JXGeneral)

/// 设置tabbar背景颜色和阴影颜色
/// @param barColor 背景颜色
/// @param shadowColor 阴影颜色
- (void)jx_setTabBarColor:(UIColor *)barColor shadowColor:(UIColor *)shadowColor;

/// 设置tabbar 文字normal颜色和selected颜色
/// @param normalColor 正常颜色
/// @param selectedColor 选中颜色
- (void)jx_setTabbarTitleNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

@end

NS_ASSUME_NONNULL_END
