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

+ (BOOL)jx_userNotificationIsEnable
{
    BOOL isEnable = NO;
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    return isEnable;
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
                
            }else
            {
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
