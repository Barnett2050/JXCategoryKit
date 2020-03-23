//
//  UIView+JXDraw.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JXDraw)

/**
 添加圆角，适用于自动布局，传入设置frame

 @param viewBounds 目标view的frame
 @param rectCorner 圆角位置
 @param radius 圆角大小
 */
- (void)jx_addRectCornerWith:(CGRect)viewBounds corner:(UIRectCorner)rectCorner cornerRadius:(CGFloat)radius;

/**
 添加圆角,适用于已知frame，即非自动布局

 @param rectCorner 圆角位置
 @param radius 圆角大小
 */
- (void)jx_addRectCornerWith:(UIRectCorner)rectCorner cornerRadius:(CGFloat)radius;

/**
 添加圆角，适用于已知frame，即非自动布局，圆角位置为UIRectCornerAllCorners

 @param radius 圆角大小
 */
- (void)jx_addAllCornerWith:(CGFloat)radius;

/**
 添加圆角，适用于自动布局，传入设置frame，圆角位置为UIRectCornerAllCorners

 @param viewBounds 目标view的frame
 @param radius 圆角大小
 */
- (void)jx_addAllCornerWith:(CGRect)viewBounds radius:(CGFloat)radius;

/**
 绘制虚线

 @param pointArr 通过NSStringFromCGPoint传入坐标数组
 @param lineWidth 虚线的宽度
 @param lineLength 虚线的长度
 @param lineSpacing 虚线的间距
 @param lineColor 虚线的颜色
 */
- (void)jx_drawDashLineWithpointArray:(NSArray *)pointArr lineWidth:(float)lineWidth lineLength:(float)lineLength lineSpacing:(float)lineSpacing lineColor:(UIColor *)lineColor;

@end

NS_ASSUME_NONNULL_END
