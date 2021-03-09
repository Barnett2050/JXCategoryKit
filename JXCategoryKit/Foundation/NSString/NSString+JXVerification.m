//
//  NSString+JXVerification.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSString+JXVerification.h"

@implementation NSString (JXVerification)

- (BOOL)jx_accountNumberIsValidateWithSpecialCharacters:(NSString *)specialC min:(NSInteger)min max:(NSInteger)max
{
    NSString *userNameRegex;
    if (specialC != nil && specialC.length > 0) {
        userNameRegex = [NSString stringWithFormat:@"^[A-Za-z0-9%@]{%ld,%ld}+$",specialC,min,max];
    }else {
        userNameRegex = [NSString stringWithFormat:@"^[A-Za-z0-9]{%ld,%ld}+$",min,max];
    }
    return [self jx_isValidateWith:userNameRegex];
}
- (BOOL)jx_mobileIsValidate
{
    NSString *mobileRegex = @"^1(3[0-9]|4[6-9]|5[0-35-9]|6[6]|7[0-8]|8[0-9]|9[89])\\d{8}$";
    return [self jx_isValidateWith:mobileRegex];
}
- (BOOL)jx_CMMobileIsValidate
{
    NSString *cmRegex = @"^1(3[4-9]|4[78]|5[0-27-9]|7[28]|8[2-478]|9[8])\\d{8}$";
    return [self jx_isValidateWith:cmRegex];
}
- (BOOL)jx_CUMobileIsValidate
{
    NSString *cuRegex = @"^1(3[0-2]|4[6]|5[56]|6[6]|7[156]|8[56])\\d{8}$";
    return [self jx_isValidateWith:cuRegex];
}
- (BOOL)jx_CTMobileIsValidate
{
    NSString *ctRegex = @"^1(3[3]|4[9]|5[3]|7[347]|8[019]|9[9])\\d{8}$";
    return [self jx_isValidateWith:ctRegex];
}
- (BOOL)jx_emailIsValidate
{
    /*
     @之前必须有内容且只能是字母（大小写）、数字、下划线(_)、减号（-）、点（.）
     @和最后一个点（.）之间必须有内容且只能是字母（大小写）、数字、点（.）、减号（-），且两个点不能挨着
     最后一个点（.）之后必须有内容且内容只能是字母（大小写）、数字且长度为大于等于2个字节，小于等于6个字节
     */
    NSString *emailRegex = @"^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$";
    return [self jx_isValidateWith:emailRegex];
}

- (BOOL)jx_accountPasswordIsValidateWithSpecialCharacters:(NSString *)specialC
                                           leastOneNumber:(BOOL)leastOneNumber
                                  leastOneUppercaseLetter:(BOOL)leastOneUppercaseLetter
                                  leastOneLowercaseLetter:(BOOL)leastOneLowercaseLetter
                                leastOneSpecialCharacters:(BOOL)leastOneSpecialCharacters
                                                      min:(NSInteger)min
                                                      max:(NSInteger)max
{
    NSMutableString *passWordRegex;
    if (specialC != nil && specialC.length > 0) {
        passWordRegex = [NSMutableString stringWithFormat:@"^[A-Za-z0-9%@]{%ld,%ld}$",specialC,min,max];
    } else {
        passWordRegex = [NSMutableString stringWithFormat:@"^[A-Za-z0-9]{%ld,%ld}$",min,max];
    }
    
    if (leastOneNumber) {
        [passWordRegex insertString:@"(?=.*[0-9])" atIndex:1];
    }
    if (leastOneUppercaseLetter) {
        [passWordRegex insertString:@"(?=.*[A-Z])" atIndex:1];
    }
    if (leastOneLowercaseLetter) {
        [passWordRegex insertString:@"(?=.*[a-z])" atIndex:1];
    }
    if (leastOneSpecialCharacters && specialC != nil && specialC.length > 0) {
        NSString *scString = [NSString stringWithFormat:@"(?=.*[%@])",specialC];
        [passWordRegex insertString:scString atIndex:1];
    }
    return [self jx_isValidateWith:passWordRegex];
}

