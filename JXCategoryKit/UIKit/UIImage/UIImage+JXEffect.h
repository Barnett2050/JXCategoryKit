//
//  UIImage+JXEffect.h
//  CustomCategory
//
//  Created by edz on 2019/10/17.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JXEffect)

/// 使用CoreImage技术使图片模糊
/// @param blurNum 模糊数值 0~100 （默认100）
- (UIImage *)jx_blurImageWithCoreImageBlurNumber:(CGFloat)blurNum;

/// 使用Accelerate技术模糊图片，模糊效果比CoreImage效果更美观，效率要比CoreImage要高，处理速度快
/// @param blurValue 模糊数值 0 ~ 1.0，默认0.1
- (UIImage *)jx_blurImageWithAccelerateBlurValue:(CGFloat)blurValue;

/// 高亮模糊
-(UIImage *)jx_applyLightEffect;

/// 轻度亮模糊
-(UIImage *)jx_applyExtraLightEffect;

/// 暗色模糊
-(UIImage *)jx_applyDarkEffect;

/// 自定义颜色模糊图片
/// @param tintColor 影响颜色
-(UIImage *)jx_applyTintEffectWithColor:(UIColor*)tintColor;

/// 模糊图片
/// @param blurRadius 模糊半径
/// @param tintColor 颜色
/// @param saturationDeltaFactor 饱和增量因子 0 图片色为黑白 小于0颜色反转 大于0颜色增深
/// @param maskImage 遮罩图像
-(UIImage*)jx_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor*)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(nullable UIImage*)maskImage;

@end

NS_ASSUME_NONNULL_END
