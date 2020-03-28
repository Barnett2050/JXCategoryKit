//
//  NSMutableString+JXSafe.m
//  CustomCategory
//
//  Created by Barnett on 2020/3/27.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSMutableString+JXSafe.h"
#import "NSObject+JXRuntime.h"
#import <objc/runtime.h>

#define NSCFString "__NSCFString"

@implementation NSMutableString (JXSafe)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(substringFromIndex:) swizzleSel:@selector(CFConstantString_substringFromIndex:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(substringToIndex:) swizzleSel:@selector(CFConstantString_substringToIndex:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(substringWithRange:) swizzleSel:@selector(CFConstantString_substringWithRange:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(getLineStart:end:contentsEnd:forRange:) swizzleSel:@selector(CFConstantString_getLineStart:end:contentsEnd:forRange:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(lineRangeForRange:) swizzleSel:@selector(CFConstantString_lineRangeForRange:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(getParagraphStart:end:contentsEnd:forRange:) swizzleSel:@selector(CFConstantString_getParagraphStart:end:contentsEnd:forRange:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(paragraphRangeForRange:) swizzleSel:@selector(CFConstantString_paragraphRangeForRange:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(enumerateSubstringsInRange:options:usingBlock:) swizzleSel:@selector(CFConstantString_enumerateSubstringsInRange:options:usingBlock:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) swizzleSel:@selector(CFConstantString_stringByReplacingOccurrencesOfString:withString:options:range:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(stringByReplacingCharactersInRange:withString:) swizzleSel:@selector(CFConstantString_stringByReplacingCharactersInRange:withString:)];
        // mutablestring
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceCharactersInRange:withString:) swizzleSel:@selector(CFConstantString_replaceCharactersInRange:withString:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(insertString:atIndex:) swizzleSel:@selector(CFConstantString_insertString:atIndex:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(deleteCharactersInRange:) swizzleSel:@selector(CFConstantString_deleteCharactersInRange:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(replaceOccurrencesOfString:withString:options:range:) swizzleSel:@selector(CFConstantString_replaceOccurrencesOfString:withString:options:range:)];
        [objc_getClass(NSCFString) jx_swizzleClassInstanceMethodWithOriginSel:@selector(applyTransform:reverse:range:updatedRange:) swizzleSel:@selector(CFConstantString_applyTransform:reverse:range:updatedRange:)];
    });
}

#pragma mark - NSCFString
- (NSString *)CFConstantString_substringFromIndex:(NSUInteger)from
{
    if (index >= 0 && from < self.length) {
       return [self CFConstantString_substringFromIndex:from];
    }
    return @"";
}
- (NSString *)CFConstantString_substringToIndex:(NSUInteger)to
{
    if (index >= 0 && to < self.length) {
       return [self CFConstantString_substringToIndex:to];
    }
    return @"";
}
- (NSString *)CFConstantString_substringWithRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        return [self CFConstantString_substringWithRange:[self getNewRangeWith:range]];
    }
    return @"";
}
// 返回指定开始索引到结束索引，指定段的字符串
- (void)CFConstantString_getLineStart:(nullable NSUInteger *)startPtr end:(nullable NSUInteger *)lineEndPtr contentsEnd:(nullable NSUInteger *)contentsEndPtr forRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        [self CFConstantString_getLineStart:startPtr end:lineEndPtr contentsEnd:contentsEndPtr forRange:[self getNewRangeWith:range]];
    }
}
// 返回字符串指定段的位置和长度
- (NSRange)CFConstantString_lineRangeForRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        return [self CFConstantString_lineRangeForRange:[self getNewRangeWith:range]];
    }
    return NSMakeRange(0, 0);
}
// 指定段分段取字符串
- (void)CFConstantString_getParagraphStart:(nullable NSUInteger *)startPtr end:(nullable NSUInteger *)parEndPtr contentsEnd:(nullable NSUInteger *)contentsEndPtr forRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        [self CFConstantString_getParagraphStart:startPtr end:parEndPtr contentsEnd:contentsEndPtr forRange:[self getNewRangeWith:range]];
    }
}
// 指定段分段的位置和长度
- (NSRange)CFConstantString_paragraphRangeForRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        return [self CFConstantString_paragraphRangeForRange:[self getNewRangeWith:range]];
    }
    return NSMakeRange(0, 0);
}
// 检查是否在指定范围内是否有匹配的字符串
- (void)CFConstantString_enumerateSubstringsInRange:(NSRange)range options:(NSStringEnumerationOptions)opts usingBlock:(void (^)(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop))block
{
    if ([self rangeIsAvailable:range]) {
        return [self CFConstantString_enumerateSubstringsInRange:[self getNewRangeWith:range] options:opts usingBlock:block];
    }
}
- (NSString *)CFConstantString_stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    if ([self rangeIsAvailable:searchRange]) {
        return [self CFConstantString_stringByReplacingOccurrencesOfString:target withString:replacement options:options range:[self getNewRangeWith:searchRange]];
    }
    return self;
}

/* 用指定的字符串替换范围内的字符，并返回新的字符串。*/
- (NSString *)CFConstantString_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement
{
    if ([self rangeIsAvailable:range]) {
        return [self CFConstantString_stringByReplacingCharactersInRange:[self getNewRangeWith:range] withString:replacement];
    }
    return self;
}

- (void)CFConstantString_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString
{
    if ([self rangeIsAvailable:range]) {
        return [self CFConstantString_replaceCharactersInRange:[self getNewRangeWith:range] withString:aString];
    }
}
- (void)CFConstantString_insertString:(NSString *)aString atIndex:(NSUInteger)loc
{
    if (loc >= 0 && loc < self.length + 1) {
        [self CFConstantString_insertString:aString atIndex:loc];
    }
}
- (void)CFConstantString_deleteCharactersInRange:(NSRange)range
{
    if ([self rangeIsAvailable:range]) {
        return [self CFConstantString_deleteCharactersInRange:[self getNewRangeWith:range]];
    }
}
- (NSUInteger)CFConstantString_replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    if ([self rangeIsAvailable:searchRange]) {
        return [self CFConstantString_replaceOccurrencesOfString:target withString:replacement options:options range:[self getNewRangeWith:searchRange]];
    }
    return NSNotFound;
}
- (BOOL)CFConstantString_applyTransform:(NSStringTransform)transform reverse:(BOOL)reverse range:(NSRange)range updatedRange:(nullable NSRangePointer)resultingRange
{
    if ([self rangeIsAvailable:range]) {
        return [self CFConstantString_applyTransform:transform reverse:reverse range:[self getNewRangeWith:range] updatedRange:resultingRange];
    }
    return false;
}
#pragma mark - private
- (BOOL)rangeIsAvailable:(NSRange)range
{
    BOOL flag = true;
    if (range.location < 0 || range.length <= 0 || range.location > self.length) {
        flag = false;
    }
    return flag;
}

- (NSRange)getNewRangeWith:(NSRange)range
{
    NSRange newRange;
    NSInteger length = range.length;
    if (length + range.location > self.length) {
        length = self.length - range.location;
    }
    newRange = NSMakeRange(range.location, length);
    return newRange;
}

@end
