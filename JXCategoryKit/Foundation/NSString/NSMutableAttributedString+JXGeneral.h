//
//  NSMutableAttributedString+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (JXGeneral)

/**
 获取一段可变字符串的属性字典
 */
- (NSDictionary *)jx_getAttributedDictionaryWith:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
