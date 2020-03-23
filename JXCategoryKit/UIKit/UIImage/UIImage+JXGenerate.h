//
//  UIImage+JXGenerate.h
//  CustomCategory
//
//  Created by edz on 2019/10/17.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TriangleDirection) { // 生成三角图片方向
    TriangleDirection_Down,
    TriangleDirection_Left,
    TriangleDirection_Right,
    TriangleDirection_Up
};

@interface UIImage (JXGenerate)

/**
 生成带圆角的颜色图片

 @param tintColor 图片颜色
 @param targetSize 生成尺寸
 @param cornerRadius 圆角大小
 @param backgroundColor 背景颜色
 */
+ (UIImage *)jx_cornerRadiusImageWithColor:(UIColor *)tintColor targetSize:(CGSize)targetSize corners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor;

/**
 生成矩形的颜色图片

 @param color 图片颜色
 @param targetSize 生成尺寸
 */
+ (UIImage *)jx_squareImageWithColor:(UIColor *)color targetSize:(CGSize)targetSize;

/**
 生成带圆角的颜色图片,背景默认白色

 @param color 图片颜色
 @param targetSize 生成尺寸
 @param cornerRadius 圆角大小
 */
+ (UIImage *)jx_cornerRadiusImageWithColor:(UIColor *)color targetSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius;

/// 生成渐变色的UIImage
/// @param size 尺寸
/// @param colors 颜色数组
/// @param startP 开始坐标
/// @param endP 结束坐标
+ (UIImage*)jx_gradientColorImageWithSize:(CGSize)size andColors:(NSArray*)colors startPoint:(CGPoint)startP
endPoint:(CGPoint)endP;

/// 生成三角图片
/// @param size 尺寸
/// @param color 颜色
/// @param direction 三角方向
+ (UIImage *)jx_triangleImageWithSize:(CGSize)size color:(UIColor *)color direction:(TriangleDirection)direction;

@end

NS_ASSUME_NONNULL_END
