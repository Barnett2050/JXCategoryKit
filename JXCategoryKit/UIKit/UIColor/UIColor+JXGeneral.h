//
//  UIColor+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JXGeneral)

/// 色值，0.0 ~ 1.0
@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat alpha;

#pragma mark - iOS 13.0 之后颜色设置

/// iOS 13.0 亮暗颜色设置
/// @param lightColor 浅色
/// @param darkColor 深色
+ (UIColor *)jx_colorWithLight:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

#pragma mark - 十进制

/// 传入十进制颜色生成UIColor
/// @param r 0~255
/// @param g 0~255
/// @param b 0~255
/// @param a 0~1.0
+ (UIColor *)jx_colorFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a;

/// 传入十进制颜色生成UIColor
/// @param r 0~255
/// @param g 0~255
/// @param b 0~255
+ (UIColor *)jx_colorFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;

#pragma mark - 十六进制

/// 传入十六进制颜色 返回UIColor
/// @param rgbaValue 0xffFFB6C1
+ (UIColor *)jx_colorFromRGBA:(uint32_t)rgbaValue;

/// 传入十六进制颜色 返回UIColor
/// @param rgbValue 0x66ccff
+ (UIColor *)jx_colorFromRGB:(uint32_t)rgbValue;

/// 传入十六进制颜色 和 透明度 返回UIColor
/// @param rgbValue 0x66ccff
/// @param alpha 0~1
+ (UIColor *)jx_colorFromRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

/// 传入十六进制字符串色值 返回UIColor
/// @param hexStr @"0xF0F", @"66ccff", @"#66CCFF88"
/// @param alpha 透明度，-1时表示取 hexStr 中透明度
+ (UIColor *)jx_colorFromHexString:(NSString *)hexStr alpha:(float)alpha;

/// 传入十六进制字符串色值（透明度默认为1）生成UIColor
/// @param hexStr 例：@"ededed"
+ (UIColor *)jx_colorFromHexString:(NSString *)hexStr;

/// 返回十六进制的rgb值。例：0x66ccff
- (uint32_t)jx_rgbValue;

/// 返回十六进制的rgb值。例：0x66ccffff
- (uint32_t)jx_rgbaValue;

/// 返回十六进制的rgba字符串值，例：0xffff0000
- (NSString*)jx_rgbaHexString;

/// 返回十六进制的rgb字符串值，例：#ff0000
- (NSString*)jx_rgbHexString;

@end

NS_ASSUME_NONNULL_END
