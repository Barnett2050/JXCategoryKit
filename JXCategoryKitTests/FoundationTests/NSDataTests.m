//
//  NSDataTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2020/4/29.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSData+JXEncrypt.h"
#import "NSData+JXGeneral.h"

static NSString *const testString = @"1234567890";
static NSString *const encryptKey = @"20200429";

static NSString *const aesKey = @"0123456789111213";
static NSString *const testIv = @"0123456789111213";

@interface NSDataTests : XCTestCase

@end

@implementation NSDataTests

- (void)setUp {
}

- (void)tearDown {
}

- (void)test_JXEncrypt
{
    NSData *testData = [testString dataUsingEncoding:NSUTF8StringEncoding];
    
    XCTAssertTrue([[testData jx_md2String] isEqualToString:@"38e53522a2e67fc5ea57bae1575a3107"],@"data md2哈希处理");
    XCTAssertTrue([[testData jx_md4String] isEqualToString:@"85b196c3e39457d91cab9c905f9a11c0"],@"data md4哈希处理");
    XCTAssertTrue([[testData jx_md5String] isEqualToString:@"e807f1fcf82d132f9bb018ca6738a19f"],@"data md5哈希处理");
    
    XCTAssertTrue([[testData jx_sha1String] isEqualToString:@"01b307acba4f54f55aafc33bb06bbbf6ca803e9a"],@"data sha1哈希处理");
    XCTAssertTrue([[testData jx_sha224String] isEqualToString:@"b564e8a5cf20a254eb34e1ae98c3d957c351ce854491ccbeaeb220ea"],@"data sha224哈希处理");
    XCTAssertTrue([[testData jx_sha256String] isEqualToString:@"c775e7b757ede630cd0aa1113bd102661ab38829ca52a6422ab782862f268646"],@"data sha256哈希处理");
    XCTAssertTrue([[testData jx_sha384String] isEqualToString:@"ed845f8b4f2a6d5da86a3bec90352d916d6a66e3420d720e16439adf238f129182c8c64fc4ec8c1e6506bc2b4888baf9"],@"data sha384哈希处理");
    XCTAssertTrue([[testData jx_sha512String] isEqualToString:@"12b03226a6d8be9c6e8cd5e55dc6c7920caaa39df14aab92d5e3ea9340d1c8a4d3d0b8e4314f1f6ef131ba4bf1ceb9186ab87c801af0d5c95b1befb8cedae2b9"],@"data sha512哈希处理");
    
    XCTAssertTrue([[testData jx_hmacMD5StringWithKey:encryptKey] isEqualToString:@"01de3e2062a1d46209dbef9a685e19c8"],@"data HMAC-MD5加密");
    XCTAssertTrue([[testData jx_hmacSHA1StringWithKey:encryptKey] isEqualToString:@"571a9d96fa688df2a51edf57086d0d0b5fd36e3c"],@"data HMAC-SHA1加密");
    XCTAssertTrue([[testData jx_hmacSHA224StringWithKey:encryptKey] isEqualToString:@"70c549ba7c953b0e48fd30d6cf384a9004fffd79dfdf01cfc0dcc537"],@"data HMAC-SHA224加密");
    XCTAssertTrue([[testData jx_hmacSHA256StringWithKey:encryptKey] isEqualToString:@"bf14cf26fd5beafd9575a764158ae03cb6a5b6fbb72492bdb2052e8ff1e4a721"],@"data HMAC-SHA256加密");
    XCTAssertTrue([[testData jx_hmacSHA384StringWithKey:encryptKey] isEqualToString:@"cb68513d18860e62143de511c747ce5651c5aace9112b672544020099337638dd2bad3ad2de85d8d9029d53e6127e2ee"],@"data HMAC-SHA384加密");
    XCTAssertTrue([[testData jx_hmacSHA512StringWithKey:encryptKey] isEqualToString:@"6f56ee663fea8497d6912d867b3d7c6cab5c4a8bae7908a59217fd1765836019013ab914d64a440c09eaddc187796a6bdcfc4175ffbf722984c085f432e0b813"],@"data HMAC-SHA512加密");
    
    XCTAssertTrue([[testData jx_crc32String] isEqualToString:@"261daee5"],@"data crc32哈希算法");
    
    NSString *string = @"一段测试转换文字";
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    XCTAssertTrue([stringData.jx_utf8String isEqualToString:string],@"返回以UTF8解码的字符串");
    XCTAssertTrue([stringData.jx_hexString isEqualToString:@"E4B880E6AEB5E6B58BE8AF95E8BDACE68DA2E69687E5AD97"],@"返回十六进制的大写NSString");
    XCTAssertTrue([[NSData jx_dataWithHexString:@"E4B880E6AEB5E6B58BE8AF95E8BDACE68DA2E69687E5AD97"].jx_utf8String isEqualToString:string],@"从十六进制字符串返回NSData");
    XCTAssertTrue([stringData.jx_base64EncodedString isEqualToString:@"5LiA5q615rWL6K+V6L2s5o2i5paH5a2X"],@"返回base64编码的NSString");
    XCTAssertTrue([[NSData jx_dataWithBase64EncodedString:@"5LiA5q615rWL6K+V6L2s5o2i5paH5a2X"].jx_utf8String isEqualToString:string],@"从十六进制字符串返回NSData");
    
    NSDictionary *jsonDic = @{@"name":@"Test"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"%@",jsonData.jx_jsonValueDecoded);
}

- (void)test_JXGeneral
{
    NSData *data = [NSData jx_mainBundleDataNamed:@"test" type:@"jpg"];
    NSData *gzipData = [data jx_gzippedDefault];
    XCTAssertTrue([gzipData jx_isGzippedData],@"gzip压缩");
    XCTAssertTrue([[data jx_gzippedDataWithCompressionLevel:0.9] jx_isGzippedData],@"gzip压缩");
    XCTAssertTrue([[gzipData jx_gunzippedData] isEqualToData:data],@"gzip解压缩");
    NSLog(@"%@",gzipData);
    NSLog(@"%@",[data jx_gzippedDataWithCompressionLevel:0]);
    
    NSData *zlibData = [data jx_zlibbedDefault];
    XCTAssertTrue([zlibData jx_isZlibbedData],@"zlib压缩");
    XCTAssertTrue([[data jx_zlibbedDataWithCompressionLevel:0.1] jx_isZlibbedData],@"zlib压缩");
    XCTAssertTrue([[zlibData jx_unzlibbedData] isEqualToData:data],@"zlib解压缩");
    NSLog(@"%@",zlibData);
    NSLog(@"%@",[data jx_zlibbedDataWithCompressionLevel:0.1]);
    
}

@end
