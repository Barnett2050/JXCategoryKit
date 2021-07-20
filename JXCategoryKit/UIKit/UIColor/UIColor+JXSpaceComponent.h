//
//  UIColor+JXSpaceComponent.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/21.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JXSpaceComponent)

#pragma mark - HSL

@property (nonatomic, readonly) CGFloat hue;
@property (nonatomic, readonly) CGFloat saturation;
@property (nonatomic, readonly) CGFloat brightness;
@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel; // 颜色空间模型。
@property (nullable, nonatomic, readonly) NSString *colorSpaceString; // 可读的色彩空间字符串。
/*
 Hue 是色盘上的度数(从 0 到 360) - 0 (或 360) 是红色,120 是绿色,240 是蓝色。Saturation 是百分比值;0% 意味着灰色,而 100% 是全彩。Lightness 同样是百分比值;0% 是黑色,100% 是白色
 */
/// 根据 HSL 创建返回
/// @param hue 色相分量 0 - 1.0
/// @param saturation 饱和度分量 0 - 1.0
/// @param lightness 亮度分量 0 - 1.0
/// @param alpha 透明度 0 - 1.0
+ (UIColor *)jx_colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;

/// 修改 HSL 返回新的
/// @param hueDelta 增加或者减小的值
- (UIColor *)jx_colorByChangeHue:(CGFloat)hueDelta saturation:(CGFloat)saturationDelta brightness:(CGFloat)brightnessDelta alpha:(CGFloat)alphaDelta;

#pragma mark - CMYK

/// CMYK颜色空间分量值创建并返回颜色对象。
/// @param cyan 青色 0 - 1.0
/// @param magenta 洋红色 0 - 1.0
/// @param yellow 黄色 0 - 1.0
/// @param black 黑色 0 - 1.0
/// @param alpha 透明度 0 - 1.0
+ (UIColor *)jx_colorWithCyan:(CGFloat)cyan magenta:(CGFloat)magenta yellow:(CGFloat)yellow black:(CGFloat)black alpha:(CGFloat)alpha;

/// 获取组成CMYK颜色空间中颜色的成分。
- (BOOL)jx_getCyan:(CGFloat *)cyan magenta:(CGFloat *)magenta yellow:(CGFloat *)yellow black:(CGFloat *)black alpha:(CGFloat *)alpha;

@end

NS_ASSUME_NONNULL_END
