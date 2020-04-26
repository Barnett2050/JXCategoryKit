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
#import "NSData+JXEncrypt.h"

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

#pragma mark - DES 加密
- (NSString *)jx_encryptWithDES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUsewBase64:(BOOL)isUse
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus;
    if (desIv.length == 0 || desIv == nil) {
        cryptStatus = CCCrypt(kCCEncrypt, // kCCEncrypt  加密/kCCDecrypt 解密
                            kCCAlgorithmDES, // 加密算法,默认使用的是  AES/DES
                            kCCOptionPKCS7Padding | kCCOptionECBMode, // 加密选项  ECB/CBC kCCOptionPKCS7Padding                      CBC 的加密方式  kCCOptionPKCS7Padding | kCCOptionECBMode   ECB 的加密方式
                            keyPtr, // 加密密钥
                            kCCBlockSizeDES, // 密钥长度 key必须是8位长度
                            NULL, // iv 初始化向量,ECB 不需要指定(秘钥偏移量)
                            [data bytes], // 加密的数据
                            dataLength, // 加密的数据的长度
                            buffer, // 密文的内存地址
                            bufferSize, // 密文缓冲区的大小
                            &numBytesEncrypted); // 加密结果大小
    }else
    {
        cryptStatus = CCCrypt(kCCEncrypt, // kCCEncrypt  加密/kCCDecrypt 解密
                            kCCAlgorithmDES, // 加密算法,默认使用的是  AES/DES
                            kCCOptionPKCS7Padding, // 加密选项  ECB/CBC kCCOptionPKCS7Padding                      CBC 的加密方式  kCCOptionPKCS7Padding | kCCOptionECBMode   ECB 的加密方式
                            keyPtr, // 加密密钥
                            kCCBlockSizeDES, // 密钥长度 key必须是8位长度
                            [desIv UTF8String], // iv 初始化向量,ECB 不需要指定(秘钥偏移量)
                            [data bytes], // 加密的数据
                            dataLength, // 加密的数据的长度
                            buffer, // 密文的内存地址
                            bufferSize, // 密文缓冲区的大小
                            &numBytesEncrypted); // 加密结果大小
    }
    if (cryptStatus == kCCSuccess) {
        
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        NSString *outputStr;
        // base64加密
        if (isUse) {
            NSData *base64Data = [data base64EncodedDataWithOptions:1];
            outputStr = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
            return outputStr;
        }else
        {
            outputStr = [NSString stringWithHexBytes:data];
            return outputStr;
        }
    }
    free(buffer);
    return nil;
}

- (NSString *)jx_decryptWithDES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUsewBase64:(BOOL)isUse
{
    NSData *data;
    if (isUse) {
        data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    }else
    {
        data = [NSString parseHexToByteArray:self];
    }
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus;
    if (desIv.length == 0 || desIv == nil) {
        cryptStatus = CCCrypt(kCCDecrypt,
                                kCCAlgorithmDES,
                                kCCOptionPKCS7Padding | kCCOptionECBMode,
                                keyPtr,
                                kCCBlockSizeDES,
                                NULL,
                                [data bytes],
                                dataLength,
                                buffer,
                                bufferSize,
                                &numBytesDecrypted);
    }else
    {
        cryptStatus = CCCrypt(kCCDecrypt,
                                kCCAlgorithmDES,
                                kCCOptionPKCS7Padding,
                                keyPtr,
                                kCCBlockSizeDES,
                                [desIv UTF8String],
                                [data bytes],
                                dataLength,
                                buffer,
                                bufferSize,
                                &numBytesDecrypted);
    }
    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        NSString *plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
        return plaintext;
    }
    free(buffer);
    return nil;
}

