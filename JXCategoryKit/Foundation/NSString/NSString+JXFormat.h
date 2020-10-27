//
//  NSString+JXFormat.h
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JXFormat)

/**
 数字转为金额 例：1000000.00 -> 1,000,000.00
 */
- (NSString *)jx_changeNumberToMoneyFormat;

/**
 手机号码中间四位替换****
 */
- (NSString *)jx_phoneNumberHideMiddle;

/**
 移除首尾换行符
 */
- (NSString *)jx_removeFirstAndLastLineBreak;

/**
 身份证号码格式化 6-4-4-4格式
 */
- (NSString *)jx_idCardFormat;
/**
 银行卡格式化
 */
- (NSString *)jx_bankCardFormat;

/**
 字符串转16进制
 */
- (NSString *)hexString;

/**
 出现类似这样格式的字段"\\U6df1\\U5733\\U56fd\\U5f00\\U884c01\\U673a\\U623",通常为Unicode码，将Unicode码转换
 */
- (NSString *)jx_replaceUnicode;

/**
 json转换
 */
- (id)jx_jsonStringToJson;

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

@end

NS_ASSUME_NONNULL_END
