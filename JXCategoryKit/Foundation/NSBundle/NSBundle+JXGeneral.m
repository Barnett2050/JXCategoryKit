//
//  NSBundle+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSBundle+JXGeneral.h"

@implementation NSBundle (JXGeneral)

#pragma mark - 获取应用名称
+ (NSString *)jx_getApplicationName
{
    NSDictionary *infoDictionary = [[self mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleName"];
    return app_Name;
}

#pragma mark - 获取应用版本号
+ (NSString *)jx_getApplicationVersion
{
    NSDictionary *infoDictionary = [[self mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}
#pragma mark - 获取BundleID
+ (NSString *)jx_getBundleID
{
    return [[self mainBundle] bundleIdentifier];
}

+ (NSString *)jx_getBuildVersion
{
    NSDictionary *infoDictionary = [[self mainBundle] infoDictionary];
    NSString *app_Build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_Build;
}
/**
 当前应用版本是否需要更新
 */
+ (BOOL)jx_currentAppVersionIsUpdateWith:(NSString *)newVersion
{
    NSString *currentVersion = [NSBundle jx_getApplicationVersion];
    BOOL flag = [newVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending;
    return flag;
}


@end
