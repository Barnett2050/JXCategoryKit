//
//  UIDevice+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIDevice+JXGeneral.h"
#import <sys/utsname.h>

// idfa
#import <AdSupport/ASIdentifierManager.h>

// 获取当前设备可用内存及所占内存的头文件
#import <sys/sysctl.h>
#import <mach/mach.h>

@implementation UIDevice (JXGeneral)

#pragma mark - 获取通用 - 关于本机 - 名称
+ (NSString *)jx_getDeviceUserName
{
    UIDevice *dev = [self currentDevice];
    return dev.name;
}

#pragma mark - 获取设备类型
+ (NSString *)jx_getDeviceModel
{
    UIDevice *dev = [self currentDevice];
    return dev.model;
}

#pragma mark - 获取系统名称
+ (NSString *)jx_getDeviceSystemName
{
    UIDevice *dev = [self currentDevice];
    return dev.systemName;
}

#pragma mark - 获取设备版本号
+ (NSString *)jx_getDeviceSystemVersion
{
    UIDevice *dev = [self currentDevice];
    
    return dev.systemVersion;
}

#pragma mark - 获取设备电量
+ (CGFloat)jx_getDeviceBattery
{
    // 默认为NO.为NO的时候无法获取电池状态,也无法获取电池状态改变的回调.
    [UIDevice currentDevice].batteryMonitoringEnabled = true;
    CGFloat batteryLevel=[[UIDevice currentDevice] batteryLevel];
    return batteryLevel;
}

#pragma mark - 获取手机本地语言
+ (NSString *)jx_getCurrentLocalLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}

#pragma mark - 获取WiFi信号强度
+ (NSInteger)jx_getSignalStrength{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSString *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    
    NSInteger signalStrength = [[dataNetworkItemView valueForKey:@"_wifiStrengthBars"] integerValue];
    
    return signalStrength;
}

/**
 获取IDFA
 */
+ (NSString *)jx_getIDFA
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

/**
 获取IDFV
 */
+ (NSString *)jx_getIDFV
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

/**
 获取UUID
 */
+ (NSString *)jx_getUUID
{
    return [[NSUUID UUID] UUIDString];
}


/**
 获取当前设备可用内存(单位：MB）
 */
+ (double)jx_getAvailableMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

+ (double)jx_getDiskTotalSpace
{
    uint64_t totalSpace = 0;
    __autoreleasing NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalSpace = ((totalSpace/1024)/1024);
    }else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    return totalSpace;
}

+ (double)jx_getDiskFreeSpace
{
    uint64_t totalFreeSpace = 0;
    __autoreleasing NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = ((totalFreeSpace/1024)/1024);
    }else{
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
        
    }
    return totalFreeSpace;
}


