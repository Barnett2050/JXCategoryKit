//
//  UIImage+JXClip.m
//  CustomCategory
//
//  Created by edz on 2019/10/17.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIImage+JXClip.h"

@implementation UIImage (JXClip)

- (UIImage *)jx_imageClipRect:(CGRect)clipRect
{
    CGSize imageSize = self.size;
    if (clipRect.origin.x > imageSize.width || clipRect.origin.y > imageSize.height) {
        return nil;
    }
    if (clipRect.origin.x + clipRect.size.width > imageSize.width) {
        clipRect.size.width = imageSize.width - clipRect.origin.x;
    }
    if (clipRect.origin.y + clipRect.size.height > imageSize.height) {
        clipRect.size.height = imageSize.height - clipRect.origin.y;
    }
    UIImage *newImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([self CGImage], clipRect)];
    return newImage;
}

- (nullable UIImage *)jx_imageByRoundCornerRadius:(CGFloat)radius corners:(UIRectCorner)corners borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor borderLineJoin:(CGLineJoin)borderLineJoin
{
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        corners = tmp;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        // 先绘制图片
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth/2, borderWidth/2) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        // 再绘制边框
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale/2;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (nullable UIImage *)jx_imageByRoundCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor
{
    return [self jx_imageByRoundCornerRadius:radius
                                     corners:UIRectCornerAllCorners
                                 borderWidth:borderWidth
                                 borderColor:borderColor
                              borderLineJoin:kCGLineJoinMiter];
}

- (nullable UIImage *)jx_circleImageByBorderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor
{
    if (self.size.width == self.size.height) {
        return [self jx_imageByRoundCornerRadius:self.size.width/2 borderWidth:borderWidth borderColor:borderColor];
    }else
    {
        CGFloat min = MIN(self.size.width, self.size.height);
        CGFloat pointX = (self.size.width - min) / 2;
        CGFloat pointY = (self.size.height - min) / 2;
        UIImage *newImage = [self jx_imageClipRect:CGRectMake(pointX, pointY, min, min)];
        return [newImage jx_imageByRoundCornerRadius:min/2 borderWidth:borderWidth borderColor:borderColor];
    }
}

- (UIImage *)jx_resizableImage:(UIEdgeInsets)edgeInsets resizingMode:(UIImageResizingMode)resizingMode
{
    //    edgeInsets.top < 1 ? edgeInsets.top = 12 : 0;
    //    edgeInsets.left  < 1 ? edgeInsets.left = 12 : 0;
    //    edgeInsets.bottom < 1 ? edgeInsets.bottom = 12 : 0;
    //    edgeInsets.right  < 1 ? edgeInsets.right = 12 : 0;
    /*
     UIImageResizingModeTile  -  平铺
     UIImageResizingModeStretch  -  拉伸
     */
    UIImage *image = [self resizableImageWithCapInsets:edgeInsets resizingMode:resizingMode];
    return image;
}

- (UIImage *)jx_stretchableImage:(NSInteger)left top:(NSInteger)top
{
    UIImage *image = [self stretchableImageWithLeftCapWidth:left topCapHeight:top];
    return image;
}

- (UIImage *)jx_imageChangeSize:(CGSize)newSize isScale:(BOOL)isScale
{
    UIImage *newImage;
    if (isScale) {
        CGFloat width = CGImageGetWidth(self.CGImage);
        CGFloat height = CGImageGetHeight(self.CGImage);
        
        float verticalRadio = newSize.height*1.0/height;
        float horizontalRadio = newSize.width*1.0/width;
        
        float radio = 1;
        if(verticalRadio>1 && horizontalRadio>1)
        {
            radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
        }
        else
        {
            radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
        }
        
        width = width*radio;
        height = height*radio;
        
        int xPos = (newSize.width - width)/2;
        int yPos = (newSize.height-height)/2;
        
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(newSize);
        
        // 绘制改变大小的图片
        [self drawInRect:CGRectMake(xPos, yPos, width, height)];
        
        // 从当前context中创建一个改变大小后的图片
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 使当前的context出堆栈
        UIGraphicsEndImageContext();
    }else
    {
        UIGraphicsBeginImageContext(newSize);//根据当前大小创建一个基于位图图形的环境
        [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];//根据新的尺寸画出传过来的图片
        newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前环境当中得到重绘的图片
        UIGraphicsEndImageContext();//关闭当前环境
    }
    return newImage;
}

@end
