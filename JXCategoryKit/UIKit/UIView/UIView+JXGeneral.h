//
//  UIView+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JXGeneral)

/**
 截图
 */
- (UIImage *)jx_snapshot;

/**
 截取 view 上某个位置的图像
 */
- (UIImage *)jx_cutoutInViewWithRect:(CGRect)rect;
/**
 毛玻璃效果
 
 @param blurStyle 程度
 */
- (void)jx_addBlurEffectWith:(UIBlurEffectStyle)blurStyle;

@end

NS_ASSUME_NONNULL_END
