//
//  CLLocation+JXCalculation.m
//  CustomCategory
//
//  Created by edz on 2019/10/24.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "CLLocation+JXCalculation.h"

@implementation CLLocation (JXCalculation)

+ (double)getKMDistance:(double)latOne withLng1:(double)lngOne withLat2:(double)latAnother withLng2:(double)lngAnother
{
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:latOne longitude:lngOne];
    CLLocation *dist = [[CLLocation alloc] initWithLatitude:latAnother longitude:lngAnother];
    CLLocationDistance kilometers = [orig distanceFromLocation:dist] / 1000;
    return kilometers;
}

+ (double)getKMDistance:(CLLocationCoordinate2D)oneLocation withAnotherLocation:(CLLocationCoordinate2D)anotherLocation
{
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:oneLocation.latitude longitude:oneLocation.longitude];
    CLLocation *dist = [[CLLocation alloc] initWithLatitude:anotherLocation.latitude longitude:anotherLocation.longitude];
    CLLocationDistance kilometers = [orig distanceFromLocation:dist] / 1000;
    return kilometers;
}

@end
