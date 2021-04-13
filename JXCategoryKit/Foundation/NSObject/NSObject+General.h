//
//  NSObject+General.h
//  JXCategoryKit
//
//  Created by Barnett on 2021/4/1.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (General)

/// 转化为json串
- (nullable NSString *)jx_jsonStringEncoded;

/// 将数组或者字典序列化为二进制属性列表数据。
- (nullable NSData *)jx_plistData;

/// 根据指定的属性列表数据(data)返回NSArray或者NSDictionary
/// @param plistData 数据data
/// @param resultBlock 回调
+ (void)jx_convertWithPlistData:(NSData *)plistData resultBlock:(void(^)(NSDictionary *plistDictionary,NSArray *plistArray))resultBlock;

@end

NS_ASSUME_NONNULL_END
