//
//  UIImage+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/17.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIImage+JXGeneral.h"

@implementation UIImage (JXGeneral)

- (UIImage *)jx_updateImageOrientation
{
    if (self != nil) {
        // 如果方向已经正确，则不进行操作
        if (self.imageOrientation == UIImageOrientationUp){
            return self;
        }
        else{
            
            // 我们需要计算出正确的变换，使图像直立。
            CGAffineTransform transform = CGAffineTransformIdentity;
            UIImageOrientation orientation=self.imageOrientation;
            switch (orientation) {
                case UIImageOrientationDown:
                case UIImageOrientationDownMirrored:
                    transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
                    transform = CGAffineTransformRotate(transform, M_PI);
                    break;
                    
                case UIImageOrientationLeft:
                case UIImageOrientationLeftMirrored:
                    transform = CGAffineTransformTranslate(transform, self.size.width, 0);
                    transform = CGAffineTransformRotate(transform, M_PI_2);
                    break;
                    
                case UIImageOrientationRight:
                case UIImageOrientationRightMirrored:
                    transform = CGAffineTransformTranslate(transform, 0, self.size.height);
                    transform = CGAffineTransformRotate(transform, -M_PI_2);
                    break;
                default:
                    break;
            }
            
            switch (orientation) {
                case UIImageOrientationDownMirrored:
                    transform = CGAffineTransformTranslate(transform, self.size.width, 0);
                    transform = CGAffineTransformScale(transform, -1, 1);
                    break;
                    
                case UIImageOrientationLeftMirrored:
                case UIImageOrientationRightMirrored:
                    transform = CGAffineTransformTranslate(transform, self.size.height, 0);
                    transform = CGAffineTransformScale(transform, -1, 1);
                    break;
                default:
                    break;
            }
            
            // 现在我们将底层的CGImage绘制到一个新的上下文中，应用变换
            CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                                     CGImageGetBitsPerComponent(self.CGImage), 0,
                                                     CGImageGetColorSpace(self.CGImage),
                                                     CGImageGetBitmapInfo(self.CGImage));
            CGContextConcatCTM(ctx, transform);
            switch (self.imageOrientation) {
                case UIImageOrientationLeft:
                case UIImageOrientationLeftMirrored:
                case UIImageOrientationRight:
                case UIImageOrientationRightMirrored:
                    // Grr...
                    CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
                    break;
                    
                default:
                    CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
                    break;
            }
            // 从绘图环境中创建一个新的UIImage
            CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
            UIImage *img = [UIImage imageWithCGImage:cgimg];
            CGContextRelease(ctx);
            CGImageRelease(cgimg);
            return img;
        }
    }
    return nil;
}

- (NSString *)jx_base64String
{
    NSData *data = UIImagePNGRepresentation(self);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    return encodedImageStr;
}

/**
 拼接长图
 */
+ (void)jx_generateLongPictureWithHeadImage:(UIImage *)headImage footImage:(UIImage *)footImage masterImages:(NSArray <UIImage *>*)masterImgArr edgeMargin:(UIEdgeInsets)edgeMargin imageSpace:(CGFloat)imageSpace success:(void(^)(UIImage *longImage,CGFloat totalHeight))success
{
    NSAssert(masterImgArr.count != 0, @"主视图不能为空");
    // 总高度
    CGFloat totalH = edgeMargin.top;
    CGFloat headH = 0;
    CGFloat footH = 0;
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - edgeMargin.left - edgeMargin.right;
    if (headImage) {
        // 有头图
        CGFloat headScale = headImage.size.height / headImage.size.width;
        headH = headScale * width;
        totalH += headH;
    }
    if (masterImgArr.count != 0) {
        // 主视图
        for (int i = 0; i < masterImgArr.count; i++) {
            UIImage *masterImage = masterImgArr[i];
            CGFloat masterImgScale = masterImage.size.height / masterImage.size.width;
            CGFloat masterImgH = masterImgScale * width;
            
            totalH += masterImgH;
        }
        totalH += masterImgArr.count * imageSpace;
    }
    
    if (footImage) {
        // 底图
        totalH += imageSpace;
        CGFloat footScale = footImage.size.height / footImage.size.width;
        footH = footScale * width;
        totalH += footH;
    }else
    {
        totalH -= imageSpace;
    }
    totalH += edgeMargin.bottom;
    totalH = floor(totalH);
    
    // 绘制画布
    CGFloat maxY = edgeMargin.top;
    CGSize contextSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, totalH);
    UIGraphicsBeginImageContextWithOptions(contextSize, false, [UIScreen mainScreen].scale);
    if (headImage) {
        [headImage drawInRect:CGRectMake(edgeMargin.left, maxY, width, headH)];
        maxY += headH;
        maxY += imageSpace;
    }
    if (masterImgArr.count != 0) {
        // 主视图
        for (int i = 0; i < masterImgArr.count; i++) {
            UIImage *masterImage = masterImgArr[i];
            CGFloat masterImgScale = masterImage.size.height / masterImage.size.width;
            CGFloat masterImgH = masterImgScale * width;
            if (i != 0) {
                maxY += imageSpace;
            }
            [masterImage drawInRect:CGRectMake(edgeMargin.left, maxY, width, masterImgH)];
            maxY += masterImgH;
        }
    }
    if (footImage) {
        maxY += imageSpace;
        [footImage drawInRect:CGRectMake(edgeMargin.left, maxY, width, footH)];
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (success) {
        success(resultImage,totalH);
    }
}

