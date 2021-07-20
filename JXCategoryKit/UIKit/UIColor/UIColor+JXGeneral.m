//
//  UIColor+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIColor+JXGeneral.h"

@implementation UIColor (JXGeneral)

- (CGFloat)red {
    CGFloat r = 0, g, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r;
}

- (CGFloat)green {
    CGFloat r, g = 0, b, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return g;
}

- (CGFloat)blue {
    CGFloat r, g, b = 0, a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return b;
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

+ (UIColor *)jx_colorWithLight:(UIColor *)lightColor darkColor:(UIColor *)darkColor
{
    if (@available(iOS 13.0,*)) {
        UIColor *dynamicColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
         if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
             return lightColor;
         } else if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
             return darkColor;
         } else {
             return lightColor;
         }
        }];
        return dynamicColor;
    }else
    {
        return lightColor;
    }
}

+ (UIColor *)jx_colorFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a
{
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

+ (UIColor *)jx_colorFromRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b
{
    return [UIColor jx_colorFromRed:r green:g blue:b alpha:1.0];
}

+ (UIColor *)jx_colorFromRGBA:(uint32_t)rgbaValue
{
    CGFloat r= (rgbaValue & 0xFF000000) >> 24;
    CGFloat g= (rgbaValue & 0xFF0000) >> 16;
    CGFloat b= (rgbaValue & 0xFF00) >> 8;
    CGFloat a= (rgbaValue & 0xFF);
    
    return [UIColor jx_colorFromRed:r green:g blue:b alpha:a/255.0];
}

+ (UIColor *)jx_colorFromRGB:(uint32_t)rgbValue
{
    CGFloat r= (rgbValue & 0xFF0000) >> 16;
    CGFloat g= (rgbValue & 0xFF00) >> 8;
    CGFloat b= (rgbValue & 0xFF);
    return [UIColor jx_colorFromRed:r green:g blue:b];
}

+ (UIColor *)jx_colorFromRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha
{
    CGFloat r= (rgbValue & 0xFF0000) >> 16;
    CGFloat g= (rgbValue & 0xFF00) >> 8;
    CGFloat b= (rgbValue & 0xFF);
    return [UIColor jx_colorFromRed:r green:g blue:b alpha:alpha];
}

+ (UIColor *)jx_colorFromHexString:(NSString *)hexStr alpha:(float)alpha
{
    CGFloat r, g, b, a;
    if ([UIColor p_hexStrToRGBA:hexStr red:&r green:&g blue:&b alpha:&a]) {
        if (alpha == -1) {
            return [UIColor colorWithRed:r green:g blue:b alpha:a];
        }
        return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
    }
    return nil;
}

+ (UIColor *)jx_colorFromHexString:(NSString *)hexStr
{
    return [UIColor jx_colorFromHexString:hexStr alpha:1];
}

- (uint32_t)jx_rgbaValue
{
    CGFloat r = 0, g = 0, b = 0, a = 0;
    [self getRed:&r green:&g blue:&b alpha:&a];
    int8_t red = r * 255;
    uint8_t green = g * 255;
    uint8_t blue = b * 255;
    uint8_t alpha = a * 255;
    return (red << 24) + (green << 16) + (blue << 8) + (alpha);
}

- (NSString*)jx_rgbaHexString
{
    return [self p_hexStringWithAlpha:true];
}

- (NSString*)jx_rgbHexString
{
    return [self p_hexStringWithAlpha:false];
}

#pragma mark - private
- (NSString *)p_hexStringWithAlpha:(BOOL)withAlpha {
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"%02x%02x%02x";
    NSString *hex = nil;
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    } else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat,
               (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f),
               (NSUInteger)(components[2] * 255.0f)];
    }
    
    if (hex && withAlpha) {
        hex = [hex stringByAppendingFormat:@"%02lx",
               (unsigned long)(CGColorGetAlpha(self.CGColor) * 255.0 + 0.5)];
    }
    return hex;
}

+ (BOOL)p_hexStrToRGBA:(NSString *)rgbaValue red:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b alpha:(CGFloat *)a
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *rgbaString = [[rgbaValue stringByTrimmingCharactersInSet:set] uppercaseString];
    
    if ([rgbaString hasPrefix:@"#"]) {
        rgbaString = [rgbaString substringFromIndex:1];
    } else if ([rgbaString hasPrefix:@"0X"]){
        rgbaString = [rgbaString substringFromIndex:2];
    }
    
    NSInteger length = rgbaString.length;
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return false;
    }
    if (length < 5) {
        *r = [self p_hexStringToInt:[rgbaString substringWithRange:NSMakeRange(0, 1)]] / 255.0f;
        *g = [self p_hexStringToInt:[rgbaString substringWithRange:NSMakeRange(1, 1)]] / 255.0f;
        *b = [self p_hexStringToInt:[rgbaString substringWithRange:NSMakeRange(2, 1)]] / 255.0f;
        if (length == 4) {
            *a = [self p_hexStringToInt:[rgbaString substringWithRange:NSMakeRange(3, 1)]] / 255.0f;
        } else {
            *a = 1.0;
        }
    } else {
        *r = [self p_hexStringToInt:[rgbaString substringWithRange:NSMakeRange(0, 2)]] / 255.0f;
        *g = [self p_hexStringToInt:[rgbaString substringWithRange:NSMakeRange(2, 2)]] / 255.0f;
        *b = [self p_hexStringToInt:[rgbaString substringWithRange:NSMakeRange(4, 2)]] / 255.0f;
        if (length == 8) {
            *a = [self p_hexStringToInt:[rgbaString substringWithRange:NSMakeRange(6, 2)]] / 255.0f;
        } else {
            *a = 1.0;
        }
    }
    return true;
}

+ (NSUInteger)p_hexStringToInt:(NSString *)string
{
    unsigned int result = 0;
    [[NSScanner scannerWithString:string] scanHexInt:&result];
    return result;
}


@end
