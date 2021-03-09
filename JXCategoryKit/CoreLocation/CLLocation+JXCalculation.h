//
//  CLLocation+JXCalculation.h
//  CustomCategory
//
//  Created by edz on 2019/10/24.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLLocation (JXCalculation)

/// 两个坐标间的距离，单位 米
/// @param latOne one维度
/// @param lonOne one经度
/// @param latAnother Another维度
/// @param lonAnother Another经度
+ (double)jx_getDistanceWithLat1:(double)latOne lon1:(double)lonOne withLat2:(double)latAnother lon2:(double)lonAnother;

/// 两个坐标间的距离，单位 米
/// @param oneLocation 第一个坐标
/// @param anotherLocation 另一个坐标
+ (double)jx_getDistance:(CLLocationCoordinate2D)oneLocation withAnotherLocation:(CLLocationCoordinate2D)anotherLocation;

/// 判断是否已经超出中国范围
/// @param location 坐标
/// @param callBack 回调
+(void)locationIsOutOfChina:(CLLocationCoordinate2D)location callBack:(void(^)(BOOL inChina))callBack;

/// 根据坐标获取位置描述（逆地理编码）
/// @param location 坐标
/// @param callBack 回调 国家-country 城市-locality 区-subLocality 街道-thoroughfare 具体位置-name
+ (void)placeDescriptionFromLocation:(CLLocation *)location callBack:(void(^)(NSError *error,NSString *country,NSString *locality,NSString *subLocality,NSString *thoroughfare,NSString *name))callBack;

/// 根据地址获取坐标（地理编码）
/// @param locationDescription 地址描述
+ (void)placemarksWithLocation:(NSString *)locationDescription callBack:(void(^)(NSError *error,NSArray <CLPlacemark *>*placemarks))callBack;

@end

NS_ASSUME_NONNULL_END
