//
//  NSError+JXGeneral.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/3/24.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSError (JXGeneral)

/**
 生成自定义错误

 @param code 错误码
 @param errorMsg 错误信息
 */
+ (NSError *)jx_errorWithCode:(int)code errorMessage:(NSString*)errorMsg;

#pragma mark - 实例方法
/**
 错误码
 */
- (NSInteger)jx_errorCode;

/**
 错误信息
 */
- (NSString*)jx_errorMsg;

@end

NS_ASSUME_NONNULL_END
