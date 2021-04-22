//
//  NSStringTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2021/3/9.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSMutableString+JXSafe.h"
#import "NSString+Encrypt.h"
#import "NSString+JXFormat.h"
#import "NSString+JXAttribute.h"
#import "NSString+JXGeneral.h"
#import "NSString+JXVerification.h"

@interface NSStringTests : XCTestCase

@end

@implementation NSStringTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_NSMutableString_safe {
    NSString *string = @"岁月一点一滴的走，在不经意间，快的让我们都来不及在下一个路口挽留，\n也无法预测人生未知的镜头";
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    
    XCTAssertEqualObjects([mutableString substringFromIndex:0], mutableString);
    XCTAssertEqualObjects([mutableString substringFromIndex:5], @"滴的走，在不经意间，快的让我们都来不及在下一个路口挽留，\n也无法预测人生未知的镜头");
    XCTAssertEqualObjects([mutableString substringFromIndex:100], @"");

    XCTAssertEqualObjects([mutableString substringToIndex:0], @"");
    XCTAssertEqualObjects([mutableString substringToIndex:10], @"岁月一点一滴的走，在");
    XCTAssertEqualObjects([mutableString substringToIndex:100], mutableString);

    XCTAssertEqualObjects([mutableString substringWithRange:NSMakeRange(0, 10)], @"岁月一点一滴的走，在");
    XCTAssertEqualObjects([mutableString substringWithRange:NSMakeRange(100, 10)], @"");
    XCTAssertEqualObjects([mutableString substringWithRange:NSMakeRange(0, 100)], @"岁月一点一滴的走，在不经意间，快的让我们都来不及在下一个路口挽留，\n也无法预测人生未知的镜头");
    
    XCTAssertEqual([mutableString lineRangeForRange:NSMakeRange(35, 100)].location, 34);
    XCTAssertEqual([mutableString lineRangeForRange:NSMakeRange(35, 100)].length, 12);
    XCTAssertEqual([mutableString lineRangeForRange:NSMakeRange(50, 10)].location, 34);
    XCTAssertEqual([mutableString lineRangeForRange:NSMakeRange(50, 10)].length, 12);
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"enumer"];
    [mutableString enumerateSubstringsInRange:NSMakeRange(50, 10) options:NSStringEnumerationReverse usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
    }];
    [mutableString enumerateSubstringsInRange:NSMakeRange(0, 100) options:NSStringEnumerationReverse usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        NSLog(@"===%@===%ld===%ld===%ld===%ld",substring,substringRange.location,substringRange.length,enclosingRange.location,enclosingRange.length);
        *stop = YES;
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:15 handler:NULL];
    
    [mutableString stringByReplacingOccurrencesOfString:@"路口" withString:@"路头" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 100)];
    [mutableString stringByReplacingOccurrencesOfString:@"路头" withString:@"路口" options:NSCaseInsensitiveSearch range:NSMakeRange(-10, 50)];
    
    [mutableString insertString:@"1" atIndex:-10];
    [mutableString insertString:@"1" atIndex:100];
    NSLog(@"===%@",mutableString);
}