/**
 根据URL获取尺寸
 */
+ (CGSize)jx_getImageSizeWithURL:(id)URL
{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    
    if (imageSourceRef) {
        
        // 获取图像属性
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        
        //以下是对手机32位、64位的处理
        if (imageProperties != NULL) {
            
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            /***************** 此处解决返回图片宽高相反问题 *****************/
            // 图像旋转的方向属性
            NSInteger orientation = [(__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyOrientation) integerValue];
            CGFloat temp = 0;
            switch (orientation) {  // 如果图像的方向不是正的，则宽高互换
                case UIImageOrientationLeft: // 向左逆时针旋转90度
                case UIImageOrientationRight: // 向右顺时针旋转90度
                case UIImageOrientationLeftMirrored: // 在水平翻转之后向左逆时针旋转90度
                case UIImageOrientationRightMirrored: { // 在水平翻转之后向右顺时针旋转90度
                    temp = width;
                    width = height;
                    height = temp;
                }
                    break;
                default:
                    break;
            }
            /***************** 此处解决返回图片宽高相反问题 *****************/
            
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

- (NSData *)jx_compressImageDataWith:(int)maxSize
{
//    CGFloat maxFileSize = imageDataSize*1024;
//    CGFloat compression = 0.9f;
//    CGFloat maxCompression = 0.1f;
//    NSData *compressedData = UIImageJPEGRepresentation(self, compression);
//    while ([compressedData length] > maxFileSize && compression > maxCompression) {
//        compression -= 0.1;
//        compressedData = UIImageJPEGRepresentation(self, compression);
//    }
//    return compressedData;
    
    // 二分法
    CGFloat compression = 1;
    CGFloat maxFileSize = maxSize*1024;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxFileSize) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxFileSize * 0.9) {
            min = compression;
        } else if (data.length > maxFileSize) {
            max = compression;
        } else {
            break;
        }
    }

    return data;
}

- (NSData *)jx_compressImageSizeWith:(int)maxSize
{
    UIImage *resultImage = self;
    NSData *data = UIImageJPEGRepresentation(resultImage, 1);
    NSUInteger lastDataLength = 0;
    CGFloat maxFileSize = maxSize*1024;
    while (data.length > maxFileSize && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = maxFileSize / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        // 使用图像绘制(drawInRect:)，图像较大，但压缩时间更长
        // 使用结果图像绘制，图像更小，但压缩时间更短
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return data;
}

- (NSData *)jx_compressImageCombineWith:(int)maxSize
{
    CGFloat maxFileSize = maxSize*1024;
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxFileSize) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxFileSize * 0.9) {
            min = compression;
        } else if (data.length > maxFileSize) {
            max = compression;
        } else {
            break;
        }
    }
    if (data.length < maxFileSize) return data;
    
    // Compress by size
    UIImage *resultImage = [UIImage imageWithData:data];
    NSUInteger lastDataLength = 0;
    while (data.length > maxFileSize && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = maxFileSize / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return data;
}
@end
