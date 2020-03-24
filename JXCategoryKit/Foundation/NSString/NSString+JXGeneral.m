//
//  NSString+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSString+JXGeneral.h"

@implementation NSString (JXGeneral)

#pragma mark - public
- (NSString *)jx_pinyinString
{
    NSMutableString * name = [[NSMutableString alloc] initWithString:self];
    
    CFRange range = CFRangeMake(0, self.length);
    
    // 汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) name, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) name, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    
    return name;
}

/**
 汉字转为拼音后，返回首字母大写
 */
- (NSString *)jx_firstCharacterString
{
    
    NSMutableString * first = [[NSMutableString alloc] initWithString:[self substringWithRange:NSMakeRange(0, 1)]];
    
    CFRange range = CFRangeMake(0, 1);
    
    // 汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    
    NSString * result;
    result = [first substringWithRange:NSMakeRange(0, 1)];
    
    return result.uppercaseString;
}


/**
 获取字符串字节长度
 */
- (NSInteger)getStringLenthOfBytes
{
    NSInteger length = 0;
    for (int i = 0; i<[self length]; i++) {
        //截取字符串中的每一个字符
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self jx_validateChineseChar:s]) {
            length +=2;
        }else{
            length +=1;
        }
    }
    return length;
}
/**
 根据字节截取字符串
 */
- (NSString *)jx_subBytesOfstringToIndex:(NSInteger)index
{
    NSInteger length = 0;
    
    NSInteger chineseNum = 0;
    NSInteger zifuNum = 0;
    
    for (int i = 0; i<[self length]; i++) {
        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        if ([self jx_validateChineseChar:s])
        {
            if (length + 2 > index)
            {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            
            length +=2;
            
            chineseNum +=1;
        }
        else
        {
            if (length +1 >index)
            {
                return [self substringToIndex:chineseNum + zifuNum];
            }
            length+=1;
            
            zifuNum +=1;
        }
    }
    return [self substringToIndex:index];
}


- (NSArray *)jx_getImageurlFromHtmlString
{
    NSMutableArray * imageurlArray = [NSMutableArray arrayWithCapacity:1];
    
    //标签匹配
    NSString *parten = @"<\\s*img\\s+[^>]*?src\\s*=\\s*[\'\"](.*?)[\'\"]\\s*(alt=[\'\"](.*?)[\'\"])?[^>]*?\\/?\\s*>";
    NSError* error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
    NSArray* match = [reg matchesInString:self options:0 range:NSMakeRange(0, [self length] - 1)];
    
    for (NSTextCheckingResult * result in match) {
        
        //获取数组中的标签
        NSRange range = [result range];
        NSString * subString = [self substringWithRange:range];
        
        //从图片中的标签中提取ImageURL
        NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"(http|https)://(.*?)\"" options:0 error:NULL];
        NSArray* match = [subReg matchesInString:subString options:0 range:NSMakeRange(0, [subString length] - 1)];
        if (match.count == 0) {
            continue;
        }
        NSTextCheckingResult * subRes = match[0];
        NSRange subRange = [subRes range];
        subRange.length = subRange.length -1;
        NSString * imagekUrl = [subString substringWithRange:subRange];
        //将提取出的图片URL添加到图片数组中
        [imageurlArray addObject:imagekUrl];
    }
    return imageurlArray;
}
/**
 修改html标签style
 */
+ (NSString *)modifyHtmlImgStyleWith:(NSString *)html
{
    NSString *htmlStr = html;
    NSString *parten = @"<img[^>]*>";
    NSError* error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
    NSArray* match = [reg matchesInString:htmlStr options:0 range:NSMakeRange(0, [htmlStr length] - 1)];
    for (NSTextCheckingResult * result in match) {
        NSRange range = [result range];
        NSString *subString = [htmlStr substringWithRange:range];
        if ([subString containsString:@"height"]) {
            NSMutableString *mutableStr = [NSMutableString stringWithString:subString];
            NSRange range = [subString rangeOfString:@"img"];
            [mutableStr insertString:@" style=\"width: 100%;height: 100%\"" atIndex:range.location + range.length];
            htmlStr = [htmlStr stringByReplacingOccurrencesOfString:subString withString:mutableStr];
        }
    }
    return html;
}

#pragma mark - private method
//检测中文或者中文符号
- (BOOL)jx_validateChineseChar:(NSString *)string
{
    NSString *nameRegEx = @"[\\u0391-\\uFFE5]";
    if (![string jx_isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

//检测中文
- (BOOL)jx_validateChinese:(NSString*)string
{
    NSString *nameRegEx = @"[\u4e00-\u9fa5]";
    if (![string jx_isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

- (BOOL)jx_isMatchesRegularExp:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

@end
