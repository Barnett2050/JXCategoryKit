//
//  NSString+JXSize.h
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (JXSize)

/**
 系统方法计算一段字符串的size
 于这个方法计算字符串的大小的通过取得字符串的size来计算, 如果你计算的字符串中包含\n\r 这样的字符，也只会把它当成字符来计算。但是在显示的时候就是\n是转义字符，那么显示的计算的高度就不一样了，所以可以采用：计算的高度 = boundingRectWithSize计算出来的高度 + \n\r转义字符出现的个数 * 单行文本的高度。

 @param attributeDic 字体属性字典
 @param maxSize 最大尺寸
 @return 字符串尺寸
 */
- (CGSize)jx_contenSizeWith:(NSDictionary<NSAttributedStringKey, id> *)attributeDic maxSize:(CGSize)maxSize;

/**
 CoreText计算单行文本
 这种方法支持包含emoji表情符的计算。文本开头空格、包含自定义插入的文本图片不纳入计算范围，这类情况会导致计算偏差。
 */
- (CGSize)jx_singleLineSizeWithAttributeText:(UIFont *)font;

/**
 CoreText计算多行文本size
 这种方法支持包含emoji表情符的计算。文本开头空格、包含自定义插入的文本图片不纳入计算范围，这类情况会导致计算偏差。
 */
- (CGSize)jx_multiLineSizeWithAttributeText:(CGFloat)width font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
