//
//  NSData+JXEncrypt.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/13.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSData+JXEncrypt.h"
#include <CommonCrypto/CommonCrypto.h>
#include <zlib.h>

@implementation NSData (JXEncrypt)

- (NSString *)jx_md2String
{
    unsigned char result[CC_MD2_DIGEST_LENGTH];
    CC_MD2(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSData *)jx_md2Data
{
    unsigned char result[CC_MD2_DIGEST_LENGTH];
    CC_MD2(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD2_DIGEST_LENGTH];
}

- (NSString *)jx_md4String
{
    unsigned char result[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSData *)jx_md4Data
{
    unsigned char result[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD4_DIGEST_LENGTH];
}

- (NSString *)jx_md5String
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSData *)jx_md5Data
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)jx_sha1String
{
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString
                             stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)jx_sha1Data
{
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)jx_sha224String
{
    unsigned char result[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString
                             stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)jx_sha224Data
{
    unsigned char result[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA224_DIGEST_LENGTH];
}

- (NSString *)jx_sha256String
{
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString
                             stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)jx_sha256Data
{
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)jx_sha384String
{
    unsigned char result[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString
                             stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)jx_sha384Data
{
    unsigned char result[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA384_DIGEST_LENGTH];
}

- (NSString *)jx_sha512String
{
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString
                             stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)jx_sha512Data
{
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)jx_hmacMD5StringWithKey:(NSString *)key
{
    return [self jx_hmacStringUsingAlg:kCCHmacAlgMD5 withKey:key];
}

- (NSData *)jx_hmacMD5DataWithKey:(NSData *)key
{
    return [self jx_hmacDataUsingAlg:kCCHmacAlgMD5 withKey:key];
}

- (NSString *)jx_hmacSHA1StringWithKey:(NSString *)key
{
    return [self jx_hmacStringUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

- (NSData *)jx_hmacSHA1DataWithKey:(NSData *)key
{
    return [self jx_hmacDataUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

- (NSString *)jx_hmacSHA224StringWithKey:(NSString *)key
{
    return [self jx_hmacStringUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

- (NSData *)jx_hmacSHA224DataWithKey:(NSData *)key
{
    return [self jx_hmacDataUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

- (NSString *)jx_hmacSHA256StringWithKey:(NSString *)key
{
    return [self jx_hmacStringUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

- (NSData *)jx_hmacSHA256DataWithKey:(NSData *)key
{
    return [self jx_hmacDataUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

- (NSString *)jx_hmacSHA384StringWithKey:(NSString *)key
{
    return [self jx_hmacStringUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

- (NSData *)jx_hmacSHA384DataWithKey:(NSData *)key
{
    return [self jx_hmacDataUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

- (NSString *)jx_hmacSHA512StringWithKey:(NSString *)key
{
    return [self jx_hmacStringUsingAlg:kCCHmacAlgSHA512 withKey:key];
}

- (NSData *)jx_hmacSHA512DataWithKey:(NSData *)key
{
    return [self jx_hmacDataUsingAlg:kCCHmacAlgSHA512 withKey:key];
}

- (NSString *)jx_crc32String
{
    uLong result = crc32(0, self.bytes, (uInt)self.length);
    return [NSString stringWithFormat:@"%08x", (uint32_t)result];
}

- (uint32_t)jx_crc32
{
    uLong result = crc32(0, self.bytes, (uInt)self.length);
    return (uint32_t)result;
}

- (NSData *)jx_encryptWithType:(JXDataCryptType)type key:(NSString *)key iv:(nullable NSString *)iv
{
    if (self.length == 0 || key.length == 0) { return nil; }
    return [self jx_cryptWith:kCCEncrypt type:type key:key iv:iv];
}

- (NSData *)jx_decryptWithType:(JXDataCryptType)type key:(NSString *)key iv:(nullable NSString *)iv
{
    if (self.length == 0 || key.length == 0) { return nil; }
    return [self jx_cryptWith:kCCDecrypt type:type key:key iv:iv];
}

- (NSString *)jx_utf8String
{
    if (self.length > 0) {
        return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    }
    return @"";
}

- (NSString *)jx_hexString
{
    NSUInteger length = self.length;
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    const unsigned char *byte = self.bytes;
    for (int i = 0; i < length; i++, byte++) {
        [result appendFormat:@"%02X", *byte];
    }
    return result;
}

+ (NSData *)jx_dataWithHexString:(NSString *)hexStr
{
    hexStr = [hexStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    hexStr = [hexStr lowercaseString];
    NSUInteger len = hexStr.length;
    if (!len) return nil;
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [hexStr getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableData *result = [NSMutableData data];
    unsigned char bytes;
    char str[3] = { '\0', '\0', '\0' };
    int i;
    for (i = 0; i < len / 2; i++) {
        str[0] = buf[i * 2];
        str[1] = buf[i * 2 + 1];
        bytes = strtol(str, NULL, 16);
        [result appendBytes:&bytes length:1];
    }
    free(buf);
    return result;
}

- (NSString *)jx_base64EncodedString
{
    NSString *base64Encoded = [self base64EncodedStringWithOptions:0];
    return base64Encoded;
}

+ (NSData *)jx_dataWithBase64EncodedString:(NSString *)base64EncodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64EncodedString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

- (id)jx_jsonValueDecoded
{
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error) {
        NSLog(@"jsonValueDecoded error:%@", error);
    }
    return value;
}

#pragma mark - private
- (NSString *)jx_hmacStringUsingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key
{
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    unsigned char result[size];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(alg, cKey, strlen(cKey), self.bytes, self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:size * 2];
    for (int i = 0; i < size; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)jx_hmacDataUsingAlg:(CCHmacAlgorithm)alg withKey:(NSData *)key
{
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    unsigned char result[size];
    CCHmac(alg, [key bytes], key.length, self.bytes, self.length, result);
    return [NSData dataWithBytes:result length:size];
}

- (NSData *)jx_cryptWith:(CCOperation)operation type:(JXDataCryptType)type key:(NSString *)key iv:(nullable NSString *)iv
{
    NSData *data = self;
    size_t cryptLength = [self cryptLengthWith:type];
    size_t bufferSize = data.length + cryptLength;
    void *buffer = malloc(bufferSize);
    memset((void *)buffer, 0x0, bufferSize);
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation, // kCCEncrypt  加密/kCCDecrypt 解密
                                          [self algorithmWith:type],
                                          /* 加密选项 ECB/CBC
                                           kCCOptionPKCS7Padding                        CBC 的加密方式
                                           kCCOptionPKCS7Padding | kCCOptionECBMode     ECB 的加密方式
                                           */
                                          [self optionsWithIv:iv],
                                          [key UTF8String], // 加密密钥
                                          [self keyLengthWith:type], // 密钥长度
                                          iv.length > 0 ? [iv UTF8String] : NULL,// iv 初始化向量,ECB 不需要指定(秘钥偏移量)
                                          [data bytes], // 加密的数据
                                          [data length], // 加密的数据的长度
                                          buffer, // 密文的内存地址
                                          bufferSize, // 密文缓冲区的大小
                                          &numBytesCrypted); // 加密结果大小
    NSData *resultData = nil;
    if (cryptStatus == kCCSuccess) {
        resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
    }
    return resultData;
}

- (CCAlgorithm)algorithmWith:(JXDataCryptType)type
{
    CCAlgorithm algorithm;
    switch (type) {
        case JXDataCryptTypeDES:
            algorithm = kCCAlgorithmDES;
            break;
        case JXDataCryptType3DES:
            algorithm = kCCAlgorithm3DES;
            break;
        case JXDataCryptTypeAES128:
        case JXDataCryptTypeAES192:
        case JXDataCryptTypeAES256:
            algorithm = kCCAlgorithmAES;
            break;
        default:
            break;
    }
    return algorithm;
}

- (size_t)keyLengthWith:(JXDataCryptType)type
{
    size_t keyLength;
    switch (type) {
        case JXDataCryptTypeDES:
            keyLength = kCCBlockSizeDES;
            break;
        case JXDataCryptType3DES:
            keyLength = kCCKeySize3DES;
            break;
        case JXDataCryptTypeAES128:
            keyLength = kCCKeySizeAES128;
            break;
        case JXDataCryptTypeAES192:
            keyLength = kCCKeySizeAES192;
            break;
        case JXDataCryptTypeAES256:
            keyLength = kCCKeySizeAES256;
            break;
        default:
            break;
    }
    return keyLength;
}
- (size_t)cryptLengthWith:(JXDataCryptType)type
{
    size_t cryptLength;
    switch (type) {
        case JXDataCryptTypeDES:
            cryptLength = kCCBlockSizeDES;
            break;
        case JXDataCryptType3DES:
            cryptLength = kCCBlockSize3DES;
            break;
        case JXDataCryptTypeAES128:
            cryptLength = kCCKeySizeAES128;
            break;
        case JXDataCryptTypeAES192:
            cryptLength = kCCKeySizeAES192;
            break;
        case JXDataCryptTypeAES256:
            cryptLength = kCCKeySizeAES256;
            break;
        default:
            break;
    }
    return cryptLength;
}
- (CCOptions)optionsWithIv:(NSString *)iv
{
    return iv.length > 0 ? kCCOptionPKCS7Padding : (kCCOptionPKCS7Padding | kCCOptionECBMode);
}

@end
