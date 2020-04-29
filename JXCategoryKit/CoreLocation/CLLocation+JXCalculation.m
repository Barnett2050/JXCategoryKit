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

@end