- (void)test_Encrypt {
    NSString *testString = @"1234567890";
    NSString *encryptKey = @"20200429";
    NSString *desIv = @"zhangjianxun";
    XCTAssertTrue([[testString jx_md2String] isEqualToString:@"38e53522a2e67fc5ea57bae1575a3107"],@"string md2哈希处理");
    XCTAssertTrue([[testString jx_md4String] isEqualToString:@"85b196c3e39457d91cab9c905f9a11c0"],@"string md4哈希处理");
    XCTAssertTrue([[testString jx_md5String] isEqualToString:@"e807f1fcf82d132f9bb018ca6738a19f"],@"string md5哈希处理");
    NSLog(@"%@", [testString jx_encryptWithMD5_16bit]);
    
    XCTAssertTrue([[testString jx_sha1String] isEqualToString:@"01b307acba4f54f55aafc33bb06bbbf6ca803e9a"],@"string sha1哈希处理");
    XCTAssertTrue([[testString jx_sha224String] isEqualToString:@"b564e8a5cf20a254eb34e1ae98c3d957c351ce854491ccbeaeb220ea"],@"string sha224哈希处理");
    XCTAssertTrue([[testString jx_sha256String] isEqualToString:@"c775e7b757ede630cd0aa1113bd102661ab38829ca52a6422ab782862f268646"],@"string sha256哈希处理");
    XCTAssertTrue([[testString jx_sha384String] isEqualToString:@"ed845f8b4f2a6d5da86a3bec90352d916d6a66e3420d720e16439adf238f129182c8c64fc4ec8c1e6506bc2b4888baf9"],@"string sha384哈希处理");
    XCTAssertTrue([[testString jx_sha512String] isEqualToString:@"12b03226a6d8be9c6e8cd5e55dc6c7920caaa39df14aab92d5e3ea9340d1c8a4d3d0b8e4314f1f6ef131ba4bf1ceb9186ab87c801af0d5c95b1befb8cedae2b9"],@"string sha512哈希处理");
    
    XCTAssertTrue([[testString jx_hmacMD5StringWithKey:encryptKey] isEqualToString:@"01de3e2062a1d46209dbef9a685e19c8"],@"string HMAC-MD5加密");
    XCTAssertTrue([[testString jx_hmacSHA1StringWithKey:encryptKey] isEqualToString:@"571a9d96fa688df2a51edf57086d0d0b5fd36e3c"],@"string HMAC-SHA1加密");
    XCTAssertTrue([[testString jx_hmacSHA224StringWithKey:encryptKey] isEqualToString:@"70c549ba7c953b0e48fd30d6cf384a9004fffd79dfdf01cfc0dcc537"],@"string HMAC-SHA224加密");
    XCTAssertTrue([[testString jx_hmacSHA256StringWithKey:encryptKey] isEqualToString:@"bf14cf26fd5beafd9575a764158ae03cb6a5b6fbb72492bdb2052e8ff1e4a721"],@"string HMAC-SHA256加密");
    XCTAssertTrue([[testString jx_hmacSHA384StringWithKey:encryptKey] isEqualToString:@"cb68513d18860e62143de511c747ce5651c5aace9112b672544020099337638dd2bad3ad2de85d8d9029d53e6127e2ee"],@"string HMAC-SHA384加密");
    XCTAssertTrue([[testString jx_hmacSHA512StringWithKey:encryptKey] isEqualToString:@"6f56ee663fea8497d6912d867b3d7c6cab5c4a8bae7908a59217fd1765836019013ab914d64a440c09eaddc187796a6bdcfc4175ffbf722984c085f432e0b813"],@"string HMAC-SHA512加密");
    
    XCTAssertTrue([[testString jx_crc32String] isEqualToString:@"261daee5"],@"string crc32哈希算法");
    
    XCTAssertTrue([[[testString jx_encodeWithBase64With:NSDataBase64Encoding64CharacterLineLength] jx_decodeWithBase64] isEqualToString:testString],@"base64编码，解码");
    
    // DES
    testString = @"1234567890";
    encryptKey = @"20200429";
    desIv = @"zhangjianxun";
    NSString *desIvString = [testString jx_encryptWithType:JXCryptTypeDES key:encryptKey iv:desIv base64Handle:NO];
    NSString *desIvBase64String = [testString jx_encryptWithType:JXCryptTypeDES key:encryptKey iv:desIv base64Handle:YES];
    NSString *desString = [testString jx_encryptWithType:JXCryptTypeDES key:encryptKey iv:nil base64Handle:NO];
    NSString *desBase64String = [testString jx_encryptWithType:JXCryptTypeDES key:encryptKey iv:nil base64Handle:YES];
    
    XCTAssertTrue([desIvString isEqualToString:@"02B7BD3B2BF95B21A4B8182CF11527CC"]);
    XCTAssertTrue([desIvBase64String isEqualToString:@"Are9Oyv5WyGkuBgs8RUnzA=="]);
    XCTAssertTrue([desString isEqualToString:@"12E3C1C2A5B7B7D0431DE7E40F0128E3"]);
    XCTAssertTrue([desBase64String isEqualToString:@"EuPBwqW3t9BDHefkDwEo4w=="]);
    XCTAssertTrue([[desIvString jx_decryptWithType:JXCryptTypeDES key:encryptKey iv:desIv base64Handle:NO] isEqualToString:testString]);
    XCTAssertTrue([[desIvBase64String jx_decryptWithType:JXCryptTypeDES key:encryptKey iv:desIv base64Handle:YES] isEqualToString:testString]);
    XCTAssertTrue([[desString jx_decryptWithType:JXCryptTypeDES key:encryptKey iv:nil base64Handle:NO] isEqualToString:testString]);
    XCTAssertTrue([[desBase64String jx_decryptWithType:JXCryptTypeDES key:encryptKey iv:nil base64Handle:YES] isEqualToString:testString]);
    
    // 3des
    testString = @"1234567890";
    encryptKey = @"20210415165416abcdefghij";
    desIv = @"zhangjianxun";
    NSString *des3IvString = [testString jx_encryptWithType:JXCryptType3DES key:encryptKey iv:desIv base64Handle:NO];
    NSString *de3IvBase64String = [testString jx_encryptWithType:JXCryptType3DES key:encryptKey iv:desIv base64Handle:YES];
    NSString *des3String = [testString jx_encryptWithType:JXCryptType3DES key:encryptKey iv:nil base64Handle:NO];
    NSString *des3Base64String = [testString jx_encryptWithType:JXCryptType3DES key:encryptKey iv:nil base64Handle:YES];
    
    XCTAssertTrue([des3IvString isEqualToString:@"7AD3F47D5FD317E5F056873400B161A7"]);
    XCTAssertTrue([de3IvBase64String isEqualToString:@"etP0fV/TF+XwVoc0ALFhpw=="]);
    XCTAssertTrue([des3String isEqualToString:@"522EF95587C498EDCAFC6C1E6FB1B549"]);
    XCTAssertTrue([des3Base64String isEqualToString:@"Ui75VYfEmO3K/Gweb7G1SQ=="]);
    XCTAssertTrue([[des3IvString jx_decryptWithType:JXCryptType3DES key:encryptKey iv:desIv base64Handle:NO] isEqualToString:testString]);
    XCTAssertTrue([[de3IvBase64String jx_decryptWithType:JXCryptType3DES key:encryptKey iv:desIv base64Handle:YES] isEqualToString:testString]);
    XCTAssertTrue([[des3String jx_decryptWithType:JXCryptType3DES key:encryptKey iv:nil base64Handle:NO] isEqualToString:testString]);
    XCTAssertTrue([[des3Base64String jx_decryptWithType:JXCryptType3DES key:encryptKey iv:nil base64Handle:YES] isEqualToString:testString]);
    
    // aes128
    testString = @"1234567890";
    encryptKey = @"20210415165416gg";
    desIv = @"zhangjianxunhaha";
    
    NSString *aesiv128String = [testString jx_encryptWithType:JXCryptTypeAES128 key:encryptKey iv:desIv base64Handle:NO];
    NSString *aesiv128Base64String = [testString jx_encryptWithType:JXCryptTypeAES128 key:encryptKey iv:desIv base64Handle:YES];
    NSString *aes128String = [testString jx_encryptWithType:JXCryptTypeAES128 key:encryptKey iv:nil base64Handle:NO];
    NSString *aes128Base64String = [testString jx_encryptWithType:JXCryptTypeAES128 key:encryptKey iv:nil base64Handle:YES];
    
    XCTAssertTrue([aesiv128String isEqualToString:@"9720E6F3D3ED5AD076078D67705DF296"]);
    XCTAssertTrue([aesiv128Base64String isEqualToString:@"lyDm89PtWtB2B41ncF3ylg=="]);
    XCTAssertTrue([aes128String isEqualToString:@"1B709E872A07897F1AA2BB37D76DED02"]);
    XCTAssertTrue([aes128Base64String isEqualToString:@"G3CehyoHiX8aors3123tAg=="]);
    XCTAssertTrue([[aesiv128String jx_decryptWithType:JXCryptTypeAES128 key:encryptKey iv:desIv base64Handle:NO] isEqualToString:testString]);
    XCTAssertTrue([[aesiv128Base64String jx_decryptWithType:JXCryptTypeAES128 key:encryptKey iv:desIv base64Handle:YES] isEqualToString:testString]);
    XCTAssertTrue([[aes128String jx_decryptWithType:JXCryptTypeAES128 key:encryptKey iv:nil base64Handle:NO] isEqualToString:testString]);
    XCTAssertTrue([[aes128Base64String jx_decryptWithType:JXCryptTypeAES128 key:encryptKey iv:nil base64Handle:YES] isEqualToString:testString]);
    
    // aes192
    testString = @"1234567890";
    encryptKey = @"20210415165416zhangjianx";
    desIv = @"zhangjianxunhaha";
    
    NSString *aesiv192String = [testString jx_encryptWithType:JXCryptTypeAES192 key:encryptKey iv:desIv base64Handle:NO];
    NSString *aesiv192Base64String = [testString jx_encryptWithType:JXCryptTypeAES192 key:encryptKey iv:desIv base64Handle:YES];
    NSString *aes192String = [testString jx_encryptWithType:JXCryptTypeAES192 key:encryptKey iv:nil base64Handle:NO];
    NSString *aes192Base64String = [testString jx_encryptWithType:JXCryptTypeAES192 key:encryptKey iv:nil base64Handle:YES];

    XCTAssertTrue([aesiv192String isEqualToString:@"1516F3148FF6385C2F5A515A4FA8A7D8"]);
    XCTAssertTrue([aesiv192Base64String isEqualToString:@"FRbzFI/2OFwvWlFaT6in2A=="]);
    XCTAssertTrue([aes192String isEqualToString:@"6988D5E8A033042223FB02FB199DB1A4"]);
    XCTAssertTrue([aes192Base64String isEqualToString:@"aYjV6KAzBCIj+wL7GZ2xpA=="]);
    XCTAssertTrue([[aesiv192String jx_decryptWithType:JXCryptTypeAES192 key:encryptKey iv:desIv base64Handle:NO] isEqualToString:testString]);
    XCTAssertTrue([[aesiv192Base64String jx_decryptWithType:JXCryptTypeAES192 key:encryptKey iv:desIv base64Handle:YES] isEqualToString:testString]);
    XCTAssertTrue([[aes192String jx_decryptWithType:JXCryptTypeAES192 key:encryptKey iv:nil base64Handle:NO] isEqualToString:testString]);
    XCTAssertTrue([[aes192Base64String jx_decryptWithType:JXCryptTypeAES192 key:encryptKey iv:nil base64Handle:YES] isEqualToString:testString]);
    
    // aes256
    testString = @"1234567890";
    encryptKey = @"20210415165416zhangjianxunqazwsx";
    desIv = @"zhangjianxunhaha";
    
    NSString *aesiv256String = [testString jx_encryptWithType:JXCryptTypeAES256 key:encryptKey iv:desIv base64Handle:NO];
    NSString *aesiv256Base64String = [testString jx_encryptWithType:JXCryptTypeAES256 key:encryptKey iv:desIv base64Handle:YES];
    NSString *aes256String = [testString jx_encryptWithType:JXCryptTypeAES256 key:encryptKey iv:nil base64Handle:NO];
    NSString *aes256Base64String = [testString jx_encryptWithType:JXCryptTypeAES256 key:encryptKey iv:nil base64Handle:YES];
    
    XCTAssertTrue([aesiv256String isEqualToString:@"9AAE7A5F99B79F78E8BD1C359B34FE75"]);
    XCTAssertTrue([aesiv256Base64String isEqualToString:@"mq56X5m3n3jovRw1mzT+dQ=="]);
    XCTAssertTrue([aes256String isEqualToString:@"E0E4DECBCD6F7E59850A90346A23F3A3"]);
    XCTAssertTrue([aes256Base64String isEqualToString:@"4OTey81vflmFCpA0aiPzow=="]);
    XCTAssertTrue([[aesiv256String jx_decryptWithType:JXCryptTypeAES256 key:encryptKey iv:desIv base64Handle:NO] isEqualToString:testString]);
    XCTAssertTrue([[aesiv256Base64String jx_decryptWithType:JXCryptTypeAES256 key:encryptKey iv:desIv base64Handle:YES] isEqualToString:testString]);
    XCTAssertTrue([[aes256String jx_decryptWithType:JXCryptTypeAES256 key:encryptKey iv:nil base64Handle:NO] isEqualToString:testString]);
    XCTAssertTrue([[aes256Base64String jx_decryptWithType:JXCryptTypeAES256 key:encryptKey iv:nil base64Handle:YES] isEqualToString:testString]);
}

