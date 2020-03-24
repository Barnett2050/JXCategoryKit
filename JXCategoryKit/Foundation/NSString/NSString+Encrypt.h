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

#pragma mark - MD5加密 主要用于客户端向服务器请求秘钥,请求的参数是双方约定好的一个MD5加密的字符串,但是一定要和后台约定好，MD5加密的位数是16位还是32位
/**
 32位MD5加密，无二次处理
 */
- (NSString *)jx_encryptWithMD5_32bit;

/**
 16位MD5加密，二次处理
 */
- (NSString *)jx_encryptWithMD5_16bit;

/**
 基于散列的消息认证码 HMAC-MD5加密
 */
- (NSString *)jx_encryptUseHMACMD5WithHmacKey:(NSString *)key;

#pragma mark - SHA加密
/**
 sha1加密方式
 */
- (NSString *)jx_encryptWithSHA1;

/**
 sha1加密再用base64处理
 */
- (NSString *)jx_encryptWithSHA1_base64;

/**
 sha256加密方式
 */
- (NSString *)jx_encryptWithSHA256;
/**
 sha384加密方式
 */
- (NSString *)jx_encryptWithSHA384;
/**
 sha512加密方式
 */
- (NSString *)jx_encryptWithSHA512;

#pragma mark - base64
/**
 base64编码
 */
- (NSString *)jx_encodeWithBase64With:(NSDataBase64EncodingOptions)optinon;
/**
 base64解码
 */
- (NSString *)jx_decodeWithBase64;

#pragma mark - HEX 转换

/**
 转为16进制字符串
 
 @param isOutputLower 是否小写 true 小写 false 大写
 */
- (NSString *)jx_hexStringFromStringWithLower:(BOOL)isOutputLower;

/**
 十六进制转换为普通字符串
 */
- (NSString *)jx_stringFromHexString;

#pragma mark - DES 加密
/**
 des 加密 key必须大于8字节
 @param key 秘钥
 @param desIv iv 初始化向量,ECB 不需要指定(秘钥偏移量)，例：@"qwertyui"
 @param isUse true返回base64处理，false返回16进制字符串
 */
- (NSString *)jx_encryptWithDES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUsewBase64:(BOOL)isUse;

/**
 des 解密
 @param key 秘钥
 @param desIv iv 初始化向量,ECB 不需要指定(秘钥偏移量)
 @param isUse 是否base64处理
 */
- (NSString *)jx_decryptWithDES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUsewBase64:(BOOL)isUse;

#pragma mark - 3DES 加密
/**
 3des 加密 key必须大于24字节,否则加密失败，返回错误参数
 @param key 秘钥
 @param desIv iv 初始化向量,例：@"qwertyuiopasdfghjklzxcvb"
 */
- (NSString *)jx_encryptWith3DES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUsewBase64:(BOOL)isUse;
/**
 3des 解密
 @param key 秘钥
 */
- (NSString *)jx_decryptWith3DES_Key:(NSString *)key desIv:(nullable NSString *)desIv isUsewBase64:(BOOL)isUse;

#pragma mark - AES 加密
/**
 AES128 加密 key必须大于16字节,否则加密失败，返回错误参数

 @param key 秘钥 例：@"qwertyuiopasdfgh"
@param aesIv iv 初始化向量,
 */
- (NSString *)jx_encryptWithAES128_Key:(NSString *)key desIv:(nullable NSString *)aesIv isUsewBase64:(BOOL)isUse;
/**
 AES128 解密 key必须大于32字节,否则加密失败，返回错误参数
 
 @param key 秘钥
 */
- (NSString *)jx_decryptWithAES128_Key:(NSString *)key desIv:(nullable NSString *)aesIv isUsewBase64:(BOOL)isUse;
/**
 AES256 加密 (秘钥偏移量最少32)
 
 @param key 秘钥 例：@"qwertyuiopasdfghjklzxcvbnm123456"
 */
- (NSString *)jx_encryptWithAES256_Key:(NSString *)key desIv:(nullable NSString *)aesIv isUsewBase64:(BOOL)isUse;
/**
 AES256 解密
 
 @param key 秘钥
 */
- (NSString *)jx_decryptWithAES256_Key:(NSString *)key desIv:(nullable NSString *)aesIv isUsewBase64:(BOOL)isUse;

@end

NS_ASSUME_NONNULL_END
