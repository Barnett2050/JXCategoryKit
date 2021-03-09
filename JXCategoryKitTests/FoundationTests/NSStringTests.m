//
//  NSStringTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2021/3/9.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSMutableString+JXSafe.h"
#import "NSString+JXAttribute.h"
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
    
    XCTAssertEqualObjects([mutableString substringFromIndex:-10], mutableString);
    XCTAssertEqualObjects([mutableString substringFromIndex:0], mutableString);
    XCTAssertEqualObjects([mutableString substringFromIndex:5], @"滴的走，在不经意间，快的让我们都来不及在下一个路口挽留，\n也无法预测人生未知的镜头");
    XCTAssertEqualObjects([mutableString substringFromIndex:100], @"");

    XCTAssertEqualObjects([mutableString substringToIndex:-10], @"");
    XCTAssertEqualObjects([mutableString substringToIndex:0], @"");
    XCTAssertEqualObjects([mutableString substringToIndex:10], @"岁月一点一滴的走，在");
    XCTAssertEqualObjects([mutableString substringToIndex:100], mutableString);

    XCTAssertEqualObjects([mutableString substringWithRange:NSMakeRange(-10, 10)], @"岁月一点一滴的走，在");
    XCTAssertEqualObjects([mutableString substringWithRange:NSMakeRange(-10, -10)], @"");
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

- (void)test_Attribute {
    NSString *string = @"岁月一点一滴的走，在不经意间，快的让我们都来不及在下一个路口挽留，\n也无法预测人生未知的镜头";
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    [mutableDic jx_addTextFont:[UIFont systemFontOfSize:100]];
    
    
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
}

@end
