//
//  NSString+Encrypt.m
//  CustomCategory
//
//  Created by edz on 2019/10/27.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSString+Encrypt.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Encrypt)

- (NSString *)jx_md2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] jx_md2String];
}

- (NSString *)jx_md4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] jx_md4String];
}

- (NSString *)jx_md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] jx_md5String];
}

- (NSString *)jx_encryptWithMD5_16bit
{
    NSString *md5Str = [self jx_md5String];
    NSString *md5_16Str;
    if (md5Str.length > 24) {
        md5_16Str = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return md5_16Str;
}

- (NSString *)jx_sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] jx_sha1String];
}

- (NSString *)jx_sha224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] jx_sha224String];
}

- (NSString *)jx_sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] jx_sha256String];
}

- (NSString *)jx_sha384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] jx_sha384String];
}

- (NSString *)jx_sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] jx_sha512String];
}

- (NSString *)jx_crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] jx_crc32String];
}

- (NSString *)jx_hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            jx_hmacMD5StringWithKey:key];
}

- (NSString *)jx_hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            jx_hmacSHA1StringWithKey:key];
}

- (NSString *)jx_hmacSHA224StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            jx_hmacSHA224StringWithKey:key];
}

- (NSString *)jx_hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            jx_hmacSHA256StringWithKey:key];
}

- (NSString *)jx_hmacSHA384StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            jx_hmacSHA384StringWithKey:key];
}

- (NSString *)jx_hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding]
            jx_hmacSHA512StringWithKey:key];
}

#pragma mark - base64
- (NSString *)jx_encodeWithBase64With:(NSDataBase64EncodingOptions)optinon
{
    NSData *nsdata = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Encoded = [nsdata base64EncodedStringWithOptions:optinon];
    return base64Encoded;
}

- (NSString *)jx_decodeWithBase64
{
    NSData *nsdataFromBase64String = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *base64Decoded = [[NSString alloc] initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    return base64Decoded;
}

- (NSString *)jx_URLEncode
{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedStr = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedStr;
}

- (NSString *)jx_URLDecode
{
    NSString *decodedStr = [self stringByRemovingPercentEncoding];
    return decodedStr;
}

- (NSString *)jx_encryptWithType:(JXCryptType)type key:(NSString *)key iv:(nullable NSString *)iv base64Handle:(BOOL)base64Handle
{
    if (self.length == 0 || key.length == 0) { return nil; }
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *resultData = [data jx_encryptWithType:type key:key iv:iv];
    if (resultData == nil || resultData.length == 0) { return nil; }
    NSString *outputStr = nil;
    // base64加密
    if (base64Handle) {
        NSData *base64Data = [resultData base64EncodedDataWithOptions:1];
        outputStr = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    } else {
        outputStr = [NSString stringWithHexBytes:resultData];
    }
    return outputStr;
}

- (NSString *)jx_decryptWithType:(JXCryptType)type key:(NSString *)key iv:(nullable NSString *)iv base64Handle:(BOOL)base64Handle
{
    if (self.length == 0 || key.length == 0) { return nil; }
    NSData *data;
    if (base64Handle) {
        data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    } else {
        data = [NSString parseHexToByteArray:self];
    }
    NSData *resultData = [data jx_decryptWithType:type key:key iv:iv];
    if (resultData == nil || resultData.length == 0) { return nil; }
    
    NSString *resultString = [[NSString alloc]initWithData:resultData encoding:NSUTF8StringEncoding];
    return resultString;
}

#pragma mark - private
//nsdata转成16进制字符串
+ (NSString*)stringWithHexBytes:(NSData *)sender {
    static const char hexdigits[] = "0123456789ABCDEF";
    const size_t numBytes = [sender length];
    const unsigned char* bytes = [sender bytes];
    char *strbuf = (char *)malloc(numBytes * 2 + 1);
    char *hex = strbuf;
    NSString *hexBytes = nil;
    
    for (int i = 0; i<numBytes; ++i) {
        const unsigned char c = *bytes++;
        *hex++ = hexdigits[(c >> 4) & 0xF];
        *hex++ = hexdigits[(c ) & 0xF];
    }
    
    *hex = 0;
    hexBytes = [NSString stringWithUTF8String:strbuf];
    
    free(strbuf);
    return hexBytes;
}

/*
 将16进制数据转化成NSData 数组
 */
+(NSData *)parseHexToByteArray:(NSString *)hexString
{
    int j=0;
    Byte bytes[hexString.length];
    for(int i=0;i<[hexString length];i++)
    {
        int int_ch;  /// 两位16进制数转化后的10进制数
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char1 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:hexString.length/2];
    return newData;
}
@end
