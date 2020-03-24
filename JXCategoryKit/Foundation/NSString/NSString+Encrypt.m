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

#pragma mark - MD5
- (NSString *)jx_encryptWithMD5_32bit
{
    //1.获取C字符串（MD5加密基于C语言实现，Foundation框架字符串需要转化）
    const char *passData = [self UTF8String];//__strong const char *UTF8String,C语言无法持有字符串，必须用__strong修饰来拷贝内容
    
    //2.创建字符串数组接收MD5值
    //开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    /**
     *  3.计算MD5值(结果存储在result数组中)
     *
     *  @param data#> 加密的数据 description#>
     *  @param len#>  strlen计算加密数据字符的长度,strlen只能用char*做参数，且必须是以''\0''结尾的 description#>
     *  @param md#>   保存的地方 description#>
     *
     */
    //把passData字符串转换成了32位的16进制数列（这个过程不可逆转)存储到了result这个空间中
    CC_MD5(passData, (CC_LONG)strlen(passData), result);
    
    //4.获取摘要值
    NSMutableString *bar = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        //X 表示以十六进制形式输出,02 表示不足两位，前面补0输出；出过两位，不影响
        [bar appendFormat:@"%02X",result[i]];
    }
    return bar;
}
- (NSString *)jx_encryptWithMD5_16bit
{
    NSString *md5Str = [self jx_encryptWithMD5_32bit];
    NSString *md5_16Str;
    if (md5Str.length > 24) {
        md5_16Str = [md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return md5_16Str;
}

- (NSString *)jx_encryptUseHMACMD5WithHmacKey:(NSString *)key
{
    const char *passData = [self UTF8String];
    const char *keyData = [key UTF8String];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), passData, strlen(passData), result);
    
    NSMutableString *bar = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        
        [bar appendFormat:@"%02X",result[i]];
    }
    
    return bar;
}

#pragma mark - SHA
- (NSString *)jx_encryptWithSHA1
{
    const char * cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData * data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes,(CC_LONG)data.length, digest);
    
    NSMutableString * string = [[NSMutableString alloc] initWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [string appendFormat:@"%02x", digest[i]];
    }
    return string;
}

- (NSString *)jx_encryptWithSHA1_base64
{
    const char * cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData * data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes,(CC_LONG)data.length, digest);
    
    NSData * base64 = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    base64 = [base64 base64EncodedDataWithOptions:0];
    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    
    return output;
}

- (NSString *)jx_encryptWithSHA256
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

- (NSString *)jx_encryptWithSHA384
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

- (NSString *)jx_encryptWithSHA512
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
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

#pragma mark - DES 加密
- (NSString *)jx_encryptWithDES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUsewBase64:(BOOL)isUse;
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
