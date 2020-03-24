//
//  NSFileManager+JXFilePath.m
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSFileManager+JXFilePath.h"

@implementation NSFileManager (JXFilePath)

/**
 快速返回沙盒中，你指定的系统文件的路径。tmp文件除外，tmp用系统的NSTemporaryDirectory()函数更加便捷
 
 @param directory NSSearchPathDirectory枚举
 @return 快速你指定的系统文件的路径
 */
+ (NSString *)jx_pathForSystemFile:(NSSearchPathDirectory)directory
{
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) lastObject];
}
/**
 快速返回沙盒中，你指定的系统文件的中某个子文件的路径。tmp文件除外，请使用filePathAtTempWithFileName
 
 @param directory 你指的的系统文件
 @param fileName 子文件名
 @return 快速返回沙盒中，你指定的系统文件的中某个子文件的路径
 */
+ (NSString *)jx_filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName
{
    return [[self jx_pathForSystemFile:directory] stringByAppendingPathComponent:fileName];
}

+ (NSString *)jx_pathFor:(JXPathType)pathType
{
    switch (pathType) {
        case JXDocumentPathType:
        case JXCachesPathType:
        case JXPreferencesPathType:
        {
            NSSearchPathDirectory searchPath = 0;
            switch (pathType) {
                case JXDocumentPathType:
                    /*
                     NSDocumentDirectory 是指程序中对应的Documents路径，而NSDocumentionDirectory对应于程序中的Library/Documentation路径，这个路径是没有读写权限的，所以看不到文件生成。
                     */
                    searchPath = NSDocumentDirectory;
                    break;
                case JXCachesPathType:
                    searchPath = NSCachesDirectory;
                    break;
                case JXPreferencesPathType:
                    searchPath = NSPreferencePanesDirectory;
                    break;
                default:
                    break;
            }
            return [NSFileManager jx_pathForSystemFile:searchPath];
        }
            break;
        case JXTempPathType:
        {
            return NSTemporaryDirectory();
        }
            break;
        case JXBundlePathType:
        {
            return [NSBundle mainBundle].bundlePath;
        }
            break;
        default:
            break;
    }
}

+ (NSString *)jx_filePathAt:(JXPathType)pathType fileName:(NSString *)fileName isCreat:(BOOL)isCreat
{
    NSString *filePath = [[self jx_pathFor:pathType] stringByAppendingPathComponent:fileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath] && isCreat) {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    return filePath;
}

+ (NSString *)jx_directoryPathAt:(JXPathType)pathType directoryName:(NSString *)directoryName isCreat:(BOOL)isCreat
{
    NSString *directoryPath = [[self jx_pathFor:pathType] stringByAppendingPathComponent:directoryName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath] && isCreat) {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:true attributes:nil error:nil];
    }
    return directoryPath;
}


@end
