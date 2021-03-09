//
//  NSString+JXAttribute.h
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSString (JXAttribute)

/// 一段字符串添加关键字属性
/// @param keyWordArr 关键字数组
/// @param attributedDic 属性字典
/// @param range 范围
- (NSMutableAttributedString *)jx_addAttributedWithKeyWordArr:(NSArray *)keyWordArr attributedDic:(NSDictionary<NSAttributedStringKey, id> *)attributedDic range:(NSRange)range;

/// 一段字符串添加关键字属性
/// @param keyWordArr 关键字数组
/// @param attributedDic 属性字典
- (NSMutableAttributedString *)jx_addAttributedWithKeyWordArr:(NSArray *)keyWordArr attributedDic:(NSDictionary<NSAttributedStringKey, id> *)attributedDic;

@end

@interface NSMutableDictionary (JXAttribute)

/**
 添加可变属性字体UIFont
 */
- (void)jx_addTextFont:(UIFont *)font;
/**
 paragraphType 绘图的风格（居中，换行模式，行间距等诸多风格）NSParagraphStyle
 */
- (void)jx_addParagraphType:(NSParagraphStyle *)paragraphType;
/**
 文字颜色UIColor
 */
- (void)jx_addTextColor:(UIColor *)textColor;
/**
 背景色UIColor
 */
- (void)jx_addBackgroundColor:(UIColor *)backgroundColor;
/**
 取值为NSNumber 对象(整数). 0 表示没有连体字符, 1 表示使用默认的连体字符. 一般中文用不到，在英文中可能出现相邻字母连笔的情况。
 */
- (void)jx_addLigature:(BOOL)isLigature;
/**
 添加字符间距
 
 @param kernValue 字符间距
 */
- (void)jx_addKernValue:(float)kernValue;
/**
 添加删除线
 
 @param lineWidth 线宽度
 @param lineColor 线颜色
 */
- (void)jx_addStrikethrough:(float)lineWidth color:(UIColor *)lineColor;
/**
 添加下划线
 */
- (void)jx_addUnderLine:(float)lineWidth color:(UIColor *)lineColor;
/**
 描绘边颜色
 */
- (void)jx_addStrokeColor:(UIColor *)color;
/**
 描边宽度
 */
- (void)jx_addStrokeWidth:(float)lineWidth;
/**
 阴影
 */
- (void)jx_addShadow:(CGSize)shadowOffset shadowBlurRadius:(float)shadowBlurRadius shadowColor:(UIColor *)shadowColor;
/**
 文字效果，取值为 NSString 对象，目前只有图版印刷效果可用，NSTextEffectLetterpressStyle
 */
- (void)jx_addTextEffect:(NSString *)errect;

/**
 附属,例如图片
 */
- (void)jx_addAttachment:(NSTextAttachment *)content;

/**
 链接
 */
- (void)jx_addLink:(NSString *)line;
/**
 基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏, 默认值是0
 */
- (void)jx_addLineOffset:(float)offset;

/**
 设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾, 默认值是0(表示没有倾斜)
 */
- (void)jx_addObliqueness:(float)number;

/**
 设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
 */
- (void)jx_addExpansion:(float)number;

/**
 设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本 在iOS中, 总是以横向排版
 */
- (void)jx_addComposing:(int)number;

@end
NS_ASSUME_NONNULL_END