+ (NSString *)jx_deviceName
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    // iPhone
    NSDictionary *phoneTypeDictionary = @{@"iPhone1,1":@"iPhone 2G",
                                          @"iPhone1,2":@"iPhone 3G",
                                          @"iPhone2,1":@"iPhone 3GS",
                                          @"iPhone3,1":@"iPhone 4",
                                          @"iPhone3,2":@"iPhone 4",
                                          @"iPhone3,3":@"iPhone 4",
                                          @"iPhone4,1":@"iPhone 4S",
                                          @"iPhone5,1":@"iPhone 5",
                                          @"iPhone5,2":@"iPhone 5",
                                          @"iPhone5,3":@"iPhone 5c",
                                          @"iPhone5,4":@"iPhone 5c",
                                          @"iPhone6,1":@"iPhone 5s",
                                          @"iPhone6,2":@"iPhone 5s",
                                          @"iPhone7,1":@"iPhone 6 Plus",
                                          @"iPhone7,2":@"iPhone 6",
                                          @"iPhone8,1":@"iPhone 6s",
                                          @"iPhone8,2":@"iPhone 6s",
                                          @"iPhone8,4":@"iPhone SE",
                                          @"iPhone9,1":@"iPhone 7",
                                          @"iPhone9,2":@"iPhone 7 Plus",
                                          @"iPhone9,3":@"iPhone 7",
                                          @"iPhone9,4":@"iPhone 7 Plus",
                                          @"iPhone10,1":@"iPhone 8",
                                          @"iPhone10,4":@"iPhone 8",
                                          @"iPhone10,2":@"iPhone 8 Plus",
                                          @"iPhone10,5":@"iPhone 8",
                                          @"iPhone10,3":@"iPhone X",
                                          @"iPhone10,6":@"iPhone X",
                                          @"iPhone11,8":@"iPhone XR",
                                          @"iPhone11,2":@"iPhone XS",
                                          @"iPhone11,6":@"iPhone XS Max",
                                          @"iPhone11,4":@"iPhone XS Max",
                                          @"iPhone12,1":@"iPhone 11",
                                          @"iPhone12,3":@"iPhone 11 Pro",
                                          @"iPhone12,5":@"iPhone 11 Pro Max"};
    if ([platform containsString:@"iPhone"]) {
        return [phoneTypeDictionary objectForKey:platform];
    }
    // iPod
    NSDictionary *podTypeDictionary = @{@"iPod1,1":@"iPod Touch 1G",
                                        @"iPod2,1":@"iPod Touch 2G",
                                        @"iPod3,1":@"iPod Touch 3G",
                                        @"iPod4,1":@"iPod Touch 4G",
                                        @"iPod5,1":@"iPod Touch 5G",
                                        @"iPod7,1":@"iPod Touch 6G",
                                        @"iPod9,1":@"iPod Touch 7G"};
    if ([platform containsString:@"iPod"]) {
        return [podTypeDictionary objectForKey:platform];
    }
    // iPad
    NSDictionary *padTypeDictionary = @{@"iPad1,1":@"iPad 1",
                                        @"iPad2,1":@"iPad 2",
                                        @"iPad2,2":@"iPad 2",
                                        @"iPad2,3":@"iPad 2",
                                        @"iPad2,4":@"iPad 2",
                                        @"iPad2,5":@"iPad mini 1",
                                        @"iPad2,6":@"iPad mini 1",
                                        @"iPad2,7":@"iPad mini 1",
                                        @"iPad3,1":@"iPad 3",
                                        @"iPad3,2":@"iPad 3",
                                        @"iPad3,3":@"iPad 3",
                                        @"iPad3,4":@"iPad 4",
                                        @"iPad3,5":@"iPad 4",
                                        @"iPad3,6":@"iPad 4",
                                        @"iPad4,1":@"iPad Air",
                                        @"iPad4,2":@"iPad Air",
                                        @"iPad4,3":@"iPad Air",
                                        @"iPad4,4":@"iPad mini 2",
                                        @"iPad4,5":@"iPad mini 2",
                                        @"iPad4,6":@"iPad mini 2",
                                        @"iPad4,7":@"iPad mini 3",
                                        @"iPad4,8":@"iPad mini 3",
                                        @"iPad4,9":@"iPad mini 3",
                                        @"iPad5,1":@"iPad mini 4",
                                        @"iPad5,2":@"iPad mini 4",
                                        @"iPad5,3":@"iPad Air 2",
                                        @"iPad5,4":@"iPad Air 2",
                                        @"iPad6,3":@"iPad Pro 9.7",
                                        @"iPad6,4":@"iPad Pro 9.7",
                                        @"iPad6,7":@"iPad Pro 12.9",
                                        @"iPad6,8":@"iPad Pro 12.9",
                                        @"iPad6,11":@"iPad 5",
                                        @"iPad6,12":@"iPad 5",
                                        @"iPad7,1":@"iPad Pro 2 12.9",
                                        @"iPad7,2":@"iPad Pro 2 12.9",
                                        @"iPad7,3":@"iPad Pro 10.5",
                                        @"iPad7,4":@"iPad Pro 10.5",
                                        @"iPad8,1":@"iPad Pro 11.0",
                                        @"iPad8,2":@"iPad Pro 11.0",
                                        @"iPad8,3":@"iPad Pro 11.0",
                                        @"iPad8,4":@"iPad Pro 11.0",
                                        @"iPad8,5":@"iPad Pro 3 12.9",
                                        @"iPad8,6":@"iPad Pro 3 12.9",
                                        @"iPad8,7":@"iPad Pro 3 12.9",
                                        @"iPad8,8":@"iPad Pro 3 12.9",
                                        @"iPad11,1":@"iPad mini 5",
                                        @"iPad11,2":@"iPad mini 5",
                                        @"iPad11,3":@"iPad Air 3",
                                        @"iPad11,4":@"iPad Air 3",
    };
    if ([platform containsString:@"iPad"]) {
        return [padTypeDictionary objectForKey:platform];
    }
    
    // 模拟器
    if ([platform isEqualToString:@"i386"] ||
        [platform isEqualToString:@"x86_64"]) {
        return @"iPhone Simulator";
    }
    
    return nil;
}

@end
