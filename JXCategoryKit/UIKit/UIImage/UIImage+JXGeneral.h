//
//  UIImage+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/17.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JXGeneral)

/**
 更新图片的方向，直立显示
 */
- (UIImage *)jx_updateImageOrientation;

/**
 转换图片为png格式的base64编码
 */
- (NSString *)jx_base64String;

/**
 拼接长图

 @param headImage 头图
 @param footImage 尾图
 @param masterImgArr 主视图数组
 @param edgeMargin 四周边距
 @param imageSpace 图片间距
 @param success 成功回调
 */
+ (void)jx_generateLongPictureWithHeadImage:(UIImage *)headImage footImage:(UIImage *)footImage masterImages:(NSArray <UIImage *>*)masterImgArr edgeMargin:(UIEdgeInsets)edgeMargin imageSpace:(CGFloat)imageSpace success:(void(^)(UIImage *longImage,CGFloat totalHeight))success;

/**
 根据图片url获取网络图片尺寸
 */
+ (CGSize)jx_getImageSizeWithURL:(id)URL;

/**
 压缩图片（压缩质量）
 压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；缺点在于，不能保证图片压缩后小于指定大小。
 @param maxSize 图片大小 需要32kb直接传入32即可
 @return data
 */
- (NSData *)jx_compressImageDataWith:(int)maxSize;

/**
 压缩图片(压缩大小)
 压缩后图片明显比压缩质量模糊
 @param maxSize 图片大小 需要32kb直接传入32即可
 @return data
 */
- (NSData *)jx_compressImageSizeWith:(int)maxSize;


/**
 压缩图片(两种方法结合)

 @param maxSize 图片大小 需要32kb直接传入32即可
 @return data
 */
- (NSData *)jx_compressImageCombineWith:(int)maxSize;

@end

NS_ASSUME_NONNULL_END
