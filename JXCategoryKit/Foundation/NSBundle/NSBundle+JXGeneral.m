//
//  NSBundle+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSBundle+JXGeneral.h"
#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/ldsyms.h>

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

+ (NSArray <Class> *)jx_bundleOwnClassesInfo {
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    unsigned int classCount;
    const char **classes;
    Dl_info info;
    
    dladdr(&_mh_execute_header, &info);
    classes = objc_copyClassNamesForImage(info.dli_fname, &classCount);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_apply(classCount, dispatch_get_global_queue(0, 0), ^(size_t index) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSString *className = [NSString stringWithCString:classes[index] encoding:NSUTF8StringEncoding];
        Class class = NSClassFromString(className);
        [resultArray addObject:class];
        dispatch_semaphore_signal(semaphore);
    });
    
    return resultArray.mutableCopy;
}

+ (NSArray <NSString *> *)jx_bundleAllClassesInfo {
    
    NSMutableArray *resultArray = [NSMutableArray new];

    int classCount = objc_getClassList(NULL, 0);

    Class *classes = NULL;
    classes = (__unsafe_unretained Class *)malloc(sizeof(Class) *classCount);
    classCount = objc_getClassList(classes, classCount);

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_apply(classCount, dispatch_get_global_queue(0, 0), ^(size_t index) {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        Class class = classes[index];
        NSString *className = [[NSString alloc] initWithUTF8String: class_getName(class)];
        [resultArray addObject:className];
        dispatch_semaphore_signal(semaphore);
    });

    free(classes);
    
    return resultArray.mutableCopy;
}

@end
