//
//  NSBundle+JXPod.h
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (JXPod)
/**
 获取某个Bundle下的文件的路径
 
 @param fileName 文件的名字，可以带后缀名
 @param podName pod组件的名字 podName为nil的话，默认为MainBundle
 @param ext 文件的后缀名
 @return 文件的路径
 */
+ (NSString *)jx_pathWithFileName:(NSString *)fileName podName:(NSString *)podName ofType:(NSString *)ext;
/**
 获取某个podName对象的bundle对象
 
 @param podName pod的名字 podName为nil的话，默认为MainBundle
 @return 对应的bundle对象
 */
+ (NSBundle *)jx_bundleWithPodName:(NSString *)podName;

/**
 根据bundle名字获取bundle对象，只能获取mainBundle下的bundle
 
 @param bundleName bundleName
 @return bundle instance
 */
+ (NSBundle *)jx_bundleWithBundleName:(NSString *)bundleName;

/**
 根据fileName、bundleName、podName、获取文件的组件化路径
 
 @param bundleName bundleName
 @param fileName fileName
 @param podName podName
 @return filePath
 */
+ (NSString *)jx_filePathWithBundleName:(NSString *)bundleName fileName:(NSString *)fileName podName:(NSString *)podName;

/**
 根据fileName、bundleName、podName、获取文件的组件化路径URL
 
 @param bundleName bundleName
 @param fileName fileName
 @param podName podName
 @return filePath
 */
+ (NSURL *)jx_fileURLWithBundleName:(NSString *)bundleName fileName:(NSString *)fileName podName:(NSString *)podName;

/**
 获取某个podName下的nib文件并创建对象
 
 @param nibName xib文件的名字
 @param podName pod库名 podName为nil的话，默认为MainBundle
 @return 创建好的对象
 */
+ (id)jx_loadNibName:(NSString *)nibName podName:(NSString *)podName;

/**
 获取某个pod下的UIStoryboard文件的对象
 
 @param name UIStoryboard 的名字
 @param podName pod库名  podName为nil的话，默认为MainBundle
 @return UIStoryboard 对象
 */
+ (UIStoryboard *)jx_storyboardWithName:(NSString *)name podName:(NSString *)podName;

/**
 在模块内查找UIImage的方法
 
 @param imageName 图片的名字，如果是非png格式的话，要带上后缀名
 @param podName pod库名 podName为nil的话，默认为MainBundle
 @return UIImage对象
 */
+ (UIImage *)jx_imageWithName:(NSString *)imageName podName:(NSString *)podName;

/**
 对文件进行md5哈希操作 默认取文件的size为 1024 *8
 
 @param filePath 文件的沙盒路径
 @return 哈希字符串
 */
+ (NSString*)jx_fileMD5HashStringWithPath:(NSString*)filePath;

/**
 对文件进行md5哈希操作 默认取文件的size为 1024 *8
 
 @param filePath 文件的沙盒路径
 @param chunkSizeForReadingData 进行哈希的指定的片段文件的大小
 @return 哈希字符串
 */
+ (NSString*)jx_fileMD5HashStringWithPath:(NSString*)filePath WithSize:(size_t)chunkSizeForReadingData;


/**
 根据key获取本地化对应的value
 只能获取mainBundle下的
 @param key key
 @param language 语言 中文简体: @"zh-Hans";
 @return value
 */
+ (NSString *)jx_localizedStringForKey:(NSString *)key language:(NSString *)language;

/**
 根据key获取本地化对应的value
 podName 为nil的时候获取mainBundle下的值
 @param key key
 @param language 语言 中文简体: @"zh-Hans";
 
 @param podName 组件库的名字
 @return value
 */
+ (NSString *)jx_localizedStringForKey:(NSString *)key language:(NSString *)language podName:(nullable NSString *)podName;

/**
 获取main bundle下的所有bundle
 */
+ (NSArray *)jx_getTotalBundle;

/**
 获取类所在pod库文件路径

 @param cla 类
 @param fileName 文件名称，图片文件可以通过scale配置
 NSInteger scale = [UIScreen mainScreen].scale;
 NSString *imageName = NSStringFormat(@"NavigationBack@%zdx.png",scale);
 @return 路径
 */
+ (NSString *)jx_getPodResourcePathWith:(Class)cla fileName:(NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