- (void)test_Attribute {
    NSString *string = @"岁月一点一滴的走，在不经意间，快的让我们都来不及在下一个路口挽留，\n也无法预测人生未知的镜头";
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [mutableDic jx_addTextFont:[UIFont systemFontOfSize:100]];
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [mutableAttributedString addAttributes:mutableDic range:NSMakeRange(0, string.length)];
    NSLog(@"%@",mutableAttributedString);
}

- (void)test_Format {
    NSString *moneyString = @"6743987234571";
    XCTAssertTrue([[moneyString jx_changeNumberToMoneyFormat] isEqualToString:@"6,743,987,234,571.00"]);
    NSString *phoneNumberString = @"17330518800";
    XCTAssertTrue([[phoneNumberString jx_phoneNumberHideMiddle] isEqualToString:@"173****8800"]);
    NSString *testString = @"\n移除首位换行符\n";
    XCTAssertTrue([[testString jx_removeFirstAndLastLineBreak] isEqualToString:@"移除首位换行符"]);
    NSString *idCardString = @"13020619930529031X";
    XCTAssertTrue([[idCardString jx_idCardFormat] isEqualToString:@"130206 1993 0529 031X"]);
    NSString *bankString = @"6217000780021720199";
    XCTAssertTrue([[bankString jx_bankCardFormat] isEqualToString:@"6217 0007 8002 1720 199"]);
    NSString *testString1 = @"测试代码1";
    XCTAssertTrue([[testString1 hexString] isEqualToString:@"e6b58be8af95e4bba3e7a08131"]);
    NSString *testString2 = @"e6b58be8af95e4bba3e7a08131";
    XCTAssertTrue([[testString2 jx_hexStringToNormal] isEqualToString:testString1]);
}

