//
//  NSBundle+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (JXGeneral)

/**
 获取app应用名称
 */
+ (NSString *)jx_getApplicationName;
/**
 获取 APP 应用版本, 1.0.0
 */
+ (NSString *)jx_getApplicationVersion;
/**
 获取BundleID,com.xxx.xxx
 */
+ (NSString *)jx_getBundleID;
/**
 获取编译版本,123
 */
+ (NSString *)jx_getBuildVersion;
/**
 当前应用版本是否需要更新
 */
+ (BOOL)jx_currentAppVersionIsUpdateWith:(NSString *)newVersion;

/**
 获取当前工程下自己创建的所有类

 @return 数组
 */
+ (NSArray <Class> *)jx_bundleOwnClassesInfo;

/**
 获取当前工程下所有类（含系统类、cocoPods类）
 
 @return 数组
 */
+ (NSArray <NSString *> *)jx_bundleAllClassesInfo;

@end

NS_ASSUME_NONNULL_END
