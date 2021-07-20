//
//  UIWindow+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIWindow+JXGeneral.h"

@implementation UIWindow (JXGeneral)

+ (UIWindow *)jx_getCurrentWindow
{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    UIWindow *tmpWin;
    for(NSInteger i = windows.count - 1; i >= 0; i --)
    {
        tmpWin = windows[i];
        if (tmpWin.windowLevel == UIWindowLevelNormal && tmpWin.rootViewController) {
            return tmpWin;
        }
    }
    return nil;
}

+ (UIViewController *)jx_topViewController
{
    UIWindow *window = [UIWindow jx_getCurrentWindow];
    UIViewController *result = nil;
    id nextResponder = nil;
    UIView *frontView = nil;
    for (NSInteger i = window.subviews.count - 1; i >= 0; i --) {
        frontView = window.subviews[i];
        if ([frontView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            frontView = [frontView.subviews lastObject];
        }
        nextResponder = [frontView nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
            result = nextResponder;
        else {
            frontView = nil;
            continue;
        }
        result = [UIWindow topViewController:result];
        break;
    }
    if (frontView == nil) {
        result = window.rootViewController;
        result = [UIWindow topViewController:result];
    }
    return result;
}

+ (UIViewController *)jx_visibleViewController
{
    UIViewController *rootViewController =[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    return [UIWindow getVisibleViewControllerFrom:rootViewController];
}

#pragma mark - private
+ (UIViewController *)topViewController:(UIViewController *)result
{
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [result valueForKeyPath:@"topViewController"];
    } else if ([result isKindOfClass:[UITabBarController class]]) {
        result = [result valueForKeyPath:@"selectedViewController"];
    } else {
        return result;
    }
    return [UIWindow topViewController:result];
}
+ (UIViewController *) getVisibleViewControllerFrom:(UIViewController *) vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [UIWindow getVisibleViewControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [UIWindow getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}
@end
