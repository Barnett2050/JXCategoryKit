//
//  UINavigationController+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/24.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (JXGeneral)

/// 设置导航栏背景颜色和阴影颜色
/// @param barColor 背景颜色
/// @param shadowColor 阴影颜色
- (void)jx_setNavigationBarColor:(UIColor *)barColor shadowColor:(UIColor *)shadowColor;


@end

NS_ASSUME_NONNULL_END
