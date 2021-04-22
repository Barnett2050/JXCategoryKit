//
//  NSData+JXEncrypt.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/13.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
 
typedef NS_ENUM(NSUInteger, JXDataCryptType) {
    JXDataCryptTypeDES = 0,
    JXDataCryptType3DES,
    JXDataCryptTypeAES128,
    JXDataCryptTypeAES192,
    JXDataCryptTypeAES256
};

@interface NSData (JXEncrypt)

#pragma mark - Hash

/// 返回md2哈希的小写NSString。
- (NSString *)jx_md2String;
/// 返回md2哈希值的NSData。
- (NSData *)jx_md2Data;

/// 返回md4哈希的小写NSString。
- (NSString *)jx_md4String;
/// 返回md4哈希值的NSData。
- (NSData *)jx_md4Data;

/// 返回md5哈希的小写NSString。
- (NSString *)jx_md5String;
/// 返回md5哈希值的NSData。
- (NSData *)jx_md5Data;

/// 返回sha1哈希的小写NSString。
- (NSString *)jx_sha1String;
/// 返回sha1哈希值的NSData。
- (NSData *)jx_sha1Data;

/// 返回sha224哈希的小写NSString。
- (NSString *)jx_sha224String;
/// 返回sha224哈希值的NSData。
- (NSData *)jx_sha224Data;

/// 返回sha256哈希的小写NSString。
- (NSString *)jx_sha256String;
/// 返回sha256哈希值的NSData。
- (NSData *)jx_sha256Data;

/// 返回sha384哈希的小写NSString。
- (NSString *)jx_sha384String;
/// 返回sha384哈希值的NSData。
- (NSData *)jx_sha384Data;

/// 返回sha512哈希的小写NSString。
- (NSString *)jx_sha512String;
/// 返回sha512哈希值的NSData。
- (NSData *)jx_sha512Data;

/// 基于散列的消息认证码 HMAC-MD5加密
- (NSString *)jx_hmacMD5StringWithKey:(NSString *)key;
/// 基于散列的消息认证码 HMAC-MD5加密
- (NSData *)jx_hmacMD5DataWithKey:(NSData *)key;

/// 基于散列的消息认证码 HMAC-SHA1加密
- (NSString *)jx_hmacSHA1StringWithKey:(NSString *)key;
/// 基于散列的消息认证码 HMAC-SHA1加密
- (NSData *)jx_hmacSHA1DataWithKey:(NSData *)key;

/// 基于散列的消息认证码 HMAC-SHA224加密
- (NSString *)jx_hmacSHA224StringWithKey:(NSString *)key;
/// 基于散列的消息认证码 HMAC-SHA224加密
- (NSData *)jx_hmacSHA224DataWithKey:(NSData *)key;

/// 基于散列的消息认证码 HMAC-SHA256加密
- (NSString *)jx_hmacSHA256StringWithKey:(NSString *)key;
/// 基于散列的消息认证码 HMAC-SHA256加密
- (NSData *)jx_hmacSHA256DataWithKey:(NSData *)key;

/// 基于散列的消息认证码 HMAC-SHA384加密
- (NSString *)jx_hmacSHA384StringWithKey:(NSString *)key;
/// 基于散列的消息认证码 HMAC-SHA384加密
- (NSData *)jx_hmacSHA384DataWithKey:(NSData *)key;

/// 基于散列的消息认证码 HMAC-SHA512加密
- (NSString *)jx_hmacSHA512StringWithKey:(NSString *)key;
/// 基于散列的消息认证码 HMAC-SHA512加密
- (NSData *)jx_hmacSHA512DataWithKey:(NSData *)key;

/// crc32哈希算法
- (NSString *)jx_crc32String;
/// crc32哈希值
- (uint32_t)jx_crc32;

#pragma mark - 加密解密
/// 加密 DES数据块长度为64位，所以IV长度需要为8个字符（ECB模式不用IV），密钥长度也为8个字符，IV与密钥超过长度则截取，不足则在末尾填充'\0'补足 AES数据块长度为128位，所以IV长度需要为16个字符（ECB模式不用IV），密钥根据指定密钥位数分别为16、24、32个字符，IV与密钥超过长度则截取，不足则在末尾填充'\0'补足 3DES数据块长度为64位，所以IV长度需要为8个字符（ECB模式不用IV），密钥长度为16或24个字符（8个字符以内则结果与DES相同），IV与密钥超过长度则截取，不足则在末尾填充'\0'补足
/// @param type 加密类型
/// @param key 秘钥
/// @param iv 初始化向量
- (NSData *)jx_encryptWithType:(JXDataCryptType)type key:(NSString *)key iv:(nullable NSString *)iv;

/// 解密
/// @param type 加密类型
/// @param key 秘钥
/// @param iv 初始化向量
- (NSData *)jx_decryptWithType:(JXDataCryptType)type key:(NSString *)key iv:(nullable NSString *)iv;

#pragma mark - Encode and decode

/// 返回以UTF8解码的字符串。
- (nullable NSString *)jx_utf8String;

/// 返回十六进制的大写NSString。
- (nullable NSString *)jx_hexString;

/// 从十六进制字符串返回NSData。
/// @param hexString 不区分大小写的十六进制字符串。
+ (nullable NSData *)jx_dataWithHexString:(NSString *)hexString;

/// 返回base64编码的NSString。
- (nullable NSString *)jx_base64EncodedString;

/// 从base64编码的字符串返回NSData。
+ (nullable NSData *)jx_dataWithBase64EncodedString:(NSString *)base64EncodedString;

/// 返回NSDictionary或NSArray用于已解码的self。如果发生错误，则返回nil。
- (nullable id)jx_jsonValueDecoded;

@end

NS_ASSUME_NONNULL_END
