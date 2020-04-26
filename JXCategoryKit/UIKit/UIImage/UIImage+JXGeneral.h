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

@property (nonatomic,readonly) BOOL hasAlphaChannel; // 图片是否有透明
@property (nonatomic, readonly) NSString *base64String; // 转换图片为png格式的base64编码


/// 更新图片的方向，直立显示
- (UIImage *)jx_updateImageOrientation;

/// 拼接长图
/// @param headImage 头图
/// @param footImage 尾图
/// @param masterImgArr 主视图数组
/// @param edgeMargin 四周边距
/// @param imageSpace 图片间距
/// @param success 成功回调
+ (void)jx_generateLongPictureWithHeadImage:(UIImage *)headImage footImage:(UIImage *)footImage masterImages:(NSArray <UIImage *>*)masterImgArr edgeMargin:(UIEdgeInsets)edgeMargin imageSpace:(CGFloat)imageSpace success:(void(^)(UIImage *longImage,CGFloat totalHeight))success;

/// 根据图片url获取网络图片尺寸
+ (CGSize)jx_getImageSizeWithURL:(id)URL;

/// 压缩图片（压缩质量）压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；缺点在于，不能保证图片压缩后小于指定大小。
/// @param maxSize 图片大小 需要32kb直接传入32即可
- (NSData *)jx_compressImageDataWith:(int)maxSize;

/// 压缩图片(压缩大小) 压缩后图片明显比压缩质量模糊
/// @param maxSize 图片大小 需要32kb直接传入32即可
- (NSData *)jx_compressImageSizeWith:(int)maxSize;

/// 压缩图片(两种方法结合)
/// @param maxSize 图片大小 需要32kb直接传入32即可
- (NSData *)jx_compressImageCombineWith:(int)maxSize;

/// 使用GIF数据创建动画图像。 创建后，可以通过属性“ .images”访问图像。 如果数据不是动态gif，则此功能与[UIImage imageWithData：data scale：scale]相同；
/// @param data gif 数据
/// @param scale 比例
+ (nullable UIImage *)jx_imageWithSmallGIFData:(NSData *)data scale:(CGFloat)scale;

/// 数据是否为GIF动画。
/// @param data 数据
+ (BOOL)jx_isAnimatedGIFData:(NSData *)data;

/// 文件路径数据是否为GIF动画。
/// @param path 路径
+ (BOOL)jx_isAnimatedGIFFile:(NSString *)path;

/// 从PDF文件数据或路径创建图像。如果PDF有多页，则仅返回第一页的内容。 图像的比例等于当前屏幕的比例，尺寸与PDF的原始尺寸相同。
/// @param dataOrPath 数据或者路径
+ (nullable UIImage *)jx_imageWithPDF:(id)dataOrPath;

/// 从PDF文件数据或路径创建图像。如果PDF有多页，则仅返回第一页的内容。 图像的比例等于当前屏幕的比例，尺寸与PDF的原始尺寸相同。
/// @param dataOrPath 数据或者路径
/// @param size 尺寸
+ (nullable UIImage *)jx_imageWithPDF:(id)dataOrPath size:(CGSize)size;

/// 返回一个旋转图像
/// @param radians 逆时针旋转弧度
/// @param fitSize true：扩展新图像的大小以适合所有内容。false：图像的大小不会改变，内容可能会被剪切。
- (nullable UIImage *)jx_imageByRotate:(CGFloat)radians fitSize:(BOOL)fitSize;

@end

NS_ASSUME_NONNULL_END
