//
//  UINavigationController+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/24.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UINavigationController+JXGeneral.h"
#import "UIImage+JXGenerate.h"

@implementation UINavigationController (JXGeneral)

- (void)jx_setNavigationBarColor:(UIColor *)barColor shadowColor:(UIColor *)shadowColor
{
    UIImage *barImg = [UIImage jx_squareImageWithColor:barColor targetSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 88.)];
    UIImage *shadowImg = [UIImage jx_squareImageWithColor:shadowColor targetSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 1.)];
    [self.navigationBar setBackgroundImage:barImg forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:shadowImg];
}

@end
