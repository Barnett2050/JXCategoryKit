//
//  UIColor+JXSpaceComponent.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/21.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "UIColor+JXSpaceComponent.h"

#define CLAMP_COLOR_VALUE(v) (v) = (v) < 0 ? 0 : (v) > 1 ? 1 : (v)

@implementation UIColor (JXSpaceComponent)

- (CGFloat)hue {
    CGFloat h = 0, s, b, a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return h;
}

- (CGFloat)saturation {
    CGFloat h, s = 0, b, a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return s;
}

- (CGFloat)brightness {
    CGFloat h, s, b = 0, a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    return b;
}

- (CGColorSpaceModel)colorSpaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (NSString *)colorSpaceString {
    CGColorSpaceModel model =  CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
    switch (model) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
            
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
            
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
            
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
            
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
            
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
            
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
            
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
            
        default:
            return @"ColorSpaceInvalid";
    }
}

+ (UIColor *)jx_colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha
{
    CGFloat r, g, b;
    if ([UIColor p_HSLToRGBWithHue:hue saturation:saturation lightness:lightness red:&r green:&g blue:&b]) {
        return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
    }
    return nil;
}

- (UIColor *)jx_colorByChangeHue:(CGFloat)hueDelta saturation:(CGFloat)saturationDelta brightness:(CGFloat)brightnessDelta alpha:(CGFloat)alphaDelta
{
    CGFloat hh, ss, bb, aa;
    if (![self getHue:&hh saturation:&ss brightness:&bb alpha:&aa]) {
        return self;
    }
    hh += hueDelta;
    ss += saturationDelta;
    bb += brightnessDelta;
    aa += alphaDelta;
    hh -= (int)hh;
    hh = hh < 0 ? hh + 1 : hh;
    ss = ss < 0 ? 0 : ss > 1 ? 1 : ss;
    bb = bb < 0 ? 0 : bb > 1 ? 1 : bb;
    aa = aa < 0 ? 0 : aa > 1 ? 1 : aa;
    return [UIColor colorWithHue:hh saturation:ss brightness:bb alpha:aa];
}

+ (UIColor *)jx_colorWithCyan:(CGFloat)cyan magenta:(CGFloat)magenta yellow:(CGFloat)yellow black:(CGFloat)black alpha:(CGFloat)alpha
{
    CGFloat r, g, b;
    [UIColor jx_CMYKToRGBWithCyan:cyan magenta:magenta yellow:yellow black:black red:&r green:&g blue:&b];
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}
- (BOOL)jx_getCyan:(CGFloat *)cyan magenta:(CGFloat *)magenta yellow:(CGFloat *)yellow black:(CGFloat *)black alpha:(CGFloat *)alpha
{
    CGFloat r, g, b, a;
    if (![self getRed:&r green:&g blue:&b alpha:&a]) {
        return NO;
    }
    [UIColor jx_RGBToCMYKWithRed:r green:g blue:b cyan:cyan magenta:magenta yellow:yellow black:black];
    *alpha = a;
    return YES;
}

#pragma mark - private

+ (BOOL)p_HSLToRGBWithHue:(CGFloat)h saturation:(CGFloat)s lightness:(CGFloat)l red:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b
{
    CLAMP_COLOR_VALUE(h);
    CLAMP_COLOR_VALUE(s);
    CLAMP_COLOR_VALUE(l);
    
    if (s == 0) { // 无饱和度，色相不确定（无色）
        *r = *g = *b = l;
        return false;
    }
    
    CGFloat q;
    q = (l <= 0.5) ? (l * (1 + s)) : (l + s - (l * s));
    if (q <= 0) {
        *r = *g = *b = 0.0;
    } else {
        *r = *g = *b = 0;
        int sextant;
        CGFloat m, sv, fract, vsf, mid1, mid2;
        m = l + l - q;
        sv = (q - m) / q;
        if (h == 1) h = 0;
        h *= 6.0;
        sextant = h;
        fract = h - sextant;
        vsf = q * sv * fract;
        mid1 = m + vsf;
        mid2 = q - vsf;
        switch (sextant) {
            case 0: *r = q; *g = mid1; *b = m; break;
            case 1: *r = mid2; *g = q; *b = m; break;
            case 2: *r = m; *g = q; *b = mid1; break;
            case 3: *r = m; *g = mid2; *b = q; break;
            case 4: *r = mid1; *g = m; *b = q; break;
            case 5: *r = q; *g = m; *b = mid2; break;
        }
    }
    return true;
}

+ (void)jx_CMYKToRGBWithCyan:(CGFloat)c magenta:(CGFloat)m yellow:(CGFloat)y black:(CGFloat)k red:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b
{
    CLAMP_COLOR_VALUE(c);
    CLAMP_COLOR_VALUE(m);
    CLAMP_COLOR_VALUE(y);
    CLAMP_COLOR_VALUE(k);
    
    *r = (1 - c) * (1 - k);
    *g = (1 - m) * (1 - k);
    *b = (1 - y) * (1 - k);
}
+ (void)jx_RGBToCMYKWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b cyan:(CGFloat *)c magenta:(CGFloat *)m yellow:(CGFloat *)y black:(CGFloat *)k {
    CLAMP_COLOR_VALUE(r);
    CLAMP_COLOR_VALUE(g);
    CLAMP_COLOR_VALUE(b);
    
    *c = 1 - r;
    *m = 1 - g;
    *y = 1 - b;
    *k = fmin(*c, fmin(*m, *y));
    
    if (*k == 1) {
        *c = *m = *y = 0;   // Pure black
    } else {
        *c = (*c - *k) / (1 - *k);
        *m = (*m - *k) / (1 - *k);
        *y = (*y - *k) / (1 - *k);
    }
}

@end
