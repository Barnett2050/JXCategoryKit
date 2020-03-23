//
//  UIImage+JXClip.h
//  CustomCategory
//
//  Created by edz on 2019/10/17.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JXClip)

/**
 裁剪为有边界的圆形图片
 
 @param borderWidth 边宽
 @param borderColor 边颜色
 */
- (UIImage *)jx_clipImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 裁剪图片中的一块区域
 
 @param clipRect 裁剪区域
 */
- (UIImage *)jx_imageClipRect:(CGRect)clipRect;

/// 拉伸图片
/// @param edgeInsets 不进行拉伸的区域
/// @param resizingMode 处理方式
- (UIImage *)jx_resizableImage:(UIEdgeInsets)edgeInsets resizingMode:(UIImageResizingMode)resizingMode;

/*
 创建一个内容可拉伸，而边角不拉伸的图片，需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度。那么接下来的一个像素会被拉伸。例如，leftCapHeight为6，topCapHeight为8。那么，图片左边的6个像素，上边的8个像素。不会被拉伸，而左边的第7个像素，上边的第9个像素这一块区域将会被拉伸。剩余的部分也不会被拉伸。
 ***这个方法只能拉伸1x1的区域***
 */
- (UIImage *)jx_stretchableImage:(NSInteger)left top:(NSInteger)top;

/**
 改变图片尺寸
 
 @param newSize 新尺寸
 @param isScale 是否按照比例转换
 */
- (UIImage *)jx_imageChangeSize:(CGSize)newSize isScale:(BOOL)isScale;

/**
 裁剪图片圆角
 
 @param targetSize 目标尺寸
 @param cornerRadius 圆角大小
 @param corners 圆角位置
 @param backgroundColor 背景颜色
 @param isEqualScale 是否等比缩放
 */
- (UIImage *)jx_clipToSize:(CGSize)targetSize
           cornerRadius:(CGFloat)cornerRadius
                corners:(UIRectCorner)corners
        backgroundColor:(UIColor *)backgroundColor
           isEqualScale:(BOOL)isEqualScale;
/**
 裁剪为全圆角图片
 */
- (UIImage *)jx_clipToCornerImageWithCornerRadius:(CGFloat)cornerRadius;

/**
 裁剪圆角图片
 
 @param cornerRadius 圆角大小
 @param corners 圆角位置
 */
- (UIImage *)jx_clipToCornerImageWithCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners;

@end

NS_ASSUME_NONNULL_END
