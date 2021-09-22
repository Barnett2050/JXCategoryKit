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

+ (NSString *)jx_getDeviceUserName
{
    UIDevice *dev = [self currentDevice];
    return dev.name;
}

+ (NSString *)jx_getDeviceModel
{
    UIDevice *dev = [self currentDevice];
    return dev.model;
}

+ (NSString *)jx_getDeviceSystemName
{
    UIDevice *dev = [self currentDevice];
    return dev.systemName;
}

+ (NSString *)jx_getDeviceSystemVersion
{
    UIDevice *dev = [self currentDevice];
    
    return dev.systemVersion;
}

+ (CGFloat)jx_getDeviceBattery
{
    // 默认为NO.为NO的时候无法获取电池状态,也无法获取电池状态改变的回调.
    [UIDevice currentDevice].batteryMonitoringEnabled = true;
    CGFloat batteryLevel=[[UIDevice currentDevice] batteryLevel];
    return batteryLevel;
}

+ (NSString *)jx_getCurrentLocalLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}

+ (NSString *)jx_deviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
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
                                          @"iPhone8,4":@"iPhone SE (1st generation)",
                                          @"iPhone9,1":@"iPhone 7",
                                          @"iPhone9,2":@"iPhone 7 Plus",
                                          @"iPhone9,3":@"iPhone 7",
                                          @"iPhone9,4":@"iPhone 7 Plus",
                                          @"iPhone10,1":@"iPhone 8",
                                          @"iPhone10,4":@"iPhone 8",
                                          @"iPhone10,2":@"iPhone 8 Plus",
                                          @"iPhone10,5":@"iPhone 8 Plus",
                                          @"iPhone10,3":@"iPhone X",
                                          @"iPhone10,6":@"iPhone X",
                                          @"iPhone11,8":@"iPhone XR",
                                          @"iPhone11,2":@"iPhone XS",
                                          @"iPhone11,6":@"iPhone XS Max",
                                          @"iPhone11,4":@"iPhone XS Max",
                                          @"iPhone12,1":@"iPhone 11",
                                          @"iPhone12,3":@"iPhone 11 Pro",
                                          @"iPhone12,5":@"iPhone 11 Pro Max",
                                          @"iPhone12,8":@"iPhone SE (2nd generation)",
                                          @"iPhone13,1":@"iPhone 12 mini",
                                          @"iPhone13,2":@"iPhone 12",
                                          @"iPhone13,3":@"iPhone 12 Pro",
                                          @"iPhone13,4":@"iPhone 12 Pro Max",
                                          
    };
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
                                        @"iPad7,5":@"iPad 6",
                                        @"iPad7,6":@"iPad 6",
                                        @"iPad7,11":@"iPad 7",
                                        @"iPad7,12":@"iPad 7",
                                        @"iPad8,1":@"iPad Pro 11.0",
                                        @"iPad8,2":@"iPad Pro 11.0",
                                        @"iPad8,3":@"iPad Pro 11.0",
                                        @"iPad8,4":@"iPad Pro 11.0",
                                        @"iPad8,5":@"iPad Pro 3 12.9",
                                        @"iPad8,6":@"iPad Pro 3 12.9",
                                        @"iPad8,7":@"iPad Pro 3 12.9",
                                        @"iPad8,8":@"iPad Pro 3 12.9",
                                        @"iPad8,9":@"iPad Pro 2 11.0",
                                        @"iPad8,10":@"iPad Pro 2 11.0",
                                        @"iPad8,11":@"iPad Pro 4 12.9",
                                        @"iPad8,12":@"iPad Pro 4 12.9",
                                        @"iPad11,1":@"iPad mini 5",
                                        @"iPad11,2":@"iPad mini 5",
                                        @"iPad11,3":@"iPad Air 3",
                                        @"iPad11,4":@"iPad Air 3",
                                        @"iPad11,6":@"iPad 8",
                                        @"iPad11,7":@"iPad 8",
                                        @"iPad13,1":@"iPad Air 4",
                                        @"iPad13,2":@"iPad Air 4"
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


+ (NSString *)jx_getIDFA
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)jx_getIDFV
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (NSString *)jx_getUUID
{
    return [[NSUUID UUID] UUIDString];
}

+ (double)jx_getDiskSpaceTotal
{    
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    return space/1024/1024;
}

+ (double)jx_getDiskSpaceFree
{
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space/1024/1024;
}

+ (double)jx_getDiskSpaceUsed
{
    double total = [self jx_getDiskSpaceTotal];
    double free = [self jx_getDiskSpaceFree];
    if (total < 0 || free < 0) return -1;
    double used = total - free;
    if (used < 0) used = -1;
    return used;
}

+ (double)jx_memoryTotal
{
    int64_t mem = [[NSProcessInfo processInfo] physicalMemory];
    return mem/1024/1024;
}

+ (double)jx_memoryUsed
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    double used = page_size * (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count);
    return used/1024/1024;
}

+ (double)jx_memoryFree
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    double free = vm_stat.free_count * page_size;
    return free/1024/1024;
}

+ (int64_t)jx_currentThreadMemoryUsage
{
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kern = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&info, &size);
    if (kern != KERN_SUCCESS) return -1;
    return info.resident_size;
}

+ (NSUInteger)jx_cpuCount
{
    return [NSProcessInfo processInfo].activeProcessorCount;
}

+ (float)jx_currentThreadCpuUsage
{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    thread_array_t thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < thread_count; j++) {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE;
        }
    }
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    return tot_cpu;
}
+ (NSArray <NSNumber *> *)jx_cpuUsagePerProcessor
{
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = { CTL_HW, HW_NCPU };
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    if (_status)
        _numCPUs = 1;
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    if (err == KERN_SUCCESS) {
        [_cpuUsageLock lock];
        
        NSMutableArray *cpus = [NSMutableArray new];
        for (unsigned i = 0U; i < _numCPUs; ++i) {
            Float32 _inUse, _total;
            if (_prevCPUInfo) {
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            [cpus addObject:@(_inUse / _total)];
        }
        
        [_cpuUsageLock unlock];
        if (_prevCPUInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        return cpus;
    } else {
        return nil;
    }
}
/// cpu使用率
+ (float)jx_cpuUsage
{
    float cpu = 0;
    NSArray *cpus = [UIDevice jx_cpuUsagePerProcessor];
    if (cpus.count == 0) return -1;
    for (NSNumber *n in cpus) {
        cpu += n.floatValue;
    }
    return cpu;
}


@end
