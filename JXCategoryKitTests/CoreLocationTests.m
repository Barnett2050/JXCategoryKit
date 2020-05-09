//
//  CoreLocationTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2020/4/28.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>

#import "CLLocation+JXConverter.h"
#import "CLLocation+JXCalculation.h"

@interface CoreLocationTests : XCTestCase

@property (nonatomic, assign) CLLocationCoordinate2D wgs84Location; // 地球坐标
@property (nonatomic, assign) CLLocationCoordinate2D gcj02Location; // 火星坐标
@property (nonatomic, assign) CLLocationCoordinate2D bd09Location; // 百度坐标

@end

@implementation CoreLocationTests

//- (void)setUp {
//    NSLog(@"CoreLocationTests准备----------------------------------------------------------------------");
//    self.wgs84Location = CLLocationCoordinate2DMake(39.915, 116.404);
//    self.gcj02Location = CLLocationCoordinate2DMake(39.916, 116.410);
//    self.bd09Location = CLLocationCoordinate2DMake(39.922, 116.416);
//}
//
//- (void)tearDown {
//    NSLog(@"CoreLocationTests结束----------------------------------------------------------------------");
//}
//
//- (void)test_JXConverter
//{
//    [self printWith:[CLLocation wgs84ToGcj02:self.wgs84Location]];
//    [self printWith:[CLLocation gcj02ToWgs84:self.gcj02Location]];
//    [self printWith:[CLLocation wgs84ToBd09:self.wgs84Location]];
//    [self printWith:[CLLocation gcj02ToBd09:self.gcj02Location]];
//    [self printWith:[CLLocation bd09ToGcj02:self.bd09Location]];
//    [self printWith:[CLLocation bd09ToWgs84:self.bd09Location]];
//}
//
//- (void)test_JXCalculation
//{
//    CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(40.89804, 106.9962);
//    CLLocationCoordinate2D location2 = CLLocationCoordinate2DMake(40.30524, 107.0077);
//    NSLog(@"距离：%.f",[CLLocation jx_getDistance:location1 withAnotherLocation:location2]);
//    NSLog(@"距离：%.f",[CLLocation jx_getDistanceWithLat1:location1.latitude lon1:location1.longitude withLat2:location2.latitude lon2:location2.longitude]);
//}
//
//- (void)printWith:(CLLocationCoordinate2D)location
//{
//    NSLog(@"%f----%f",location.latitude,location.longitude);
//}

@end
