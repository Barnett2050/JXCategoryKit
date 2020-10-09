//
//  NSFileManager+JXFilePath.h
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    JXDocumentPathType, // 读写
    JXCachesPathType, // 读写
    JXPreferencesPathType, // 读写
    JXTempPathType, // 读写
    JXBundlePathType // 读
} JXPathType;

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (JXFilePath)

/**
 快速返回沙盒中，你指定的系统文件的路径。tmp文件除外，tmp用系统的NSTemporaryDirectory()函数更加便捷
 
 @param directory NSSearchPathDirectory枚举
 @return 快速你指定的系统文件的路径
 */
+ (NSString *)jx_pathForSystemFile:(NSSearchPathDirectory)directory;
/**
 快速返回沙盒中，你指定的系统文件的中某个子文件的路径。tmp文件除外，请使用filePathAtTempWithFileName，不创建文件
 
 @param directory NSSearchPathDirectory枚举
 @param fileName 子文件名
 @return 快速返回沙盒中，你指定的系统文件的中某个子文件的路径
 */
+ (NSString *)jx_filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName;

/**
 快速返回沙盒中选定文件夹的路径
 
 @return Documents文件的路径
 */
+ (NSString *)jx_directoryPathFor:(JXPathType)pathType;

/**
 快速返回沙盒中选定文件的路径

 @param pathType 类型
 @param fileName 文件名称
 @param isCreat 没有文件是否创建
 @return 文件路径
 */
+ (NSString *)jx_filePathAt:(JXPathType)pathType fileName:(NSString *)fileName isCreat:(BOOL)isCreat;
/**
 快速返回沙盒中选定文件夹的路径
 
 @param pathType 类型
 @param directoryName 文件夹名称
 @param isCreat 没有文件是否创建
 @return 文件路径
 */
+ (NSString *)jx_directoryPathAt:(JXPathType)pathType directoryName:(NSString *)directoryName isCreat:(BOOL)isCreat;

@end

NS_ASSUME_NONNULL_END
