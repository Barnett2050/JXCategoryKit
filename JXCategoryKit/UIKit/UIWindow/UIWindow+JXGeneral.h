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

/// 导航栈的栈顶视图控制器
+ (UIViewController *)jx_topViewController;

/// 获取当前显示的控制器
+ (UIViewController *)jx_visibleViewController;

/*
 visibleViewController和哪个导航栈没有关系，只是当前显示的控制器，也就是说任意一个导航的visibleViewController所返回的值应该是一样的,
 但是topViewController 就是某个导航栈的栈顶视图，和导航相关
 换句话说如果在仅有一个导航栈上，visibleViewController和topViewController应该是没有区别得。
 */
@end

NS_ASSUME_NONNULL_END
