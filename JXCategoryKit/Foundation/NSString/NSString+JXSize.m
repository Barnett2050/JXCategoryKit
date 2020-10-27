//
//  NSString+JXSize.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSString+JXSize.h"
#import <CoreText/CoreText.h>

@implementation NSString (JXSize)

- (CGSize)jx_contenSizeWith:(NSDictionary<NSAttributedStringKey, id> *)attributeDic maxSize:(CGSize)maxSize
{
    //设置字符串属性
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:self];
    if (attributeDic.count != 0) {
        [attributed addAttributes:attributeDic range:NSMakeRange(0, [self length])];
    }
    /* 计算文字尺寸
     NSStringDrawingUsesLineFragmentOrigin:绘制文本时使用 *line fragement origin *而不是 baseline origin。一般使用这项。
     NSStringDrawingUsesFontLeading:根据字体计算高度
     NSStringDrawingUsesDeviceMetrics:使用象形文字计算高度
     NSStringDrawingTruncatesLastVisibleLine:如果NSStringDrawingUsesLineFragmentOrigin设置，这个选项没有用
     */
    CGSize stringSize = [attributed boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    CGSize newSize = CGSizeMake(ceil(stringSize.width), ceil(stringSize.height));
    return newSize;
}

/**
 CoreText计算多行文本size
 这种方法支持包含emoji表情符的计算。文本开头空格、包含自定义插入的文本图片不纳入计算范围，这类情况会导致计算偏差。
 */
- (CGSize)jx_coreTextAttributeTextSizeWith:(CGFloat)width font:(UIFont *)font
{
    NSString *fontName = font.fontName;
    if ([font.fontName isEqualToString:@".SFUI-Regular"]) {
        fontName = @"TimesNewRomanPSMT";
    }
    CTFontRef cfFont = CTFontCreateWithName((CFStringRef) fontName, font.pointSize, NULL);
    CGFloat leading = font.lineHeight - font.ascender + font.descender;
    CTParagraphStyleSetting paragraphSettings[1] = { kCTParagraphStyleSpecifierLineBreakMode, sizeof (CGFloat), &leading };
    
    CTParagraphStyleRef  paragraphStyle = CTParagraphStyleCreate(paragraphSettings, 1);
    CFRange textRange = CFRangeMake(0, self.length);
    
    CFMutableAttributedStringRef string = CFAttributedStringCreateMutable(kCFAllocatorDefault, self.length);
    
    CFAttributedStringReplaceString(string, CFRangeMake(0, 0), (CFStringRef) self);
    
    CFAttributedStringSetAttribute(string, textRange, kCTFontAttributeName, cfFont);
    CFAttributedStringSetAttribute(string, textRange, kCTParagraphStyleAttributeName, paragraphStyle);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(string);
    return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, CGSizeMake(width, DBL_MAX), nil);
}

@end
