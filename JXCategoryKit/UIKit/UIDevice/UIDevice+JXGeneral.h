//
//  UIDevice+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (JXGeneral)

/**
 获取通用 - 关于本机 - 名称
 */
+ (NSString *)jx_getDeviceUserName;
/**
 获取设备类型
 
 @return iPhone/iTouch/iPad
 */
+ (NSString *)jx_getDeviceModel;
/**
 获取系统名称 iOS
 */
+ (NSString *)jx_getDeviceSystemName;
/**
 获取设备系统版本 13.3/12.0
 */
+ (NSString *)jx_getDeviceSystemVersion;

/**
 获取设备电量 0 .. 1.0. -1.0 if UIDeviceBatteryStateUnknown
 */
+ (CGFloat)jx_getDeviceBattery;

/**
 获取手机本地语言 zh-Hans-CN/en
 */
+ (NSString *)jx_getCurrentLocalLanguage;

/**
 获取 WiFi 信号强度，只有在WiFi显示时才能获取到
 */
+ (NSInteger)jx_getSignalStrength;
/// 获取IDFA
+ (NSString *)jx_getIDFA;

/// 获取IDFV
+ (NSString *)jx_getIDFV;

/// 获取UUID
+ (NSString *)jx_getUUID;
/// 获取设备名称，例：iPhone 11 Pro Max
+ (NSString *)jx_deviceName;
/**
 获取当前设备可用系统内存(单位：MB）
 */
+ (double)jx_getAvailableMemory;

/// 获取当前设备磁盘总容量(单位：MB）
+ (double)jx_getDiskTotalSpace;

/// 获取当前设备磁盘剩余容量(单位：MB）
+ (double)jx_getDiskFreeSpace;

@end

NS_ASSUME_NONNULL_END
