//
//  NSData+JXGeneral.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/14.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (JXGeneral)

/// NSData转化成string(返回nil的解决方案)
-(NSString *)jx_convertedToUtf8String;

/// 从main bundle获取文件数据
/// @param name 文件名称（在main bundle）
+ (nullable NSData *)jx_mainBundleDataNamed:(NSString *)name type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
