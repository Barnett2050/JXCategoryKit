//
//  UIDeviceTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2021/4/29.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIDevice+JXGeneral.h"

@interface UIDeviceTests : XCTestCase

@end

@implementation UIDeviceTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    NSLog(@"---- %@",[UIDevice jx_getDeviceUserName]);
    NSLog(@"---- %@",[UIDevice jx_getDeviceModel]);
    NSLog(@"---- %@",[UIDevice jx_getDeviceSystemName]);
    NSLog(@"---- %@",[UIDevice jx_getDeviceSystemVersion]);
    NSLog(@"---- %f",[UIDevice jx_getDeviceBattery]);
    NSLog(@"---- %@",[UIDevice jx_getCurrentLocalLanguage]);
    NSLog(@"---- %@",[UIDevice jx_deviceName]);
    
    NSLog(@"---- %@",[UIDevice jx_getIDFA]);
    NSLog(@"---- %@",[UIDevice jx_getIDFV]);
    NSLog(@"---- %@",[UIDevice jx_getUUID]);
    
    NSLog(@"---- %f",[UIDevice jx_getDiskSpaceTotal]);
    NSLog(@"---- %f",[UIDevice jx_getDiskSpaceUsed]);
    NSLog(@"---- %f",[UIDevice jx_getDiskSpaceFree]);
    
    NSLog(@"---- %f",[UIDevice jx_memoryTotal]);
    NSLog(@"---- %f",[UIDevice jx_memoryUsed]);
    NSLog(@"---- %f",[UIDevice jx_memoryFree]);
    NSLog(@"---- %lld",[UIDevice jx_currentThreadMemoryUsage]);
    
    NSLog(@"---- %ld",[UIDevice jx_cpuCount]);
    NSLog(@"---- %f",[UIDevice jx_currentThreadCpuUsage]);
    NSLog(@"---- %@",[UIDevice jx_cpuUsagePerProcessor]);
    NSLog(@"---- %f",[UIDevice jx_cpuUsage]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
