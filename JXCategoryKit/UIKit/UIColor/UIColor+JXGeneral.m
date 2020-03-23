//
//  UIColor+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIColor+JXGeneral.h"

@implementation UIColor (JXGeneral)

+ (UIColor *)jx_colorFromRed:(CGFloat)R Green:(CGFloat)G Blue:(CGFloat)B Alpha:(CGFloat)A
{
    return [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A/255.0f];
}

+ (UIColor *)jx_colorFromRGBA:(int)RGBA
{
    CGFloat r= (RGBA & 0x00FF0000) >> 16 ;
    CGFloat g= (RGBA & 0x0000FF00) >> 8  ;
    CGFloat b= (RGBA & 0x000000FF) >> 0  ;
    CGFloat a= (RGBA & 0xFF000000) >> 24 ;
    
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}

+ (UIColor *)jx_hexColorWithString:(NSString *)string
{
    return [UIColor jx_hexColorWithString:string alpha:1.0f];
}

+ (UIColor *)jx_hexColorWithString:(NSString *)string alpha:(float) alpha
{
    if ([string hasPrefix:@"#"]) {
        string = [string substringFromIndex:1];
    }
    
    NSString *pureHexString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([pureHexString length] != 6) {
        return [UIColor whiteColor];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [pureHexString substringWithRange:range];
    
    range.location += range.length ;
    NSString *gString = [pureHexString substringWithRange:range];
    
    range.location += range.length ;
    NSString *bString = [pureHexString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

- (uint)jx_hex
{
    CGFloat red, green, blue, alpha;
    if (![self getRed:&red green:&green blue:&blue alpha:&alpha])
    {
        [self getWhite:&red alpha:&alpha];
        green = red;
        blue = red;
    }
    
    red = roundf(red * 255.f);
    green = roundf(green * 255.f);
    blue = roundf(blue * 255.f);
    alpha = roundf(alpha * 255.f);
    
    return ((uint)alpha << 24) | ((uint)red << 16) | ((uint)green << 8) | ((uint)blue);
}

- (NSString*)jx_hexString
{
    return [NSString stringWithFormat:@"0x%08x", [self jx_hex]];
}

- (NSString*)jx_cssString
{
    uint hex = [self jx_hex];
    if ((hex & 0xFF000000) == 0xFF000000)
    {
        return [NSString stringWithFormat:@"#%06x", hex & 0xFFFFFF];
    }
    
    return [NSString stringWithFormat:@"#%08x", hex];
}

+ (UIColor *)jx_colorWithLight:(UIColor *)lightColor darkColor:(UIColor *)darkColor
{
    if (@available(iOS 13.0,*)) {
        UIColor *dynamicColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
         if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
             return lightColor;
         }else if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark)
         {
             return darkColor;
         }else
         {
             return lightColor;
         }
        }];
        return dynamicColor;
    }else
    {
        return lightColor;
    }
}

@end