#pragma mark - 3DES 加密
- (NSString *)jx_encryptWith3DES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUsewBase64:(BOOL)isUse
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    // 字节的个数
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    //1字节     uint8_t
    //2字节     uint16_t
    //4字节     uint32_t
    //8字节     uint64_t
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t moveByTes = 0;
    //    size_t bufferPtrSize = ([plainText length] + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtrSize = (plainTextBufferSize * kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    //malloc 向系统申请分配指定size个字节的内存空间
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       [key UTF8String], //key   此处key的长度 和下面参数指定的长度要相同
                       kCCKeySize3DES, //key必须是24位长度
                       desIv.length > 0?[desIv UTF8String]:NULL, // 可选的初始量
                       vplainText, // 要加密/解密的数据
                       plainTextBufferSize, // 要加密/解密的数据的长度
                       bufferPtr, // 用于接收加密后/解密后的结果
                       bufferPtrSize, //加密后/解密后的数据的长度
                       &moveByTes);
    
    NSString *outputStr = nil;
    if (ccStatus == kCCSuccess) {
        
        NSData *data = [NSData dataWithBytes:bufferPtr length:(NSUInteger)moveByTes];
        // base64加密
        if (isUse) {
            NSData *base64Data = [data base64EncodedDataWithOptions:1];
            outputStr = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
            return outputStr;
        }else
        {
            outputStr = [NSString stringWithHexBytes:data];
            return outputStr;
        }
        
    }
    return outputStr;
}

- (NSString *)jx_decryptWith3DES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUsewBase64:(BOOL)isUse
{
    NSData *base64Decode;
    if (isUse) {
        base64Decode = [[NSData alloc] initWithBase64EncodedString:self options:0];
    }else
    {
        base64Decode = [NSString parseHexToByteArray:self];
    }
    
    size_t plainTextBufferSize = base64Decode.length;
    
    uint8_t * bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t moveByTes = 0;
    
    bufferPtrSize = (plainTextBufferSize * kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    
    memset(bufferPtr, 0*0, bufferPtrSize);
    
    CCCryptorStatus status = CCCrypt(kCCDecrypt,
                                     kCCAlgorithm3DES,
                                     kCCOptionPKCS7Padding,
                                     [key UTF8String],
                                     kCCKeySize3DES,
                                     desIv.length > 0?[desIv UTF8String]:NULL,
                                     [base64Decode bytes],
                                     [base64Decode length],
                                     bufferPtr,
                                     bufferPtrSize,
                                     &moveByTes);
    
    NSString *plaintext = nil;
    if(status == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:bufferPtr length:(NSUInteger)moveByTes];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
    }
    return plaintext;
}

#pragma mark - AES 加密

- (NSString *)jx_encryptWithAES128_Key:(NSString *)key desIv:(nullable NSString *)aesIv isUsewBase64:(BOOL)isUse
{
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          aesIv.length>0?[aesIv UTF8String]:NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
  
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        NSData *base64Data = [resultData base64EncodedDataWithOptions:0];
        NSString *plaintext = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
        return plaintext;
    }
    free(buffer);
    return nil;
}
- (NSString *)jx_decryptWithAES128_Key:(NSString *)key desIv:(nullable NSString *)aesIv isUsewBase64:(BOOL)isUse
{
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          aesIv.length>0?[aesIv UTF8String]:NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);

    if(cryptStatus == kCCSuccess) {
        NSData *plaindata = [NSData dataWithBytes:buffer length:numBytesCrypted];
        NSString *plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
        return plaintext;
    }
    free(buffer);
    return nil;
}

- (NSString *)jx_encryptWithAES256_Key:(NSString *)key desIv:(nullable NSString *)aesIv isUsewBase64:(BOOL)isUse
{
    NSData *dataSource = [self dataUsingEncoding:NSUTF8StringEncoding];

    char keyPtr[kCCKeySizeAES256 + 1];
    // 置字节字符串前n个字节为0且包括'\0'
    bzero(keyPtr, sizeof(keyPtr));
    // 将NSString类型秘钥转为char类型数组字符串
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [dataSource length];

    size_t bufferSize           = dataLength + kCCBlockSizeAES128;
    void* buffer                = malloc(bufferSize);

    size_t numBytesEncrypted    = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          aesIv.length>0?[aesIv UTF8String]:NULL,
                                          [dataSource bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *output = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        // base64加密
        NSData *base64Data = [output base64EncodedDataWithOptions:0];
        NSString *outputStr = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
        return outputStr;
    }
    
    free(buffer);
    return nil;
}
- (NSString *)jx_decryptWithAES256_Key:(NSString *)key desIv:(nullable NSString *)aesIv isUsewBase64:(BOOL)isUse
{
    NSData *base64Decode = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [base64Decode length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES256,
                                          aesIv.length>0?[aesIv UTF8String]:NULL,
                                          [base64Decode bytes],
                                          dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSString *output = [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted] encoding:NSUTF8StringEncoding];
        return output;
    }
    
    free(buffer);
    return nil;
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
+(NSData*) parseHexToByteArray:(NSString*) hexString
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
