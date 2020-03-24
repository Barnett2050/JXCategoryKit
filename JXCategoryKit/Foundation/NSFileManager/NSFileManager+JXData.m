//
//  NSFileManager+JXData.m
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSFileManager+JXData.h"

@implementation NSFileManager (JXData)

+ (NSString *)jx_fileSizeAtPath:(NSString*)filePath {
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        double theSize = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        NSString *ret = nil;
        if (theSize<100) {
            ret = @"0.00B";
        } else if (theSize < 1024) {
            ret = [NSString stringWithFormat:@"%.2fB", theSize];
        } else if (theSize < 1024*1024) {
            ret = [NSString stringWithFormat:@"%.2fKB", theSize/1024];
        } else if (theSize < 1024*1024*1024) {
            ret = [NSString stringWithFormat:@"%.2fMB", theSize/(1024*1024)];
        } else {
            ret = [NSString stringWithFormat:@"%.2fGB", theSize/(1024*1024*1024)];
        }
        return ret;
    }
    return nil;
}

+ (void)jx_writeDataToSharedDocumentsWith:(NSData *)data DirectoryName:(NSString *)directory FileName:(NSString *)file Result:(void(^)(BOOL isSuccess))writeDataToFile
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath;
    if (directory != nil) {
        filePath = [NSString stringWithFormat:@"%@/%@/",documentsPath,directory];
        if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            // 如果没有创建一个文件夹
            [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        } else {
            NSLog(@"%@已存在.",filePath);
        }
    }else
    {
        filePath = [NSString stringWithString:documentsPath];
    }
    if (file != nil) {
        filePath = [filePath stringByAppendingPathComponent:file];
    }
    writeDataToFile([data writeToFile:filePath atomically:YES]);
}

+ (void)jx_writeDataToFile:(NSString *)filePath data:(NSData *)data
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
        [fileHandle writeData:data]; //追加写入数据
        [fileHandle closeFile];
    });
}

@end