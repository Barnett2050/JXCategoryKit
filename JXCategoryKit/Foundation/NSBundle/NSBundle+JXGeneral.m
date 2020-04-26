//
//  NSBundle+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSBundle+JXGeneral.h"

@implementation NSBundle (JXGeneral)

+ (NSString *)jx_getApplicationName
{
    NSDictionary *infoDictionary = [[self mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleName"];
    return app_Name;
}

+ (NSString *)jx_getApplicationVersion
{
    NSDictionary *infoDictionary = [[self mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

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

+ (BOOL)jx_currentAppVersionIsUpdateWith:(NSString *)newVersion
{
    NSString *currentVersion = [NSBundle jx_getApplicationVersion];
    BOOL flag = [newVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending;
    return flag;
}


@end
