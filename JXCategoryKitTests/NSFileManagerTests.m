//
//  NSFileManagerTests.m
//  JXCategoryKitTests
//
//  Created by Barnett on 2020/5/7.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSFileManager+JXData.h"
#import "NSFileManager+JXFilePath.h"
#import "NSFileManager+JXVerification.h"

@interface NSFileManagerTests : XCTestCase

@end

@implementation NSFileManagerTests

//- (void)setUp {
//    NSLog(@"NSFileManagerTests准备----------------------------------------------------------------------");
//}
//
//- (void)tearDown {
//    NSLog(@"NSFileManagerTests结束----------------------------------------------------------------------");
//}
//
//- (void)test_JXFilePath
//{
//    NSLog(@"NSLibraryDirectory = %@",[NSFileManager jx_pathForSystemFile:NSLibraryDirectory]);
//    NSLog(@"fileName = %@",[NSFileManager jx_filePathForSystemFile:NSDocumentDirectory withFileName:@"test1"]);
//    NSLog(@"JXDocumentPathType = %@",[NSFileManager jx_pathFor:JXDocumentPathType]);
//    NSLog(@"JXCachesPathType = %@",[NSFileManager jx_pathFor:JXCachesPathType]);
//    NSLog(@"JXPreferencesPathType = %@",[NSFileManager jx_pathFor:JXPreferencesPathType]);
//    NSLog(@"JXTempPathType = %@",[NSFileManager jx_pathFor:JXTempPathType]);
//    NSLog(@"JXBundlePathType = %@",[NSFileManager jx_pathFor:JXBundlePathType]);
//    
//    NSString *test2 = [NSFileManager jx_filePathAt:JXDocumentPathType fileName:@"test2.text" isCreat:true];
//    NSLog(@"test2 = %@",test2);
//    XCTAssertTrue([NSFileManager jx_fileIsExists:test2],@"test2未创建成功");
//    
//    NSString *test3 = [NSFileManager jx_filePathAt:JXCachesPathType fileName:@"test3.text" isCreat:true];
//    NSLog(@"test3 = %@",test3);
//    XCTAssertTrue([NSFileManager jx_fileIsExists:test3],@"test3未创建成功");
//    
//    NSString *test4 = [NSFileManager jx_filePathAt:JXPreferencesPathType fileName:@"test4.text" isCreat:true];
//    NSLog(@"test4 = %@",test4);
//    XCTAssertTrue([NSFileManager jx_fileIsExists:test4],@"test4未创建成功");
//    
//    NSString *test5 = [NSFileManager jx_filePathAt:JXTempPathType fileName:@"test5.text" isCreat:true];
//    NSLog(@"test5 = %@",test5);
//    XCTAssertTrue([NSFileManager jx_fileIsExists:test5],@"test5未创建成功");
//    
//    NSString *test6 = [NSFileManager jx_filePathAt:JXBundlePathType fileName:@"test6.text" isCreat:true];
//    NSLog(@"test6 = %@",test6);
//    XCTAssertFalse([NSFileManager jx_fileIsExists:test6],@"test6不会创建成功，bundlePath无写入权限");
//    
//    NSString *test7 = [NSFileManager jx_directoryPathAt:JXDocumentPathType directoryName:@"test7" isCreat:true];
//    NSLog(@"test7 = %@",test7);
//    XCTAssertTrue([NSFileManager jx_fileIsExists:test7],@"test7未创建成功");
//    
//    NSString *test8 = [NSFileManager jx_directoryPathAt:JXCachesPathType directoryName:@"test8" isCreat:true];
//    NSLog(@"test8 = %@",test8);
//    XCTAssertTrue([NSFileManager jx_fileIsExists:test8],@"test8未创建成功");
//    
//    NSString *test9 = [NSFileManager jx_directoryPathAt:JXPreferencesPathType directoryName:@"test9" isCreat:true];
//    NSLog(@"test9 = %@",test9);
//    XCTAssertTrue([NSFileManager jx_fileIsExists:test9],@"test9未创建成功");
//    
//    NSString *test10 = [NSFileManager jx_directoryPathAt:JXTempPathType directoryName:@"test10" isCreat:true];
//    NSLog(@"test10 = %@",test10);
//    XCTAssertTrue([NSFileManager jx_fileIsExists:test10],@"test10未创建成功");
//    
//    NSString *test11 = [NSFileManager jx_directoryPathAt:JXBundlePathType directoryName:@"test11" isCreat:true];
//    NSLog(@"test11 = %@",test11);
//    XCTAssertFalse([NSFileManager jx_fileIsExists:test11],@"test11不会创建成功，bundlePath无写入权限");
//}
//
//- (void)test_JXData
//{
//    NSString *directory = [NSFileManager jx_pathFor:JXDocumentPathType];
//    NSLog(@"文件的大小:%@",[NSFileManager jx_fileSizeStringAtPath:directory]);
//    
//    NSString *writeString = @"一段输入的代码，进行输入操作";
//    [NSFileManager jx_writeDataToSharedDocumentsWith:[writeString dataUsingEncoding:NSUTF8StringEncoding] directoryName:@"JXData" fileName:@"test.text" result:^(BOOL isSuccess) {
//        XCTAssertTrue(isSuccess,@"写入失败");
//    }];
//    
//    NSString *filePath = [NSFileManager jx_filePathAt:JXDocumentPathType fileName:@"test2.text" isCreat:true];
//    for (int i = 0; i <= 10000; i++) {
//        @autoreleasepool {
//            NSString *content = [NSString stringWithFormat:@"%d",i];
//            [NSFileManager jx_writeDataToFile:filePath data:[content dataUsingEncoding:NSUTF8StringEncoding]];
//        }
//        if (i == 10000) {
//            NSLog(@"写入完毕");
//        }
//    }
//}
//
//- (void)test_JXVerification
//{
//    NSString *filePath = [NSFileManager jx_filePathAt:JXDocumentPathType fileName:@"test2.text" isCreat:true];
//    XCTAssertTrue([NSFileManager jx_isTimeoutWithPath:filePath time:20],@"文件创建超过设定时间");
//    
//    XCTAssertTrue([NSFileManager jx_resetFinderWithPath:filePath],@"文件删除重置");
//    
//    NSString *filePath3 = [NSFileManager jx_filePathAt:JXCachesPathType fileName:@"test3.text" isCreat:true];
//    XCTAssertTrue([NSFileManager jx_removeFileWithPath:filePath3],@"删除文件");
//    
//    NSString *filePath10 = [NSFileManager jx_filePathAt:JXTempPathType fileName:@"test5.text" isCreat:true];
//    NSString *filePath11 = [NSFileManager jx_filePathAt:JXDocumentPathType fileName:@"test5.text" isCreat:true];
////    XCTAssertTrue([NSFileManager jx_moveItemAtPath:filePath10 toPath:filePath11],@"移动文件");
//}

@end
