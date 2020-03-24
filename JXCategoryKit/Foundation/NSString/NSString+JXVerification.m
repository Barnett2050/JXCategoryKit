//
//  NSString+JXVerification.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSString+JXVerification.h"

@implementation NSString (JXVerification)
- (BOOL)jx_isValidateAccountNumberWith:(NSInteger)min max:(NSInteger)max
{
    NSString *userNameRegex = [NSString stringWithFormat:@"^[A-Za-z0-9]{%ld,%ld}+$",min,max];
    return [self jx_isValidateWith:userNameRegex];
}
- (BOOL)jx_isValidateAccountPasswordWith:(NSInteger)min max:(NSInteger)max
{
    NSString *passWordRegex = [NSString stringWithFormat:@"^[a-zA-Z0-9]{%ld,%ld}+$",min,max];
    // 密码强度
//    NSString *passWordRegex = @"^(?=.*\\d.*)(?=.*[a-zA-Z].*).{6,20}$";
    return [self jx_isValidateWith:passWordRegex];
}
- (BOOL)jx_isValidateVerificationCode
{
    NSString *regex = @"^(\\d{6})";
    return [self jx_isValidateWith:regex];
}
- (BOOL)jx_isValidateMobile
{
    NSString *mobileRegex = @"^1(3[0-9]|4[6-9]|5[0-35-9]|6[6]|7[0-8]|8[0-9]|9[89])\\d{8}$";
    return [self jx_isValidateWith:mobileRegex];
}
- (BOOL)jx_isValidateCMMobile
{
    NSString *cmRegex = @"^1(3[4-9]|4[78]|5[0-27-9]|7[28]|8[2-478]|9[8])\\d{8}$";
    return [self jx_isValidateWith:cmRegex];
}
- (BOOL)jx_isValidateCUMobile
{
    NSString *cuRegex = @"^1(3[0-2]|4[6]|5[56]|6[6]|7[156]|8[56])\\d{8}$";
    return [self jx_isValidateWith:cuRegex];
}
- (BOOL)jx_isValidateCTMobile
{
    NSString *ctRegex = @"^1(3[3]|4[9]|5[3]|7[347]|8[019]|9[9])\\d{8}$";
    return [self jx_isValidateWith:ctRegex];
}
- (BOOL)jx_isValidateIdentityCard
{
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self jx_isValidateWith:regex];
}
- (BOOL)jx_isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self jx_isValidateWith:emailRegex];
}
- (BOOL)jx_isValidateNickName
{
    NSString *nicknameRegex = @"([\u4e00-\u9fa5]{2,5})";
    return [self jx_isValidateWith:nicknameRegex];
}
- (BOOL)jx_isValidateQQ
{
    NSString *regex = @"[1-9][0-9]{4,14}";//第一位1-9之间的数字，第二位0-9之间的数字，数字范围4-14个之间
    return [self jx_isValidateWith:regex];
}
- (BOOL)jx_isValidateWechat
{
    NSString *regex = @"^[a-zA-Z][a-zA-Z0-9_-]{5,19}$";
    return [self jx_isValidateWith:regex];
}
- (BOOL)jx_isValidateInputLegal
{
    NSString *stringRegex01 = @"[\u4E00-\u9FA5a-zA-Z0-9\\@\\#\\$\\^\\&\\*\\(\\)\\-\\+\\.\\ \\_]*";
    NSString *stringRegex02 = @"[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*";
    NSPredicate *predicte01 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringRegex01];
    NSPredicate *predicte02 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stringRegex02];
    return ([predicte01 evaluateWithObject:self]||[predicte02 evaluateWithObject:self])&&![self jx_isContainsEmoji];
}
- (BOOL)jx_isValidateCarNumber
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    return [self jx_isValidateWith:carRegex];
}


- (BOOL)jx_isValidateURL
{
    if (self.length != 0 && self != nil) {
        NSError *error;
        NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
        NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
        
        NSString* substringForMatch;
        for (NSTextCheckingResult *match in arrayOfAllMatches)
        {
            substringForMatch = [self substringWithRange:match.range];
        }
        return substringForMatch.length > 0;
    }
    return false;
}

- (BOOL)jx_isValidateHanNumChar
{
    NSString *regex = @"^[a-zA-Z0-9\u4e00-\u9fa5]*$";
    return [self jx_isValidateWith:regex];
    
}
- (BOOL)jx_isValidateNumChar
{
    NSString *regex = @"^[a-zA-Z0-9]*$";
    return [self jx_isValidateWith:regex];
}
- (BOOL)jx_isChineseCharacterAndLettersAndNumbersAndUnderScore
{
    NSInteger len=self.length;
    for(NSInteger i=0;i<len;i++)
    {
        unichar a=[self characterAtIndex:i];
        if(!((isalpha(a))
             ||(isalnum(a))
             ||((a=='_'))
             ||((a >= 0x4e00 && a <= 0x9fa6))
             ))
            return NO;
    }
    return YES;
}
- (BOOL)jx_isContainsEmoji
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
- (BOOL)jx_isPureInt{
    
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
- (BOOL)jx_isAllAlphabet
{
    NSString *reges = @"^[A-Za-z]+$";
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
