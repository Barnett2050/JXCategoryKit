//
//  UIApplication+JXNotification.m
//  CustomCategory
//
//  Created by edz on 2020/3/4.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "UIApplication+JXNotification.h"
#import <UserNotifications/UserNotifications.h>

@implementation UIApplication (JXNotification)

+ (void)jx_userNotificationIsEnable:(void(^)(BOOL isEnable))authorityBlock
{
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
            // 用户未授权通知
            dispatch_async(dispatch_get_main_queue(), ^{
                if (authorityBlock) {
                    authorityBlock(NO);
                }
            });
        } else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            // 用户已授权通知
            dispatch_async(dispatch_get_main_queue(), ^{
                if (authorityBlock) {
                    authorityBlock(YES);
                }
            });
        } else if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
            // 用户未判断
            dispatch_async(dispatch_get_main_queue(), ^{
                if (authorityBlock) {
                    authorityBlock(NO);
                }
            });
        }
    }];
}

+ (void)jx_goToAppSystemSetting
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        [application openURL:url options:@{} completionHandler:nil];
    }
}

+ (void)jx_registerRemoteNotificationWith:(id)centerDelegate
{
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        // 模拟器无法进行注册
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            center.delegate = centerDelegate;
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
                if( !error ){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[UIApplication sharedApplication] registerForRemoteNotifications];
                    });
                }
            }];
        });
    }
}
@end
