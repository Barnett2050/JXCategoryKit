//
//  NSString+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JXGeneral)

/**
 汉字转拼音,每个汉字拼音中间空格隔开
 */
- (NSString *)jx_pinyinString;

/**
 返回字符串第一个字母大写
 */
- (NSString *)jx_firstCharacterString;


/**
 获取字符串字节长度
 */
- (NSInteger)getStringLenthOfBytes;

/**
 根据字节截取字符串
 */
- (NSString *)jx_subBytesOfstringToIndex:(NSInteger)index;

/**
 从html string获取图片url 数组
 */
- (NSArray *)jx_getImageurlFromHtmlString;

/**
 修改html标签style
 */
+ (NSString *)jx_modifyHtmlImgStyleWith:(NSString *)html;

@end

NS_ASSUME_NONNULL_END
