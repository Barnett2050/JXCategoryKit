//
//  UIWindow+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (JXGeneral)

/// 获取主窗体
+ (UIWindow *)jx_getCurrentWindow;

/// 获取当前主控制器 UIViewController
/// @param window 主窗体
+ (UIViewController *)jx_getCurrentViewController:(UIWindow *)window;

/// 获取可见控制器
+ (UIViewController *)jx_visibleViewController;
@end

NS_ASSUME_NONNULL_END