- (BOOL)jx_verificationCodeIsValidateWithMin:(NSInteger)min max:(NSInteger)max
{
    NSString *regex = [NSString stringWithFormat:@"^(\\d{%ld,%ld})",min,max];
    return [self jx_isValidateWith:regex];
}
- (BOOL)jx_identityCardIsValidate
{
    if (!(self.length == 15 || self.length == 18)) {
        return false;
    }
    NSMutableString *idString = [NSMutableString stringWithString:self];
    // 地址码校验
    NSString *addressCode = [idString substringWithRange:NSMakeRange(0, 2)];
    NSString *addressCodeRegex = @"^((1[1-5]|2[1-3]|3[1-7]|4[1-3]|5[0-4]|6[1-5]|71|8[1-2]))";
    if (![addressCode jx_isValidateWith:addressCodeRegex]) {
        return false;
    }
    
    // 出生日期码校验
    NSString *bornCode;
    NSString *bornCodeRegex;
    if (self.length == 15) {
        bornCode = [idString substringWithRange:NSMakeRange(6, 6)];
        bornCodeRegex = @"^\\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)$";
    } else {
        bornCode = [idString substringWithRange:NSMakeRange(6, 8)];
        bornCodeRegex = @"^(19|20)\\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)$";
    }
    if (![bornCode jx_isValidateWith:bornCodeRegex]) {
        return false;
    }
    
    // 校验码校验
    if (self.length == 15) {
        return [self jx_isValidateWith:@"^(\\d{15})"];
    } else {
        NSString *code = [idString substringWithRange:NSMakeRange(0, 17)];
        if (![code jx_isValidateWith:@"^(\\d{17})"]) {
            return false;
        }
        NSArray *factor = @[ @7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
        NSArray *parity = @[ @"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        NSInteger sum = 0;
        for (int i = 0; i < 17; i++) {
            NSInteger num = [[code substringWithRange:NSMakeRange(i, 1)] integerValue];
            sum += num * [factor[i] integerValue];
        }
        
        NSString *parityCode = parity[sum % 11];
        NSString *lastCode = [[idString substringWithRange:NSMakeRange(17, 1)] uppercaseString];
        return [parityCode isEqualToString:lastCode];
    }
}

- (BOOL)jx_QQCodeIsValidate
{
    NSString *regex = @"[1-9][0-9]{4,}";//第一位1-9之间的数字，第二位0-9之间的数字，数字范围4-14个之间
    return [self jx_isValidateWith:regex];
}
- (BOOL)jx_WechatIsValidate
{
    NSString *regex = @"^[a-zA-Z][a-zA-Z0-9_-]{6,20}$";
    return [self jx_isValidateWith:regex];
}
- (BOOL)jx_inputLegalIsValidate
{
    NSString *stringRegex01 = @"[\u4E00-\u9FA5a-zA-Z0-9\\@\\#\\$\\^\\&\\*\\(\\)\\-\\+\\.\\ \\_]*";
    NSString *stringRegex02 = @"[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*";
    return ([self jx_isValidateWith:stringRegex01] || [self jx_isValidateWith:stringRegex02]) && ![self jx_stringIsContainsEmoji];
}
- (BOOL)jx_carNumberIsValidate
{
    NSString *carRegex = @"^(([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z](([0-9]{5}[DF])|([DF]([A-HJ-NP-Z0-9])[0-9]{4})))|([京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领][A-Z][A-HJ-NP-Z0-9]{4}[A-HJ-NP-Z0-9挂学警港澳使领]))$";
    return [self jx_isValidateWith:carRegex];
}


- (BOOL)jx_URLStringIsValidate
{
    if (self.length == 0) {
        return false;
    }
    NSError *error;
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    NSString *substringForMatch;
    for (NSTextCheckingResult *match in arrayOfAllMatches) {
        substringForMatch = [self substringWithRange:match.range];
    }
    return substringForMatch.length > 0;
}

- (BOOL)jx_hanNumCharStringIsValidate
{
    NSString *regex = @"^[a-zA-Z0-9\u4e00-\u9fa5]*$";
    return [self jx_isValidateWith:regex];
    
}
- (BOOL)jx_numCharStringIsValidate
{
    NSString *regex = @"^[a-zA-Z0-9]*$";
    return [self jx_isValidateWith:regex];
}

- (BOOL)jx_stringIsAllEnglishAlphabet
{
    NSString *reges = @"^[A-Za-z]+$";
    return [self jx_isValidateWith:reges];
}

- (BOOL)jx_stringIsChineseCharacterAndLettersAndNumbersAndUnderScore
{
    NSString *regex = @"^[a-zA-Z0-9\u4e00-\u9fa5_]*$";
    return [self jx_isValidateWith:regex];
}
- (BOOL)jx_stringIsContainsEmoji
{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if ((0x1d000 <= uc && uc <= 0x1f77f) || (0x1F900 <= uc && uc <=0x1f9ff)){
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }else if (hs == 0x200d){
                                      returnValue = YES;
                                  }
                              }
                          }];
    return returnValue;
}

- (BOOL)jx_stringIsInteger
{
    NSString *reges = @"^-?[1-9]\\d*$";
    return [self jx_isValidateWith:reges];
}

- (BOOL)jx_stringIsPositiveInteger
{
    NSString *reges = @"^[1-9]\\d*$";
    return [self jx_isValidateWith:reges];
}

- (BOOL)jx_stringIsNon_PositiveInteger
{
    NSString *reges = @"^-[1-9]\\d*|0$";
    return [self jx_isValidateWith:reges];
}

- (BOOL)jx_stringIsNegativeInteger
{
    NSString *reges = @"^-[1-9]\\d*$";
    return [self jx_isValidateWith:reges];
}

- (BOOL)jx_stringIsNon_NegativeInteger
{
    NSString *reges = @"^[1-9]\\d*|0$";
    return [self jx_isValidateWith:reges];
}

- (BOOL)jx_stringIsPositiveFloat
{
    NSString *reges = @"^[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*$";
    return [self jx_isValidateWith:reges];
}

- (BOOL)jx_stringIsNegativeFloat
{
    NSString *reges = @"^-[1-9]\\d*\\.\\d*|-0\\.\\d*[1-9]\\d*$";
    return [self jx_isValidateWith:reges];
}

- (BOOL)jx_stringIsFloat
{
    NSString *reges = @"^-?[1-9]\\d*\\.\\d*|-0\\.\\d*[1-9]\\d*$";
    return [self jx_isValidateWith:reges];
}

#pragma mark - private
- (BOOL)jx_isValidateWith:(NSString *)regexStr
{
    if (self.length < 0) {
        return false;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [predicate evaluateWithObject:self];
}
@end
