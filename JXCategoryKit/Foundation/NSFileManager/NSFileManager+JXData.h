//
//  NSFileManager+JXData.h
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (JXData)

/// 获取单个文件的大小
/// @param filePath 文件路径
+ (double)jx_fileSizeAtPath:(NSString*)filePath;

/**
 获取单个文件的大小
 
 @param filePath 文件路径
 @return 文件大小 B,KB,MB,GB 保留两位
 */
+ (NSString *)jx_fileSizeStringAtPath:(NSString*)filePath;

/**
 向itunes共享文件夹中写入文件，即NSDocumentDirectory
 
 @param data 数据
 @param directory 文件夹名称
 @param file 文件名称
 */
+ (void)jx_writeDataToSharedDocumentsWith:(NSData *)data directoryName:(NSString *)directory fileName:(NSString *)file result:(void(^)(BOOL isSuccess))resultBlock;

/**
 向文件写入数据
 @param filePath 文件路径
 */
+ (void)jx_writeDataToFile:(NSString *)filePath data:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
