//
//  NSString+JXFormat.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSString+JXFormat.h"

@implementation NSString (JXFormat)

/**
 编码
 */
- (NSString *)jx_encode
{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedStr = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedStr;
}

/**
 解码
 */
- (NSString *)jx_decode
{
    NSString *decodedStr = [self stringByRemovingPercentEncoding];
    return decodedStr;
}

/**
 数字转为金额 例：1000000.00 -> 1,000,000.00
 */
- (NSString *)jx_changeNumberToMoneyFormat
{
    if (self == nil) {
        return @"";
    }
    
    double number = [self doubleValue];
    NSString* newStr = [[NSString alloc] init];
    NSNumberFormatter *formatter =[NSNumberFormatter new];
    //    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.positiveFormat=@"###,##0.00";
    
    newStr = [formatter stringFromNumber:[NSNumber numberWithDouble:number]];
    return newStr;
}

/**
 手机号码替换****
 */
- (NSString *)jx_phoneNumberHideMiddle
{
    NSString *phoneRegex = @"1[34578]{1}\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    if ([phoneTest evaluateWithObject:self]) {
        NSRange range = NSMakeRange(3, 4);
        NSString *newStr = [self stringByReplacingCharactersInRange:range withString:@"****"];
        return newStr;
    }
    return self;
}

- (NSString *)jx_removeFirstAndLastLineBreak
{
    NSString *newStr = self;
    while ([newStr hasPrefix:@"\n"]) {
        newStr = [newStr substringFromIndex:2];
    }
    while ([newStr hasSuffix:@"\n"]) {
        newStr = [newStr substringToIndex:newStr.length-1];
    }
    return newStr;
}

- (NSString *)jx_idCardFormat
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return self;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if ([identityCardPredicate evaluateWithObject:self]) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:[self substringToIndex:6]];
        [array addObject:[self substringWithRange:NSMakeRange(6, 4)]];
        [array addObject:[self substringWithRange:NSMakeRange(10, 4)]];
        [array addObject:[self substringWithRange:NSMakeRange(14, 4)]];
        return [NSString stringWithFormat:@"%@ %@ %@ %@",array[0],array[1],array[2],array[3]];
    }
    return self;
}
- (NSString *)jx_bankCardFormat
{
    NSString *newString = @"";
    NSString *originalCardNumber = self;
    while (originalCardNumber.length > 0) {
        NSString *subString = [originalCardNumber substringToIndex:MIN(originalCardNumber.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        originalCardNumber = [originalCardNumber substringFromIndex:MIN(originalCardNumber.length, 4)];
    }
    
    return newString;
}

- (NSString*)hexString
{
    NSData *myD = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    NSString *hexStr=@"";
    for(int i = 0; i < [myD length]; i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i]&0xff];//16进制数
        
        if([newHexStr length]==1)
        {
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else
        {
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    return hexStr;
}

- (NSString *)jx_replaceUnicode
{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}
- (id)jx_jsonStringToJson
{
    if (self == nil) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id json = [NSJSONSerialization JSONObjectWithData:jsonData
                                              options:NSJSONReadingMutableContainers
                                                error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return json;
}

@end
