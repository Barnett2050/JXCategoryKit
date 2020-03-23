//
//  UITabBarController+JXAnimation.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBarController (JXAnimation)

/// tabbar动态显示和隐藏
/// @param hidden 是否隐藏
/// @param animated 动画
- (void)jx_setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
