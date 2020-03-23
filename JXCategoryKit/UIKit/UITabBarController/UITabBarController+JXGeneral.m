//
//  UITabBarController+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/24.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UITabBarController+JXGeneral.h"
#import "UIImage+JXGenerate.h"

@implementation UITabBarController (JXGeneral)

- (void)jx_setTabBarColor:(UIColor *)barColor shadowColor:(UIColor *)shadowColor
{
    UIImage *barImg = [UIImage jx_squareImageWithColor:barColor targetSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 49.)];
    UIImage *shadowImg = [UIImage jx_squareImageWithColor:shadowColor targetSize:CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), 1.)];
    [[UITabBar appearance] setBackgroundImage:barImg];
    [[UITabBar appearance] setShadowImage:shadowImg];
}

- (void)jx_setTabbarTitleNormalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor
{
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = normalColor;
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = selectedColor;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end
