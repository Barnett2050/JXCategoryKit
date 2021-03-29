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

- (void)setUp {
    // 三个指向同一坐标的不同坐标数值
    self.wgs84Location = CLLocationCoordinate2DMake(39.91488908, 116.40387397);
    self.gcj02Location = CLLocationCoordinate2DMake(39.91629336, 116.41011847);
    self.bd09Location = CLLocationCoordinate2DMake(39.92238898, 116.41658019);
}

- (void)tearDown {
}

- (void)test_JXConverter
{
    // 小数点后五位精确度基本在1米
    CLLocationCoordinate2D wgs84ToGcj02 = [CLLocation wgs84ToGcj02:self.wgs84Location];
    XCTAssertTrue((fabs(wgs84ToGcj02.latitude - self.gcj02Location.latitude) < 0.00001 &&
                   fabs(wgs84ToGcj02.longitude - self.gcj02Location.longitude) < 0.00001),@"地球坐标转换火星坐标");
   
    CLLocationCoordinate2D gcj02ToWgs84 = [CLLocation gcj02ToWgs84:self.gcj02Location];
    XCTAssertTrue((fabs(gcj02ToWgs84.latitude - self.wgs84Location.latitude) < 0.00001 &&
                   fabs(gcj02ToWgs84.longitude - self.wgs84Location.longitude) < 0.00001),@"火星坐标转换地球坐标");
    
    CLLocationCoordinate2D wgs84ToBd09 = [CLLocation wgs84ToBd09:self.wgs84Location];
    XCTAssertTrue((fabs(wgs84ToBd09.latitude - self.bd09Location.latitude) < 0.00001 &&
                   fabs(wgs84ToBd09.longitude - self.bd09Location.longitude) < 0.00001),@"地球坐标转换百度坐标");
    
    CLLocationCoordinate2D gcj02ToBd09 = [CLLocation gcj02ToBd09:self.gcj02Location];
    XCTAssertTrue((fabs(gcj02ToBd09.latitude - self.bd09Location.latitude) < 0.00001 &&
                   fabs(gcj02ToBd09.longitude - self.bd09Location.longitude) < 0.00001),@"火星坐标转换百度坐标");
    
    CLLocationCoordinate2D bd09ToGcj02 = [CLLocation bd09ToGcj02:self.bd09Location];
    XCTAssertTrue((fabs(bd09ToGcj02.latitude - self.gcj02Location.latitude) < 0.00001 &&
                   fabs(bd09ToGcj02.longitude - self.gcj02Location.longitude) < 0.00001),@"百度坐标转换火星坐标");
    
    CLLocationCoordinate2D bd09ToWgs84 = [CLLocation bd09ToWgs84:self.bd09Location];
    XCTAssertTrue((fabs(bd09ToWgs84.latitude - self.wgs84Location.latitude) < 0.00001 &&
                   fabs(bd09ToWgs84.longitude - self.wgs84Location.longitude) < 0.00001),@"百度坐标转换地球坐标");
}

- (void)test_JXCalculation
{
    CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(40.89804, 106.9962);
    CLLocationCoordinate2D location2 = CLLocationCoordinate2DMake(40.30524, 107.0077);
    XCTAssertTrue([CLLocation jx_getDistance:location1 withAnotherLocation:location2] == [CLLocation jx_getDistanceWithLat1:location1.latitude lon1:location1.longitude withLat2:location2.latitude lon2:location2.longitude],@"经纬度距离计算");
    NSLog(@"距离：%.f",[CLLocation jx_getDistance:location1 withAnotherLocation:location2]);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"IS IN CHINA"];
    [CLLocation locationIsOutOfChina:location1 callBack:^(BOOL inChina) {
        [expectation fulfill];
        XCTAssertTrue(inChina,@"坐标在中国境内");
    }];
    
    XCTestExpectation *expectation2 = [self expectationWithDescription:@"description"];
    [CLLocation placeDescriptionFromLocation:[[CLLocation alloc] initWithLatitude:location1.latitude longitude:location1.longitude] callBack:^(NSError * _Nonnull error, NSString * _Nonnull country, NSString * _Nonnull locality, NSString * _Nonnull subLocality, NSString * _Nonnull thoroughfare, NSString * _Nonnull name) {
        NSLog(@"%@-%@-%@-%@-%@",country,locality,subLocality,thoroughfare,name);
        [expectation2 fulfill];
    }];
    
    XCTestExpectation *expectation3 = [self expectationWithDescription:@"placemarks"];
    [CLLocation placemarksWithLocation:@"唐山" callBack:^(NSError * _Nonnull error, NSArray * _Nonnull placemarks) {
        for (CLPlacemark *placemark in placemarks) {
            NSLog(@"Longitude = %f", placemark.location.coordinate.longitude);
            NSLog(@"Latitude = %f", placemark.location.coordinate.latitude);
//            CLRegion *region = placemark.region;//区域
//            NSDictionary *addressDic = placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
//            NSString *name = placemark.name;//地名
//            NSString *thoroughfare = placemark.thoroughfare;//街道
//            NSString *subThoroughfare = placemark.subThoroughfare; //街道相关信息，例如门牌等
//            NSString *locality = placemark.locality; // 城市
//            NSString *subLocality = placemark.subLocality; // 城市相关信息，例如标志性建筑
//            NSString *administrativeArea = placemark.administrativeArea; // 州
//            NSString *subAdministrativeArea = placemark.subAdministrativeArea; //其他行政区域信息
//            NSString *postalCode = placemark.postalCode; //邮编
//            NSString *ISOcountryCode = placemark.ISOcountryCode; //国家编码
//            NSString *country = placemark.country; //国家
//            NSString *inlandWater = placemark.inlandWater; //水源、湖泊
//            NSString *ocean = placemark.ocean; // 海洋
//            NSArray *areasOfInterest = placemark.areasOfInterest; //关联的或利益相关的地标
        }
        [expectation3 fulfill];
    }];
    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        NSLog(@"异步操作超时");
    }];
}

@end
