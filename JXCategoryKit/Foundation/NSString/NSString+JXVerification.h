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
/**
 有效账号验证,数字和字母
 */
- (BOOL)jx_isValidateAccountNumberWith:(NSInteger)min max:(NSInteger)max;
/**
 有效密码验证，数字和字母
 */
- (BOOL)jx_isValidateAccountPasswordWith:(NSInteger)min max:(NSInteger)max;
/**
 有效验证码验证
 */
- (BOOL)jx_isValidateVerificationCode;
/**
 手机号码验证
 移动：134,135,136,137,138,139,147,148,150,151,152,157,158,159,172、178、182、183、184、187、188、198
 联通：130、131、132、145（无线上网卡）,146、155、156,166,171、175、176、185、186、
 电信：133、149、153、173,174、177、180、181、189,199
 */
- (BOOL)jx_isValidateMobile;
/**
 中国移动手机号码验证 China Mobile
 */
- (BOOL)jx_isValidateCMMobile;
/**
 中国联通手机号码验证 China Unicom
 */
- (BOOL)jx_isValidateCUMobile;
/**
 中国电信手机号码验证 China Telecom
 */
- (BOOL)jx_isValidateCTMobile;
/**
 身份证号码验证
 */
- (BOOL)jx_isValidateIdentityCard;
/**
 有效邮箱验证
 */
- (BOOL)jx_isValidateEmail;
/**
 昵称有效验证
 */
- (BOOL)jx_isValidateNickName;
/**
 QQ号码验证
 */
- (BOOL)jx_isValidateQQ;
/**
 微信号码验证
 */
- (BOOL)jx_isValidateWechat;
/**
 (个性签名，组织姓名，组织名称）验证
 */
- (BOOL)jx_isValidateInputLegal;
/**
 车牌号码验证
 */
- (BOOL)jx_isValidateCarNumber;

#pragma mark - 其他
/**
 字符串是URL地址验证
 */
- (BOOL)jx_isValidateURL;
/**
 字符串纯汉字数字字母组成验证
 */
- (BOOL)jx_isValidateHanNumChar;
/**
 字符串纯字母数字验证
 */
- (BOOL)jx_isValidateNumChar;
/**
 字符串是否为汉字，字母，数字和下划线组成
 */
- (BOOL)jx_isChineseCharacterAndLettersAndNumbersAndUnderScore;
/**
 字符串是否包含表情
 */
- (BOOL)jx_isContainsEmoji;
/**
 字符串判断是否为整形数字
 */
- (BOOL)jx_isPureInt;
/**
 字符串纯英文字母
 */
- (BOOL)jx_isAllAlphabet;

@end

NS_ASSUME_NONNULL_END
