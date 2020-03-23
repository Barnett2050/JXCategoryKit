//
//  UIImage+JXEffect.m
//  CustomCategory
//
//  Created by edz on 2019/10/17.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIImage+JXEffect.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (JXEffect)

- (UIImage *)jx_blurImageWithCoreImageBlurNumber:(CGFloat)blurNum
{
    if (self == nil) {
        return nil;
    }
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage  *inputImage=[CIImage imageWithCGImage:self.CGImage];
    // 创建滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    // 设置滤镜输入的图像
    // 注意：这里的key可以写kCIInputImageKey，也可以写@“inputImage”
    [filter setValue:inputImage forKey:kCIInputImageKey];
    // 设置高斯模糊数值
    // 这里的key可以写kCIInputRadiusKey，也可以写@“inputRadius”。
    [filter setValue:@(blurNum) forKey:kCIInputRadiusKey];
    // 处理后图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

- (UIImage *)jx_blurImageWithAccelerateBlurValue:(CGFloat)blurValue
{
    if (self == nil)
    {
        return nil;
    }
    //模糊度,
    if (blurValue < 0.0f) {
        blurValue = 0.1f;
    } else if (blurValue > 1.0f) {
        blurValue = 1.0f;
    }
    //boxSize必须大于0
    int boxSize = (int)(blurValue * 100);
    boxSize -= (boxSize % 2) + 1;
    //图像处理
    CGImageRef img = self.CGImage;
    
    //需要引入#import <Accelerate/Accelerate.h>
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;

    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);

    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
       NSLog(@"error from convolution %ld", error);
    }
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                            outBuffer.data,
                                            outBuffer.width,
                                            outBuffer.height,
                                            8,
                                            outBuffer.rowBytes,
                                            colorSpace,
                                            CGImageGetBitmapInfo(self.CGImage));

    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    //CGColorSpaceRelease(colorSpace);   //多余的释放
    CGImageRelease(imageRef);
    return returnImage;
}

-(UIImage*)jx_applyLightEffect
{
    UIColor*tintColor =[UIColor colorWithWhite:1.0 alpha:0.3];
    return[self jx_applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}
-(UIImage*)jx_applyExtraLightEffect
{
    UIColor*tintColor =[UIColor colorWithWhite:0.97 alpha:0.82];
    return[self jx_applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}
-(UIImage*)jx_applyDarkEffect
{
    UIColor*tintColor =[UIColor colorWithWhite:0.11 alpha:0.73];
    return[self jx_applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}
-(UIImage*)jx_applyTintEffectWithColor:(UIColor*)tintColor
{
    const CGFloat EffectColorAlpha=0.6;
    UIColor*effectColor = tintColor;
    NSInteger componentCount =CGColorGetNumberOfComponents(tintColor.CGColor);
    if(componentCount ==2){
        CGFloat b;
        if([tintColor getWhite:&b alpha:NULL]){
            effectColor =[UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else{
        CGFloat r, g, b;
        if([tintColor getRed:&r green:&g blue:&b alpha:NULL]){
            effectColor =[UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return[self jx_applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}
-(UIImage*)jx_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor*)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(nullable UIImage*)maskImage
{
    // Check pre-conditions.
    if(self.size.width <1||self.size.height <1){
        NSLog(@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@",self.size.width,self.size.height,self);
        return nil;
    }
    if(!self.CGImage){
        NSLog(@"*** error: image must be backed by a CGImage: %@",self);
        return nil;
    }
    if(maskImage &&!maskImage.CGImage){
        NSLog(@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    CGRect imageRect ={CGPointZero,self.size };
    UIImage*effectImage =self;
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor -1.)> __FLT_EPSILON__;
    if(hasBlur || hasSaturationChange){
        UIGraphicsBeginImageContextWithOptions(self.size, NO,[[UIScreen mainScreen] scale]);
        CGContextRef effectInContext =UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext,1.0,-1.0);
        CGContextTranslateCTM(effectInContext,0,-self.size.height);
        CGContextDrawImage(effectInContext, imageRect,self.CGImage);
        vImage_Buffer effectInBuffer;
        effectInBuffer.data =CGBitmapContextGetData(effectInContext);
        effectInBuffer.width =CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height =CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes =CGBitmapContextGetBytesPerRow(effectInContext);
        UIGraphicsBeginImageContextWithOptions(self.size, NO,[[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext =UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data =CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width =CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height =CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes =CGBitmapContextGetBytesPerRow(effectOutContext);
        if(hasBlur){
            
            CGFloat inputRadius = blurRadius *[[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius *3.* sqrt(2* M_PI)/4+0.5);
            if(radius %2!=1){
                radius +=1;// force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer,&effectOutBuffer, NULL,0,0, (uint32_t)radius, (uint32_t)radius,0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer,&effectInBuffer, NULL,0,0, (uint32_t)radius, (uint32_t)radius,0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer,&effectOutBuffer, NULL,0,0, (uint32_t)radius, (uint32_t)radius,0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if(hasSaturationChange){
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[]={
                0.0722+0.9278* s,0.0722-0.0722* s,0.0722-0.0722* s,0,
                0.7152-0.7152* s,0.7152+0.2848* s,0.7152-0.7152* s,0,
                0.2126-0.2126* s,0.2126-0.2126* s,0.2126+0.7873* s,0,
                0,0,0,1,
            };
            const int32_t divisor =256;
            NSUInteger matrixSize =sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for(NSUInteger i =0; i < matrixSize;++i){
                saturationMatrix[i]=(int16_t)roundf(floatingPointSaturationMatrix[i]* divisor);
            }
            if(hasBlur){
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer,&effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else{
                vImageMatrixMultiply_ARGB8888(&effectInBuffer,&effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if(!effectImageBuffersAreSwapped)
            effectImage =UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if(effectImageBuffersAreSwapped)
            effectImage =UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO,[[UIScreen mainScreen] scale]);
    CGContextRef outputContext =UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext,1.0,-1.0);
    CGContextTranslateCTM(outputContext,0,-self.size.height);
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect,self.CGImage);
    // Draw effect image.
    if(hasBlur){
        CGContextSaveGState(outputContext);
        if(maskImage){
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    // Add in color tint.
    if(tintColor){
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    // Output image is ready.
    UIImage*outputImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

@end
