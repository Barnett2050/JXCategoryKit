//
//  NSString+JXAttribute.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSString+JXAttribute.h"

@implementation NSString (JXAttribute)

- (NSMutableAttributedString *)jx_addAttributedWithKeyWordArr:(NSArray *)keyWordArr attributedDic:(NSDictionary<NSAttributedStringKey, id> *)attributedDic range:(NSRange)range
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self];
    
    if (keyWordArr.count == 0 || attributedDic.allValues.count == 0) {
        return attributeString;
    }
    
    for (NSString *keyWord in keyWordArr) {
        NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:[NSString stringWithFormat:@"%@",keyWord] options:NSRegularExpressionCaseInsensitive error:nil];
        
        [regex enumerateMatchesInString:self options:NSMatchingReportCompletion range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            [attributeString setAttributes:attributedDic range:result.range];
        }];
    }
    return attributeString;
}

- (NSMutableAttributedString *)jx_addAttributedWithKeyWordArr:(NSArray *)keyWordArr attributedDic:(NSDictionary<NSAttributedStringKey, id> *)attributedDic
{
    return [self jx_addAttributedWithKeyWordArr:keyWordArr attributedDic:attributedDic range:NSMakeRange(0, self.length)];
}
@end

/*
 NSFontAttributeName; //字体，value是UIFont对象
 NSParagraphStyleAttributeName;//绘图的风格（居中，换行模式，间距等诸多风格），value是NSParagraphStyle对象
 NSForegroundColorAttributeName;// 文字颜色，value是UIFont对象
 NSBackgroundColorAttributeName;// 背景色，value是UIFont
 NSLigatureAttributeName; //  字符连体，value是NSNumber
 NSKernAttributeName; // 字符间隔
 NSStrikethroughStyleAttributeName;//删除线，value是NSNumber
 NSUnderlineStyleAttributeName;//下划线，value是NSNumber
 NSStrokeColorAttributeName; //描绘边颜色，value是UIColor
 NSStrokeWidthAttributeName; //描边宽度，value是NSNumber
 NSShadowAttributeName; //阴影，value是NSShadow对象
 NSTextEffectAttributeName; //文字效果，value是NSString
 NSAttachmentAttributeName;//附属，value是NSTextAttachment 对象
 NSLinkAttributeName;//链接，value是NSURL or NSString
 NSBaselineOffsetAttributeName;//基础偏移量，value是NSNumber对象
 NSUnderlineColorAttributeName;//下划线颜色，value是UIColor对象
 NSStrikethroughColorAttributeName;//删除线颜色，value是UIColor
 NSObliquenessAttributeName; //字体倾斜
 NSExpansionAttributeName; //字体扁平化
 NSVerticalGlyphFormAttributeName;//垂直或者水平，value是 NSNumber，0表示水平，1垂直
 */

@implementation NSMutableDictionary (JXAttribute)

- (void)jx_addTextFont:(UIFont *)font
{
    if (font == nil) {
        return;
    }
    [self setValue:font forKey:NSFontAttributeName];
}
- (void)jx_addParagraphType:(NSParagraphStyle *)paragraphType
{
    if (paragraphType == nil) {
        return;
    }
    [self setValue:paragraphType forKey:NSParagraphStyleAttributeName];
}
- (void)jx_addTextColor:(UIColor *)textColor
{
    if (textColor == nil) {
        return;
    }
    [self setValue:textColor forKey:NSForegroundColorAttributeName];
}
- (void)jx_addBackgroundColor:(UIColor *)backgroundColor
{
    if (backgroundColor == nil) {
        return;
    }
    [self setValue:backgroundColor forKey:NSBackgroundColorAttributeName];
}
- (void)jx_addLigature:(BOOL)isLigature
{
    int number = isLigature ? 1 : 0;
    [self setValue:[NSNumber numberWithInt:number] forKey:NSLigatureAttributeName];
}
- (void)jx_addKernValue:(float)kernValue
{
    if (kernValue < 0) {
        return;
    }
    [self setValue:[NSNumber numberWithFloat:kernValue] forKey:NSKernAttributeName];
}
- (void)jx_addStrikethrough:(float)lineWidth color:(UIColor *)lineColor
{
    if (lineWidth > 0) {
        [self setValue:[NSNumber numberWithFloat:lineWidth] forKey:NSStrikethroughStyleAttributeName];
    }
    if (lineColor != nil) {
        [self setValue:lineColor forKey:NSStrikethroughColorAttributeName];
    }
}
- (void)jx_addUnderLine:(float)lineWidth color:(UIColor *)lineColor
{
    if (lineWidth > 0) {
        [self setValue:[NSNumber numberWithFloat:lineWidth] forKey:NSUnderlineStyleAttributeName];
    }
    if (lineColor != nil) {
        [self setValue:lineColor forKey:NSUnderlineColorAttributeName];
    }
}
- (void)jx_addStrokeColor:(UIColor *)color
{
    if (color == nil) {
        return;
    }
    [self setValue:color forKey:NSStrokeColorAttributeName];
}
- (void)jx_addStrokeWidth:(float)lineWidth
{
    if (lineWidth < 0) {
        return;
    }
    [self setValue:[NSNumber numberWithFloat:lineWidth] forKey:NSStrokeWidthAttributeName];
}
- (void)jx_addShadow:(CGSize)shadowOffset shadowBlurRadius:(float)shadowBlurRadius shadowColor:(UIColor *)shadowColor
{
    NSShadow *shadow = [[NSShadow alloc] init];
    if (!CGSizeEqualToSize(shadowOffset, CGSizeZero)) {
        shadow.shadowOffset = shadowOffset;
    }
    if (shadowBlurRadius > 0) {
        shadow.shadowBlurRadius = shadowBlurRadius;
    }
    if (shadowColor) {
        shadow.shadowColor = shadowColor;
    }
    [self setValue:shadow forKey:NSShadowAttributeName];
}
- (void)jx_addTextEffect:(NSString *)errect
{
    if (errect.length > 0) {
        [self setValue:errect forKey:NSTextEffectAttributeName];
    }
}
- (void)jx_addAttachment:(NSTextAttachment *)content
{
    if (content == nil) {
        return;
    }
    [self setValue:content forKey:NSAttachmentAttributeName];
}
- (void)jx_addLink:(NSString *)line
{
    [self setValue:[NSURL URLWithString:line] forKey:NSLinkAttributeName];
}
- (void)jx_addLineOffset:(float)offset
{
    [self setValue:[NSNumber numberWithFloat:offset] forKey:NSBaselineOffsetAttributeName];
}
- (void)jx_addObliqueness:(float)number
{
    [self setValue:[NSNumber numberWithFloat:number] forKey:NSObliquenessAttributeName];
}
- (void)jx_addExpansion:(float)number
{
    [self setValue:[NSNumber numberWithFloat:number] forKey:NSExpansionAttributeName];
}
- (void)jx_addComposing:(int)number
{
    int value = number > 0 ? 1 : 0;
    [self setValue:[NSNumber numberWithInt:value] forKey:NSVerticalGlyphFormAttributeName];
}

@end
