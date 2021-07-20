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

#pragma mark - 设备信息
/// 获取 通用 - 关于本机 - 名称
+ (NSString *)jx_getDeviceUserName;

/// 获取设备类型 - iPhone/iTouch/iPad
+ (NSString *)jx_getDeviceModel;

/// 获取系统名称 - iOS
+ (NSString *)jx_getDeviceSystemName;

/// 获取设备系统版本 - 13.3/12.0
+ (NSString *)jx_getDeviceSystemVersion;

/// 获取设备电量 0 .. 1.0. -1.0 if UIDeviceBatteryStateUnknown
+ (CGFloat)jx_getDeviceBattery;

/// 获取手机本地语言 zh-Hans-CN/en
+ (NSString *)jx_getCurrentLocalLanguage;

/// 获取设备名称，例：iPhone 11 Pro Max
+ (NSString *)jx_deviceName;
#pragma mark - 设备标识
/// 获取IDFA
+ (NSString *)jx_getIDFA;

/// 获取IDFV
+ (NSString *)jx_getIDFV;

/// 获取UUID
+ (NSString *)jx_getUUID;
#pragma mark - 磁盘空间

/// 获取当前设备磁盘总容量(单位：MB）
+ (double)jx_getDiskSpaceTotal;

/// 获取当前设备磁盘剩余容量(单位：MB）
+ (double)jx_getDiskSpaceFree;

/// 获取当前设备磁盘使用容量(单位：MB）
+ (double)jx_getDiskSpaceUsed;

#pragma mark - 内存信息
/// 获取当前设备全部系统内存(单位：MB）
+ (double)jx_memoryTotal;
/// 获取当前设备使用系统内存(单位：MB）
+ (double)jx_memoryUsed;
/// 获取当前设备剩余系统内存(单位：MB）
+ (double)jx_memoryFree;
/// 当前线程占用内存（字节为单位）,（发生错误时为-1）
+ (int64_t)jx_currentThreadMemoryUsage;

#pragma mark - CPU信息
/// cpu数量
+ (NSUInteger)jx_cpuCount;
/// 当前线程CPU使用率，1.0表示100％。 （发生错误时为-1）
+ (float)jx_currentThreadCpuUsage;
/// 当前每个处理器的CPU使用率（NSNumber数组），1.0表示100％。 （发生错误时为零）
+ (NSArray <NSNumber *> *)jx_cpuUsagePerProcessor;
/// cpu使用率
+ (float)jx_cpuUsage;

@end

NS_ASSUME_NONNULL_END
