//
//  NSString+JXFormat.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSString+JXFormat.h"

@implementation NSString (JXFormat)

- (NSString *)jx_changeNumberToMoneyFormat
{
    if (self == nil) {
        return @"";
    }
    double number = [self doubleValue];
    NSString *newStr = [[NSString alloc] init];
    NSNumberFormatter *formatter =[NSNumberFormatter new];
    formatter.positiveFormat=@"###,##0.00";
    newStr = [formatter stringFromNumber:[NSNumber numberWithDouble:number]];
    return newStr;
}

- (NSString *)jx_phoneNumberHideMiddle
{
    if (self.length != 11) {
        return self;
    }
    NSRange range = NSMakeRange(3, 4);
    NSString *newStr = [self stringByReplacingCharactersInRange:range withString:@"****"];
    return newStr;
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
    if (self.length != 18) {
        return self;
    }
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
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

- (NSString *)hexString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr = @"";
    for(int i = 0; i < [data length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i]&0xff];//16进制数
        if([newHexStr length]==1){
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        } else {
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
    if (self == nil || self.length == 0) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id json = [NSJSONSerialization JSONObjectWithData:jsonData
                                              options:NSJSONReadingMutableContainers
                                                error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return json;
}

#pragma mark - HEX 转换
- (NSString *)jx_hexStringFromStringWithLower:(BOOL)isOutputLower
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    static const char HexEncodeCharsLower[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    static const char HexEncodeChars[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
    char *resultData;
    // malloc result data
    resultData = malloc([data length] * 2 +1);
    // convert imgData(NSData) to char[]
    unsigned char *sourceData = ((unsigned char *)[data bytes]);
    uint length = (uint)[data length];
    
    if (isOutputLower)
    {
        for (uint index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeCharsLower[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeCharsLower[(sourceData[index] % 0x10)];
        }
    }
    else {
        for (uint index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeChars[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeChars[(sourceData[index] % 0x10)];
        }
    }
    resultData[[data length] * 2] = 0;
    
    // convert result(char[]) to NSString
    NSString *result = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    sourceData = nil;
    free(resultData);
    
    return result;
}

/**
 十六进制转换为普通字符串的
 */
- (NSString *)jx_stringFromHexString
{
    static const unsigned char HexDecodeChars[] =
    {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, //49
        2, 3, 4, 5, 6, 7, 8, 9, 0, 0, //59
        0, 0, 0, 0, 0, 10, 11, 12, 13, 14,
        15, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //79
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 10, 11, 12,   //99
        13, 14, 15
    };
    
    // convert data(NSString) to CString
    const char *source = [self cStringUsingEncoding:NSUTF8StringEncoding];
    // malloc buffer
    unsigned char *buffer;
    uint length =(uint)strlen(source) / 2;
    buffer = malloc(length);
    for (uint index = 0; index < length; index++) {
        buffer[index] = (HexDecodeChars[source[index * 2]] << 4) + (HexDecodeChars[source[index * 2 + 1]]);
    }
    // init result NSData
    NSData *result = [NSData dataWithBytes:buffer length:length];
    free(buffer);
    source = nil;
    
    return  [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];;
}


@end