- (void)test_General {
    NSString *hanString = @"张建勋";
    XCTAssertTrue([[hanString jx_pinyinString] isEqualToString:@"zhang jian xun"]);
    XCTAssertTrue([[hanString jx_firstCharacterString] isEqualToString:@"Z"]);
    XCTAssertTrue([hanString getStringLenthOfBytes] == 6);
    XCTAssertTrue([[hanString jx_subBytesOfstringToIndex:3] isEqualToString:@"张"]);
}

- (void)test_Verification {
    XCTAssertTrue([@"123$@%!*?&345" jx_accountNumberIsValidateWithSpecialCharacters:@"@$!%*?&" min:6 max:20]);
    XCTAssertFalse([@"123$" jx_accountNumberIsValidateWithSpecialCharacters:@"@$!%*?&" min:6 max:20]);
    XCTAssertFalse([@"123@$!%*?&234324234234234" jx_accountNumberIsValidateWithSpecialCharacters:@"@$!%*?&" min:6 max:20]);
    XCTAssertFalse([@"123$@%)(" jx_accountNumberIsValidateWithSpecialCharacters:@"@$!%*?&" min:6 max:20]);
    
    XCTAssertTrue([@"13467897766" jx_mobileIsValidate]);
    XCTAssertFalse([@"134678977" jx_mobileIsValidate]);
    
    XCTAssertTrue([@"13467897766" jx_CMMobileIsValidate]);
    XCTAssertFalse([@"13067897766" jx_CMMobileIsValidate]);
    
    XCTAssertTrue([@"13067897766" jx_CUMobileIsValidate]);
    XCTAssertFalse([@"13467897766" jx_CUMobileIsValidate]);
    
    XCTAssertTrue([@"13367897766" jx_CTMobileIsValidate]);
    XCTAssertFalse([@"13467897766" jx_CTMobileIsValidate]);
    
    XCTAssertTrue([@"493650065@qq.com" jx_emailIsValidate]);
    XCTAssertFalse([@"493650065@.com" jx_emailIsValidate]);
    
    XCTAssertTrue([@"123$@%!*?&3aB" jx_accountPasswordIsValidateWithSpecialCharacters:@"@$!%*?&" leastOneNumber:YES leastOneUppercaseLetter:YES leastOneLowercaseLetter:YES leastOneSpecialCharacters:YES min:6 max:20]);
    XCTAssertTrue([@"123$@%!*?&3aB" jx_accountPasswordIsValidateWithSpecialCharacters:@"@$!%*?&" leastOneNumber:NO leastOneUppercaseLetter:NO leastOneLowercaseLetter:NO leastOneSpecialCharacters:NO min:6 max:20]);
    
    XCTAssertTrue([@"456789" jx_verificationCodeIsValidateWithMin:6 max:6]);
    XCTAssertFalse([@"456789" jx_verificationCodeIsValidateWithMin:5 max:5]);
    
    XCTAssertTrue([@"13020619930529031X" jx_identityCardIsValidate]);
    XCTAssertFalse([@"1302061993529031X" jx_identityCardIsValidate]);
    XCTAssertFalse([@"13020619930529031C" jx_identityCardIsValidate]);
    XCTAssertFalse([@"123456789098765432" jx_identityCardIsValidate]);
    
    XCTAssertTrue([@"123456" jx_QQCodeIsValidate]);
    
    XCTAssertTrue([@"www.baidu.com" jx_URLStringIsValidate]);
    XCTAssertTrue([@"www.baidu.com.qqcom" jx_URLStringIsValidate]);
    
    XCTAssertFalse([@"www.baidu.com.qqcom" jx_hanNumCharStringIsValidate]);
    XCTAssertTrue([@"数字zimu123" jx_hanNumCharStringIsValidate]);
    
    XCTAssertTrue([@"wwwbaiducomqqcom" jx_stringIsAllEnglishAlphabet]);
    XCTAssertFalse([@"数字zimu123" jx_stringIsAllEnglishAlphabet]);
    
    XCTAssertTrue([@"wwwbaiducomqqcom" jx_stringIsAllEnglishAlphabet]);
    XCTAssertFalse([@"数字zimu123" jx_stringIsAllEnglishAlphabet]);
    
    XCTAssertTrue([@"wwwbaiducomqqcom汉字123_" jx_stringIsChineseCharacterAndLettersAndNumbersAndUnderScore]);
    XCTAssertFalse([@"数字zimu123?" jx_stringIsChineseCharacterAndLettersAndNumbersAndUnderScore]);
    
    XCTAssertTrue([@"wwwbaiducomqqcom😡" jx_stringIsContainsEmoji]);
    XCTAssertFalse([@"数字zimu123?" jx_stringIsContainsEmoji]);
    
    XCTAssertTrue([@"12390865" jx_stringIsInteger]);
    XCTAssertTrue([@"-12390865" jx_stringIsInteger]);
    XCTAssertFalse([@"数字zimu123?" jx_stringIsInteger]);
    
    XCTAssertTrue([@"12390865" jx_stringIsPositiveInteger]);
    XCTAssertFalse([@"-12390865" jx_stringIsPositiveInteger]);
    XCTAssertFalse([@"数字zimu123?" jx_stringIsPositiveInteger]);
    
    XCTAssertTrue([@"0" jx_stringIsNon_PositiveInteger]);
    XCTAssertTrue([@"-12390865" jx_stringIsNon_PositiveInteger]);
    XCTAssertFalse([@"数字zimu123?" jx_stringIsNon_PositiveInteger]);
    XCTAssertFalse([@"12390865" jx_stringIsNon_PositiveInteger]);
    
    XCTAssertTrue([@"-123" jx_stringIsNegativeInteger]);
    XCTAssertFalse([@"数字zimu123?" jx_stringIsNegativeInteger]);
    XCTAssertFalse([@"-12390865.6" jx_stringIsNegativeInteger]);
    XCTAssertFalse([@"0" jx_stringIsNegativeInteger]);
    
    XCTAssertTrue([@"123" jx_stringIsNon_NegativeInteger]);
    XCTAssertTrue([@"0" jx_stringIsNon_NegativeInteger]);
    XCTAssertFalse([@"数字zimu123?" jx_stringIsNon_NegativeInteger]);
    XCTAssertFalse([@"12390865.6" jx_stringIsNon_NegativeInteger]);
    XCTAssertFalse([@"-122" jx_stringIsNon_NegativeInteger]);
    
    XCTAssertTrue([@"123.45" jx_stringIsPositiveFloat]);
    XCTAssertFalse([@"数字zimu123?" jx_stringIsPositiveFloat]);
    XCTAssertFalse([@"-12390865.6" jx_stringIsPositiveFloat]);
    XCTAssertFalse([@"-122" jx_stringIsPositiveFloat]);
    XCTAssertFalse([@"0" jx_stringIsPositiveFloat]);
    
    XCTAssertTrue([@"-123.45" jx_stringIsNegativeFloat]);
    XCTAssertFalse([@"数字zimu123?" jx_stringIsNegativeFloat]);
    XCTAssertFalse([@"12390865.6" jx_stringIsNegativeFloat]);
    XCTAssertFalse([@"122" jx_stringIsNegativeFloat]);
    XCTAssertFalse([@"0" jx_stringIsNegativeFloat]);
    
    XCTAssertTrue([@"-123.45" jx_stringIsFloat]);
    XCTAssertTrue([@"123.45" jx_stringIsFloat]);
    XCTAssertFalse([@"数字zimu123?" jx_stringIsFloat]);
    XCTAssertFalse([@"12390865" jx_stringIsFloat]);
    XCTAssertFalse([@"-122" jx_stringIsFloat]);
    XCTAssertFalse([@"0" jx_stringIsFloat]);
}

@end
