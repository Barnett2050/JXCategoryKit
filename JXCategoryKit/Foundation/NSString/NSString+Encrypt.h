//
//  NSString+Encrypt.h
//  CustomCategory
//
//  Created by edz on 2019/10/27.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Encrypt)

#pragma mark - 哈希加密
/// md2哈希处理
- (nullable NSString *)jx_md2String;

/// md4哈希处理
- (nullable NSString *)jx_md4String;

/// md5哈希处理
- (nullable NSString *)jx_md5String;

/// 16位MD5 哈希处理
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

#pragma mark - DES 加密
/**
 des 加密 key必须大于8字节
 @param key 秘钥
 @param desIv iv 初始化向量,ECB 不需要指定(秘钥偏移量)，例：@"qwertyui"
 @param isUse true返回base64处理，false返回16进制字符串
 */
- (NSString *)jx_encryptWithDES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUseBase64:(BOOL)isUse;

/**
 des 解密
 @param key 秘钥
 @param desIv iv 初始化向量,ECB 不需要指定(秘钥偏移量)
 @param isUse 是否base64处理
 */
- (NSString *)jx_decryptWithDES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUseBase64:(BOOL)isUse;

#pragma mark - 3DES 加密
/**
 3des 加密 key必须大于24字节,否则加密失败，返回错误参数
 @param key 秘钥
 @param desIv iv 初始化向量,例：@"qwertyuiopasdfghjklzxcvb"
 */
- (NSString *)jx_encryptWith3DES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUseBase64:(BOOL)isUse;
/**
 3des 解密
 @param key 秘钥
 */
- (NSString *)jx_decryptWith3DES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUseBase64:(BOOL)isUse;

#pragma mark - AES 加密
/**
 AES128 加密 key必须大于16字节,否则加密失败，返回错误参数

 @param key 秘钥 例：@"qwertyuiopasdfgh"
@param aesIv iv 初始化向量,
 */
- (NSString *)jx_encryptWithAES128_Key:(NSString *)key desIv:(nullable NSString *)aesIv isUseBase64:(BOOL)isUse;
/**
 AES128 解密 key必须大于32字节,否则加密失败，返回错误参数
 
 @param key 秘钥
 */
- (NSString *)jx_decryptWithAES128_Key:(NSString *)key desIv:(nullable NSString *)aesIv isUseBase64:(BOOL)isUse;
/**
 AES256 加密 (秘钥偏移量最少32)
 
 @param key 秘钥 例：@"qwertyuiopasdfghjklzxcvbnm123456"
 */
- (NSString *)jx_encryptWithAES256_Key:(NSString *)key desIv:(nullable NSString *)aesIv isUseBase64:(BOOL)isUse;
/**
 AES256 解密
 
 @param key 秘钥
 */
- (NSString *)jx_decryptWithAES256_Key:(NSString *)key desIv:(nullable NSString *)aesIv isUseBase64:(BOOL)isUse;

@end

NS_ASSUME_NONNULL_END
