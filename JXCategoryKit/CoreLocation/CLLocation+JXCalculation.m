//
//  CLLocation+JXCalculation.m
//  CustomCategory
//
//  Created by edz on 2019/10/24.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "CLLocation+JXCalculation.h"

@implementation CLLocation (JXCalculation)

+ (double)jx_getDistanceWithLat1:(double)latOne lon1:(double)lonOne withLat2:(double)latAnother lon2:(double)lonAnother
{
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:latOne longitude:lonOne];
    CLLocation *dist = [[CLLocation alloc] initWithLatitude:latAnother longitude:lonAnother];
    CLLocationDistance kilometers = [orig distanceFromLocation:dist];
    return kilometers;
}

+ (double)jx_getDistance:(CLLocationCoordinate2D)oneLocation withAnotherLocation:(CLLocationCoordinate2D)anotherLocation
{
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:oneLocation.latitude longitude:oneLocation.longitude];
    CLLocation *dist = [[CLLocation alloc] initWithLatitude:anotherLocation.latitude longitude:anotherLocation.longitude];
    CLLocationDistance kilometers = [orig distanceFromLocation:dist];
    return kilometers;
}

+(void)locationIsOutOfChina:(CLLocationCoordinate2D)location callBack:(void(^)(BOOL inChina))callBack
{
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
     [[[CLGeocoder alloc]init] reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
         if (error || placemarks.count == 0) {
             NSLog(@"不能确定是在中国");
         } else {
             CLPlacemark *placemark=[placemarks firstObject];
             if ([placemark.ISOcountryCode isEqualToString:@"CN"]) {
                 callBack(YES);
             } else {
                 callBack(NO);
             }
         }
    }];
}

+ (void)placeDescriptionFromLocation:(CLLocation *)location callBack:(void(^)(NSError *error,NSString *country,NSString *locality,NSString *subLocality,NSString *thoroughfare,NSString *name))callBack
{
    //注意地理编码一次只能定位到一个位置，不能同时定位
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    //根据经纬度获取地名
    [clGeoCoder reverseGeocodeLocation:location completionHandler: ^(NSArray *placemarks,NSError *error) {
        if (error == nil && placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            callBack(nil,placeMark.country,placeMark.locality,placeMark.subLocality,placeMark.thoroughfare,placeMark.name);
        }else if (error == nil && [placemarks count] == 0){
            callBack(nil,@"",@"",@"",@"",@"");
        }else if (error != nil){
            callBack(error,@"",@"",@"",@"",@"");
        }
    }];
}

+ (void)placemarksWithLocation:(NSString *)locationDescription callBack:(void(^)(NSError *error,NSArray <CLPlacemark *>*placemarks))callBack
{
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:locationDescription completionHandler:^(NSArray *placemarks, NSError *error) {
        // 注意：一个地名可能搜索出多个地址
        if ([placemarks count] > 0 && error == nil){
            callBack(nil,placemarks);
        }else if ([placemarks count] == 0 && error == nil){
            callBack(nil,nil);
        }else if (error != nil){
            callBack(error,nil);
        }
    }];
}

@end
