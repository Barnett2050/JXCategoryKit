//
//  NSString+JXSafe.m
//  CustomCategory
//
//  Created by Barnett on 2020/3/26.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSString+JXSafe.h"
#import "NSObject+JXRuntime.h"
#import <objc/runtime.h>

static const char *NSCFConstantString = "__NSCFConstantString";

@implementation NSString (JXSafe)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass(NSCFConstantString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(substringFromIndex:) swizzleSel:@selector(CFConstantString_substringFromIndex:)];
        [objc_getClass(NSCFConstantString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(substringToIndex:) swizzleSel:@selector(CFConstantString_substringToIndex:)];
        [objc_getClass(NSCFConstantString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(substringWithRange:) swizzleSel:@selector(CFConstantString_substringWithRange:)];
        [objc_getClass(NSCFConstantString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(lineRangeForRange:) swizzleSel:@selector(CFConstantString_lineRangeForRange:)];
        [objc_getClass(NSCFConstantString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(enumerateSubstringsInRange:options:usingBlock:) swizzleSel:@selector(CFConstantString_enumerateSubstringsInRange:options:usingBlock:)];
        [objc_getClass(NSCFConstantString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) swizzleSel:@selector(CFConstantString_stringByReplacingOccurrencesOfString:withString:options:range:)];
        [objc_getClass(NSCFConstantString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(stringByReplacingCharactersInRange:withString:) swizzleSel:@selector(CFConstantString_stringByReplacingCharactersInRange:withString:)];
    });
}

#pragma mark - NSCFConstantString
- (NSString *)CFConstantString_substringFromIndex:(NSUInteger)from
{
    NSInteger newFrom = from;
    newFrom = newFrom < 0 ? 0 : newFrom;
    if (newFrom >= 0 && newFrom < self.length) {
       return [self CFConstantString_substringFromIndex:newFrom];
    }
    return @"";
}
- (NSString *)CFConstantString_substringToIndex:(NSUInteger)to
{
    NSInteger newTo = to;
    newTo = newTo < 0 ? 0 : newTo;
    if (newTo >= 0 && newTo < self.length) {
       return [self CFConstantString_substringToIndex:newTo];
    } else if (newTo >= self.length) {
        newTo = self.length;
        return [self CFConstantString_substringToIndex:newTo];
    }
    return @"";
}
- (NSString *)CFConstantString_substringWithRange:(NSRange)range
{
    return [self CFConstantString_substringWithRange:[self getNewRangeWith:range]];
}
// 返回字符串指定段的位置和长度
- (NSRange)CFConstantString_lineRangeForRange:(NSRange)range
{
    return [self CFConstantString_lineRangeForRange:[self getNewRangeWith:range]];
}
// 指定段分段的位置和长度
- (NSRange)CFConstantString_paragraphRangeForRange:(NSRange)range
{
    return [self CFConstantString_paragraphRangeForRange:[self getNewRangeWith:range]];
}
// 检查是否在指定范围内是否有匹配的字符串
- (void)CFConstantString_enumerateSubstringsInRange:(NSRange)range options:(NSStringEnumerationOptions)opts usingBlock:(void (^)(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop))block
{
    return [self CFConstantString_enumerateSubstringsInRange:[self getNewRangeWith:range] options:opts usingBlock:block];
}
- (NSString *)CFConstantString_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    return [self CFConstantString_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:[self getNewRangeWith:searchRange]];
}

/* 用指定的字符串替换范围内的字符，并返回新的字符串。*/
- (NSString *)CFConstantString_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
{
    return [self CFConstantString_stringByReplacingCharactersInRange:[self getNewRangeWith:range] withString:replacement];
}
#pragma mark - private
- (NSRange)getNewRangeWith:(NSRange)range
{
    NSInteger location = range.location;
    location = location > 0 ? location : 0;
    NSInteger length = range.length;
    length = length > 0 ? length : 0;
    
    if (location > self.length) {
        return NSMakeRange(self.length, 0);
    } else {
        if (length + location > self.length) {
            length = self.length - location;
        }
        return NSMakeRange(location, length);
    }
}
@end
