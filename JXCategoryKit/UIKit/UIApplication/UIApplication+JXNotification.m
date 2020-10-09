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
    if (@available(iOS 10.0, *)) {
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
    } else {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIUserNotificationTypeNone) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (authorityBlock) {
                    authorityBlock(NO);
                }
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (authorityBlock) {
                    authorityBlock(YES);
                }
            });
        }
    }
}

+ (void)jx_goToAppSystemSetting
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [application openURL:url options:@{} completionHandler:nil];
        } else {
            [application openURL:url];
        }
    }
}

+ (void)jx_registerRemoteNotificationWith:(id)centerDelegate
{
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        // 模拟器无法进行注册
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            if(@available(iOS 10.0,*)){
                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                center.delegate = centerDelegate;
                [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
                    if( !error ){
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [[UIApplication sharedApplication] registerForRemoteNotifications];
                        });
                    }
                }];
                
            } else {
                UIApplication *application = [UIApplication sharedApplication];
                if ([application
                     respondsToSelector:@selector(registerUserNotificationSettings:)]) {
                    //8.0-10.0
                    UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                            settingsForTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound |UIUserNotificationTypeAlert)
                                                            categories:nil];
                    [application registerUserNotificationSettings:settings];
                }
                
            }
        });
    }
}
@end
