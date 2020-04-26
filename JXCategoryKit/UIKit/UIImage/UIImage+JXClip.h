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

/// 裁剪图片中的一块区域
/// @param clipRect 裁剪区域
- (UIImage *)jx_imageClipRect:(CGRect)clipRect;

/// 图片裁剪
/// @param radius 圆角值
/// @param corners 圆角位置，可 | 多个圆角
/// @param borderWidth 边框宽度
/// @param borderColor 边框颜色
/// @param borderLineJoin 边界线相交类型
- (nullable UIImage *)jx_imageByRoundCornerRadius:(CGFloat)radius corners:(UIRectCorner)corners borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor borderLineJoin:(CGLineJoin)borderLineJoin;

/// 图片裁剪，默认全圆角
/// @param radius 圆角值
/// @param borderWidth 边框宽度
/// @param borderColor 边框颜色
- (nullable UIImage *)jx_imageByRoundCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor;

/// 图片裁剪，默认圆形，长宽不同自动截取中间部分
/// @param borderWidth 边框宽度
/// @param borderColor 边框颜色
- (nullable UIImage *)jx_circleImageByBorderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor;

/// 拉伸图片
/// @param edgeInsets 不进行拉伸的区域
/// @param resizingMode 处理方式
- (UIImage *)jx_resizableImage:(UIEdgeInsets)edgeInsets resizingMode:(UIImageResizingMode)resizingMode;

/// 创建一个内容可拉伸，而边角不拉伸的图片，例如，leftCapHeight为6，topCapHeight为8。那么，图片左边的6个像素，上边的8个像素。不会被拉伸，而左边的第7个像素，上边的第9个像素这一块区域将会被拉伸。剩余的部分也不会被拉伸。***这个方法只能拉伸1x1的区域***
/// @param left 左边不拉伸区域的宽度
/// @param top 上面不拉伸的高度
- (UIImage *)jx_stretchableImage:(NSInteger)left top:(NSInteger)top;

/// 改变图片尺寸
/// @param newSize 新尺寸
/// @param isScale 是否按照比例转换
- (UIImage *)jx_imageChangeSize:(CGSize)newSize isScale:(BOOL)isScale;

@end

NS_ASSUME_NONNULL_END
