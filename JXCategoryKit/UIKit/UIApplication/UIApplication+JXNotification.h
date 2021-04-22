//
//  UIApplication+JXNotification.h
//  CustomCategory
//
//  Created by edz on 2020/3/4.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (JXNotification)

/// 通知是否启用
+ (void)jx_userNotificationIsEnable:(void(^)(BOOL isEnable))authorityBlock;

/// 跳转App系统通知设置
+ (void)jx_goToAppSystemSetting;

/// 注册通知
/// @param centerDelegate 协议对象
+ (void)jx_registerRemoteNotificationWith:(id)centerDelegate;

@end

NS_ASSUME_NONNULL_END
