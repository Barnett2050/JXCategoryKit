//
//  NSString+Encrypt.h
//  CustomCategory
//
//  Created by edz on 2019/10/27.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "NSData+JXEncrypt.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JXNSStringEncryptAESType) {
    JXNSStringEncryptAESType128 = 0,
    JXNSStringEncryptAESType192,
    JXNSStringEncryptAESType256
};

@interface NSString (Encrypt)

#pragma mark - 哈希加密
/// md2哈希处理
- (nullable NSString *)jx_md2String;

/// md4哈希处理
- (nullable NSString *)jx_md4String;

/// md5哈希处理 32位
- (nullable NSString *)jx_md5String;

/// MD5 哈希处理 16位（取32位的中间16位）
- (NSString *)jx_encryptWithMD5_16bit;

/// sha1 哈希处理
- (nullable NSString *)jx_sha1String;

/// sha224 哈希处理
- (nullable NSString *)jx_sha224String;

/// sha256 哈希处理
- (nullable NSString *)jx_sha256String;

/// sha384 哈希处理
- (nullable NSString *)jx_sha384String;

/// sha512 哈希处理
- (nullable NSString *)jx_sha512String;

/// crc32哈希算法
- (NSString *)jx_crc32String;

/// 基于散列的消息认证码 HMAC-MD5加密
/// @param key hmac密钥
- (nullable NSString *)jx_hmacMD5StringWithKey:(NSString *)key;

/// 基于散列的消息认证码 SHA1加密
/// @param key hmac密钥
- (nullable NSString *)jx_hmacSHA1StringWithKey:(NSString *)key;

/// 基于散列的消息认证码 SHA224加密
/// @param key hmac密钥
- (nullable NSString *)jx_hmacSHA224StringWithKey:(NSString *)key;

/// 基于散列的消息认证码 SHA256加密
/// @param key hmac密钥
- (nullable NSString *)jx_hmacSHA256StringWithKey:(NSString *)key;

/// 基于散列的消息认证码 SHA384加密
/// @param key hmac密钥
- (nullable NSString *)jx_hmacSHA384StringWithKey:(NSString *)key;

/// 基于散列的消息认证码 SHA512加密
/// @param key hmac密钥
- (nullable NSString *)jx_hmacSHA512StringWithKey:(NSString *)key;

#pragma mark - base64
/// base64编码
- (NSString *)jx_encodeWithBase64With:(NSDataBase64EncodingOptions)optinon;
/// base64解码
- (NSString *)jx_decodeWithBase64;
/// URL编码
- (NSString *)jx_URLEncode;
/// URL解码
- (NSString *)jx_URLDecode;

#pragma mark - 加密解密
/// 加密 DES数据块长度为64位，所以IV长度需要为8个字符（ECB模式不用IV），密钥长度也为8个字符，IV与密钥超过长度则截取，不足则在末尾填充'\0'补足 AES数据块长度为128位，所以IV长度需要为16个字符（ECB模式不用IV），密钥根据指定密钥位数分别为16、24、32个字符，IV与密钥超过长度则截取，不足则在末尾填充'\0'补足 3DES数据块长度为64位，所以IV长度需要为8个字符（ECB模式不用IV），密钥长度为16或24个字符（8个字符以内则结果与DES相同），IV与密钥超过长度则截取，不足则在末尾填充'\0'补足
/// @param type 加密类型
/// @param key 秘钥
/// @param iv 初始化向量
- (NSString *)jx_encryptWithType:(JXCryptType)type key:(NSString *)key iv:(nullable NSString *)iv base64Handle:(BOOL)base64Handle;

/// 解密
/// @param type 加密类型
/// @param key 秘钥
/// @param iv 初始化向量
- (NSString *)jx_decryptWithType:(JXCryptType)type key:(NSString *)key iv:(nullable NSString *)iv base64Handle:(BOOL)base64Handle;

@end

NS_ASSUME_NONNULL_END
