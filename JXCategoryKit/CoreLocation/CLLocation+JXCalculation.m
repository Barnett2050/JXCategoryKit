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

+(BOOL)locationIsOutOfChina:(CLLocationCoordinate2D)location
{
    if (location.longitude < 72.004 || location.longitude > 137.8347 || location.latitude < 0.8293 || location.latitude > 55.8271)
        return YES;
    return NO;
}

+ (void)placeNameFromLocation:(CLLocation *)location
{
    //注意地理编码一次只能定位到一个位置，不能同时定位
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    //根据经纬度获取地名
    [clGeoCoder reverseGeocodeLocation:location completionHandler: ^(NSArray *placemarks,NSError *error) {
        
        if (error == nil && placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSLog(@"%@",placeMark.country); // 国家
            NSLog(@"%@",placeMark.locality); // 城市
            NSLog(@"%@",placeMark.subLocality); // 区
            NSLog(@"%@",placeMark.thoroughfare); // 街道
            NSLog(@"%@",placeMark.name); // 具体位置
        }else if (error == nil && [placemarks count] == 0){
            NSLog(@"No results were returned.");
        }
        else if (error != nil){
            NSLog(@"An error occurred = %@", error); }
    }];

}

+ (void)locationFromString:(NSString *)placeStr
{
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:placeStr completionHandler:^(NSArray*placemarks, NSError *error) {
        // 注意：一个地名可能搜索出多个地址
        if ([placemarks count] > 0 && error == nil){
            
            NSLog(@"坐标信息个数：%lu", (unsigned long)[placemarks count]);
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
            NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
//            CLRegion *region = firstPlacemark.region;//区域
//            NSDictionary *addressDic = firstPlacemark.addressDictionary;//详细地址信息字典,包含以下部分信息
//            NSString *name = firstPlacemark.name;//地名
//            NSString *thoroughfare = firstPlacemark.thoroughfare;//街道
//            NSString *subThoroughfare = firstPlacemark.subThoroughfare; //街道相关信息，例如门牌等
//            NSString *locality = firstPlacemark.locality; // 城市
//            NSString *subLocality = firstPlacemark.subLocality; // 城市相关信息，例如标志性建筑
//            NSString *administrativeArea = firstPlacemark.administrativeArea; // 州
//            NSString *subAdministrativeArea = firstPlacemark.subAdministrativeArea; //其他行政区域信息
//            NSString *postalCode = firstPlacemark.postalCode; //邮编
//            NSString *ISOcountryCode = firstPlacemark.ISOcountryCode; //国家编码
//            NSString *country = firstPlacemark.country; //国家
//            NSString *inlandWater = firstPlacemark.inlandWater; //水源、湖泊
//            NSString *ocean = firstPlacemark.ocean; // 海洋
//            NSArray *areasOfInterest = firstPlacemark.areasOfInterest; //关联的或利益相关的地标

        }
        else if ([placemarks count] == 0 &&
                 error == nil){
            NSLog(@"未找到坐标信息");
        }
        else if (error != nil){
            NSLog(@"错误 = %@", error.localizedDescription);
        }
    }];
}

@end
