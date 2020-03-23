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

/**
 传入十进制颜色
 */
+ (UIColor *)jx_colorFromRed:(CGFloat)R Green:(CGFloat)G Blue:(CGFloat)B Alpha:(CGFloat)A;
/**
 传入十六进制颜色
 
 @param RGBA 例：0xffFFB6C1
 */
+ (UIColor *)jx_colorFromRGBA:(int)RGBA;

/**
 传入十六进制字符串色值（透明度默认为1）
 
 @param string 例：@"ededed"
 */
+ (UIColor *)jx_hexColorWithString:(NSString *)string;

/**
 传入十六进制字符串色值
 
 @param string 例：@"ededed"
 @param alpha 透明度
 */
+ (UIColor *)jx_hexColorWithString:(NSString *)string alpha:(float) alpha;

- (uint)jx_hex;

/**
 转换为颜色字符串，例：0xffff0000
 */
- (NSString*)jx_hexString;
/**
 转换为颜色字符串，例：#ff0000
 */
- (NSString*)jx_cssString;

#pragma mark - iOS 13.0 之后颜色设置

/// 颜色设置
/// @param lightColor 浅色
/// @param darkColor 深色
+ (UIColor *)jx_colorWithLight:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END
