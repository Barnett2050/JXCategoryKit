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

/// 两个坐标间的距离
/// @param latOne one维度
/// @param lngOne one经度
/// @param latAnother Another维度
/// @param lngAnother Another经度
+ (double)getKMDistance:(double)latOne withLng1:(double)lngOne withLat2:(double)latAnother withLng2:(double)lngAnother;

/// 两个坐标间的距离
/// @param oneLocation 第一个坐标
/// @param anotherLocation 另一个坐标
+ (double)getKMDistance:(CLLocationCoordinate2D)oneLocation withAnotherLocation:(CLLocationCoordinate2D)anotherLocation;

@end

NS_ASSUME_NONNULL_END
