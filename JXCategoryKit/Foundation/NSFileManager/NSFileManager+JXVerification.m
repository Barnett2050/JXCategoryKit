//
//  NSFileManager+JXVerification.m
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSFileManager+JXVerification.h"

#define AMR_MAGIC_NUMBER "#!AMR\n"

@implementation NSFileManager (JXVerification)

+ (BOOL)jx_fileIsExists:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)jx_creatDirectory:(NSString *)path
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    //目标路径的目录不存在则创建目录
    if (isDir && existed) {
        return true;
    }else if(!existed && isDir)
    {
        return [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }else
    {
        return false;
    }
}


+ (BOOL)jx_isTimeoutWithPath:(NSString *)path time:(NSTimeInterval)timeout {
    
    NSDictionary *info = [[NSFileManager defaultManager]
                          attributesOfItemAtPath:path error:nil];
    
    NSDate *creationDate = [info valueForKey:NSFileCreationDate];
    NSDate *currentDate = [NSDate date];
    
    return [currentDate timeIntervalSinceDate:creationDate] > timeout;
}

+ (BOOL)jx_resetFinderWithPath:(NSString *)finderPath {
    
    BOOL ret = YES;
    if ([[NSFileManager defaultManager] fileExistsAtPath:finderPath]) {
        ret &= [[NSFileManager defaultManager] removeItemAtPath:finderPath
                                                          error:nil];
    }
    ret &= [[NSFileManager defaultManager] createDirectoryAtPath:finderPath
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:nil];
    return ret;
}

+ (BOOL)jx_removeFileWithPath:(NSString *)filePath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return YES;
    }
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+ (BOOL)jx_isAMR:(NSString*)audioPath
{
    NSData* data = [NSData dataWithContentsOfFile:audioPath];
    const char* rfile = [data bytes];
    if (rfile == nil) {
        return false;
    }
    // 检查amr文件头
    if (strncmp(rfile, AMR_MAGIC_NUMBER, strlen(AMR_MAGIC_NUMBER)) == 0)
    {
        return YES;
    }
    
    return NO;
}

+ (BOOL)jx_isDirectory:(NSString *)filePath
{
    BOOL isDirectory = false;
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    return isDirectory;
}

/**移动文件*/
+ (BOOL)jx_moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (srcPath.length < 1) {
        return false;
    }
    BOOL srcExisted = [fileManager fileExistsAtPath:srcPath isDirectory:nil];
    if (!srcExisted) {
        return false;
    }
    
    //如果不存在则创建目录
    BOOL flag = [self jx_creatDirectory:[dstPath stringByDeletingLastPathComponent]];
    if (!flag) {
        return false;
    }
    
    NSError *error;
    BOOL moveSuccess = [fileManager moveItemAtPath:srcPath toPath:dstPath error:&error];
    return moveSuccess;
}
@end
