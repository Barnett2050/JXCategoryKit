//
//  NSString+JXVerification.h
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JXVerification)

/// 有效账号验证,数字，(大小写)字母，特殊字符
/// @param specialC 特殊字符 @$!%*?&
/// @param min 最少字符
/// @param max 最多字符
- (BOOL)jx_accountNumberIsValidateWithSpecialCharacters:(NSString *)specialC min:(NSInteger)min max:(NSInteger)max;
/**
 手机号码验证
 移动：134,135,136,137,138,139,147,148,150,151,152,157,158,159,172、178、182、183、184、187、188、198
 联通：130、131、132、145（无线上网卡）,146、155、156,166,171、175、176、185、186、
 电信：133、149、153、173,174、177、180、181、189,199
 */
- (BOOL)jx_mobileIsValidate;

/// 中国移动手机号码验证 China Mobile
- (BOOL)jx_CMMobileIsValidate;

/// 中国联通手机号码验证 China Unicom
- (BOOL)jx_CUMobileIsValidate;

/// 中国电信手机号码验证 China Telecom
- (BOOL)jx_CTMobileIsValidate;

/// 有效邮箱验证
- (BOOL)jx_emailIsValidate;

/// 有效密码验证
/// @param specialC 特殊字符 @$!%*?&
/// @param leastOneNumber 至少一个数字
/// @param leastOneUppercaseLetter 至少一个大写字母
/// @param leastOneLowercaseLetter 至少一个小写字母
/// @param leastOneSpecialCharacters 至少一个特殊字符
/// @param min 最少字符
/// @param max 最多字符
- (BOOL)jx_accountPasswordIsValidateWithSpecialCharacters:(NSString *)specialC
                                           leastOneNumber:(BOOL)leastOneNumber
                                  leastOneUppercaseLetter:(BOOL)leastOneUppercaseLetter
                                  leastOneLowercaseLetter:(BOOL)leastOneLowercaseLetter
                                leastOneSpecialCharacters:(BOOL)leastOneSpecialCharacters
                                                      min:(NSInteger)min
                                                      max:(NSInteger)max;
/// 有效验证码验证
/// @param min 最少字符
/// @param max 最多字符
- (BOOL)jx_verificationCodeIsValidateWithMin:(NSInteger)min max:(NSInteger)max;

/// 身份证号码验证
- (BOOL)jx_identityCardIsValidate;

/// QQ号码验证
- (BOOL)jx_QQCodeIsValidate;

/// 微信号码验证
- (BOOL)jx_WechatIsValidate;

/// (个性签名，组织姓名，组织名称）验证
- (BOOL)jx_inputLegalIsValidate;

/// 车牌号码验证
- (BOOL)jx_carNumberIsValidate;

#pragma mark - 其他

/// 字符串是URL地址验证
- (BOOL)jx_URLStringIsValidate;

/// 字符串纯汉字数字字母组成验证
- (BOOL)jx_hanNumCharStringIsValidate;

/// 字符串纯字母数字验证
- (BOOL)jx_numCharStringIsValidate;

/// 字符串纯英文字母
- (BOOL)jx_stringIsAllEnglishAlphabet;

/// 字符串是否为汉字，字母，数字和下划线组成
- (BOOL)jx_stringIsChineseCharacterAndLettersAndNumbersAndUnderScore;

/// 字符串是否包含表情
- (BOOL)jx_stringIsContainsEmoji;

/// 字符串判断是否为整数
- (BOOL)jx_stringIsInteger;

/// 字符串判断是否为正整数
- (BOOL)jx_stringIsPositiveInteger;

/// 字符串判断是否为非正整数
- (BOOL)jx_stringIsNon_PositiveInteger;

/// 字符串判断是否为负整数
- (BOOL)jx_stringIsNegativeInteger;

/// 字符串判断是否为非负整数
- (BOOL)jx_stringIsNon_NegativeInteger;

/// 字符串判断是否为正浮点数
- (BOOL)jx_stringIsPositiveFloat;

/// 字符串判断是否为负浮点数
- (BOOL)jx_stringIsNegativeFloat;

/// 字符串判断是否为浮点数
- (BOOL)jx_stringIsFloat;

@end

NS_ASSUME_NONNULL_END
