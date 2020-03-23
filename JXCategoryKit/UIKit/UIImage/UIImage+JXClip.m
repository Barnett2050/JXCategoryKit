//
//  UIImage+JXClip.m
//  CustomCategory
//
//  Created by edz on 2019/10/17.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIImage+JXClip.h"

@implementation UIImage (JXClip)

- (UIImage *)jx_clipImageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UIColor *bColor = borderColor;
    if (bColor == nil) {
        bColor = [UIColor clearColor];
    }
    // 图片的宽度和高度
    CGFloat imageWH = self.size.width > self.size.height ? self.size.height : self.size.width;
    // 设置圆环的宽度
    CGFloat border = borderWidth;
    // 圆形的宽度和高度
    CGFloat ovalWH = imageWH + 2 * border;
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), NO, 0);
    // 2.画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [bColor set];
    
    [path fill];
    
    // 3.设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(border, border, imageWH, imageWH)];
    [clipPath addClip];
    
    // 4.绘制图片
    [self drawAtPoint:CGPointMake(border, border)];
    
    // 5.获取图片
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return clipImage;
}
/**
 裁剪图片中的一块区域
 
 @param clipRect 裁剪区域
 */
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
/**
 拉伸图片
 @param edgeInsets 不进行拉伸的区域
 */
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
    UIImage *image = [self resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeTile];
    return image;
}
/*
 创建一个内容可拉伸，而边角不拉伸的图片，需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度。那么接下来的一个像素会被拉伸。例如，leftCapHeight为6，topCapHeight为8。那么，图片左边的6个像素，上边的8个像素。不会被拉伸，而左边的第7个像素，上边的第9个像素这一块区域将会被拉伸。剩余的部分也不会被拉伸。
 ***这个方法只能拉伸1x1的区域***
 */
- (UIImage *)jx_stretchableImage:(NSInteger)left top:(NSInteger)top
{
    UIImage *image = [self stretchableImageWithLeftCapWidth:left topCapHeight:top];
    return image;
}

/**
 将一张图片转换成新的尺寸
 */
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

- (UIImage *)jx_clipToSize:(CGSize)targetSize
           cornerRadius:(CGFloat)cornerRadius
                corners:(UIRectCorner)corners
        backgroundColor:(UIColor *)backgroundColor
           isEqualScale:(BOOL)isEqualScale
{
    if (targetSize.width < 0 || targetSize.height < 0) {
        return self;
    }
    UIGraphicsBeginImageContextWithOptions(targetSize, YES, [UIScreen mainScreen].scale);
    
    CGSize imgSize = self.size;
    
    CGSize resultSize = targetSize;
    if (isEqualScale) {
        CGFloat x = MAX(targetSize.width / imgSize.width, targetSize.height / imgSize.height);
        resultSize = CGSizeMake(x * imgSize.width, x * imgSize.height);
    }
    
    CGRect targetRect = (CGRect){0, 0, resultSize.width, resultSize.height};
    
    
    if (backgroundColor) {
        [backgroundColor setFill];
        CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
    }
    
    if (cornerRadius > 0) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
        CGContextClip(UIGraphicsGetCurrentContext());
    }
    
    [self drawInRect:targetRect];
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //  NSLog(@"time:%f  originalImageSize: %@, targetSize: %@",
    //        CFAbsoluteTimeGetCurrent() - timerval,
    //        NSStringFromCGSize(imgSize),
    //        NSStringFromCGSize(targetSize));
    
    return finalImage;
}

/**
 裁剪为全圆角图片
 */
- (UIImage *)jx_clipToCornerImageWithCornerRadius:(CGFloat)cornerRadius
{
    return [self jx_clipToSize:self.size cornerRadius:cornerRadius corners:UIRectCornerAllCorners backgroundColor:[UIColor whiteColor] isEqualScale:true];
}

- (UIImage *)jx_clipToCornerImageWithCornerRadius:(CGFloat)cornerRadius corners:(UIRectCorner)corners
{
    return [self jx_clipToSize:self.size cornerRadius:cornerRadius corners:corners backgroundColor:[UIColor whiteColor] isEqualScale:true];
}

@end
