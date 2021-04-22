//
//  UIImage+JXGenerate.m
//  CustomCategory
//
//  Created by edz on 2019/10/17.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIImage+JXGenerate.h"
#import <CoreText/CoreText.h>

@implementation UIImage (JXGenerate)

+ (UIImage *)jx_cornerRadiusImageWithColor:(UIColor *)tintColor targetSize:(CGSize)targetSize corners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor
{
    UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);
    
    CGRect targetRect = (CGRect){0, 0, targetSize.width, targetSize.height};
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [tintColor CGColor]);
    CGContextFillRect(context, targetRect);

    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    if (cornerRadius != 0 && cornerRadius > 0) {
        UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);

        if (backgroundColor) {
            [backgroundColor setFill];
            CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
        }

        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
        CGContextClip(UIGraphicsGetCurrentContext());
        [finalImage drawInRect:targetRect];
        finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }

    return finalImage;
}
+ (UIImage *)jx_squareImageWithColor:(UIColor *)color targetSize:(CGSize)targetSize
{
    return [UIImage jx_cornerRadiusImageWithColor:color targetSize:targetSize corners:UIRectCornerAllCorners cornerRadius:0 backgroundColor:[UIColor whiteColor]];
}
+ (UIImage *)jx_cornerRadiusImageWithColor:(UIColor *)color targetSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius
{
    return [UIImage jx_cornerRadiusImageWithColor:color targetSize:targetSize corners:UIRectCornerAllCorners cornerRadius:cornerRadius backgroundColor:[UIColor whiteColor]];
}

+ (UIImage*)jx_gradientColorImageWithSize:(CGSize)size andColors:(NSArray*)colors startPoint:(CGPoint)startP
endPoint:(CGPoint)endP
{
    if (colors == nil || colors.count == 0) {
        return nil;
    }
    NSMutableArray *ar = [NSMutableArray array];
    
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start = startP;
    CGPoint end = endP;
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)jx_triangleImageWithSize:(CGSize)size color:(UIColor *)color direction:(TriangleDirection)direction
{
    size = CGSizeMake(size.width*[UIScreen mainScreen].scale, size.height*[UIScreen mainScreen].scale);
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIImage *myImage = [UIImage jx_squareImageWithColor:color targetSize:size];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint sPoints[3];//坐标点
    if (direction == TriangleDirection_Down) {
        sPoints[0] =CGPointMake(0, 0);//坐标1
        sPoints[1] =CGPointMake(size.width, 0);//坐标2
        sPoints[2] =CGPointMake(size.width/2, size.height);//坐标3
    } else if (direction == TriangleDirection_Up) {
        sPoints[0] =CGPointMake(size.width/2, 0);//坐标1
        sPoints[1] =CGPointMake(0, size.height);//坐标2
        sPoints[2] =CGPointMake(size.width, size.height);//坐标3
    } else if (direction == TriangleDirection_Left) {
        sPoints[0] =CGPointMake(size.width, 0);//坐标1
        sPoints[1] =CGPointMake(0, size.height/2);//坐标2
        sPoints[2] =CGPointMake(size.width, size.height);//坐标3
    } else if (direction == TriangleDirection_Right) {
        sPoints[0] =CGPointMake(0, 0);//坐标1
        sPoints[1] =CGPointMake(0, size.height);//坐标2
        sPoints[2] =CGPointMake(size.width, size.height/2);//坐标3
    }
    
    CGContextAddLines(context, sPoints, 3);//添加线
    CGContextClosePath(context);//封起来
    CGContextClip(context);
    [myImage drawInRect:rect];
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (nullable UIImage *)jx_imageWithEmoji:(NSString *)emoji size:(CGFloat)size
{
    if (emoji.length == 0) return nil;
    if (size < 1) return nil;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CTFontRef font = CTFontCreateWithName(CFSTR("AppleColorEmoji"), size * scale, NULL);
    if (!font) return nil;
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:emoji attributes:@{ (__bridge id)kCTFontAttributeName:(__bridge id)font, (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor whiteColor].CGColor }];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(NULL, size * scale, size * scale, 8, 0, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh);
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFTypeRef)str);
    CGRect bounds = CTLineGetBoundsWithOptions(line, kCTLineBoundsUseGlyphPathBounds);
    CGContextSetTextPosition(ctx, 0, -bounds.origin.y);
    CTLineDraw(line, ctx);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
    
    CFRelease(font);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(ctx);
    if (line)CFRelease(line);
    if (imageRef) CFRelease(imageRef);
    
    return image;
}

+ (UIImage *)jx_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
