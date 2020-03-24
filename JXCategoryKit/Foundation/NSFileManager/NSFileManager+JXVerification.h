//
//  NSFileManager+JXVerification.h
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (JXVerification)

#pragma mark - 类方法
/**
 判断文件是否存在
 
 @param path 文件路径
 @return YES:文件存在. NO:不存在.
 */
+ (BOOL)jx_fileIsExists:(NSString *)path;

/**创建目录(已判断是否存在，无脑用就行)*/
+ (BOOL)jx_creatDirectory:(NSString *)path;
/**
 计算指定路径下的文件是否超过了规定时间
 
 @param path 文件路径
 @param timeout 设定的超时时间,单位秒
 @return YES:超时. NO:没超时
 */
+ (BOOL)jx_isTimeoutWithPath:(NSString *)path time:(NSTimeInterval)timeout;

/**
 重置文件夹
 
 @param finderPath 文件路径
 @return YES:重置成功. NO:重置失败.
 */
+ (BOOL)jx_resetFinderWithPath:(NSString *)finderPath;

/**
 删除文件
 
 @param filePath 文件路径
 @return YES:删除成功. NO:删除失败
 */
+ (BOOL)jx_removeFileWithPath:(NSString *)filePath;

/**
 根据音频文件二进制流判断是否是amr格式音频
 */
+ (BOOL)jx_isAMR:(NSString *)audioPath;

/**
 路径是否是文件类型，true 文件类型 false 文件夹类型

 @param filePath 路径
 */
+ (BOOL)jx_isDirectory:(NSString *)filePath;

/**移动文件*/
+ (BOOL)jx_moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;

@end

NS_ASSUME_NONNULL_END
