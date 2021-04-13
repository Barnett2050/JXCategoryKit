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

/// 如果数据经过gzip编码，则此方法将返回YES。
- (BOOL)jx_isGzippedData;

/// 如果数据经过zlib编码，则此方法将返回YES。
- (BOOL)jx_isZlibbedData;

/// 此方法将应用gzip deflate算法并返回压缩数据。 压缩级别是介于0.0和1.0之间的浮点值，其中0.0表示无压缩，而1.0表示最大压缩。 值0.1将提供最快的压缩率。 如果提供负值，这将应用默认的压缩级别，该值大约等于0.7。
/// @param level 0.0 ~ 1.0
- (nullable NSData *)jx_gzippedDataWithCompressionLevel:(float)level;

/// 默认压缩级别。0.7
- (nullable NSData *)jx_gzippedDefault;

/// 此方法将解压缩使用deflate算法压缩的数据并返回结果。
- (nullable NSData *)jx_gunzippedData;

/// 此方法将应用zlib deflate算法并返回压缩数据。
/// @param level 压缩级别
- (nullable NSData *)jx_zlibbedDataWithCompressionLevel:(float)level;

/// 以默认压缩级别将数据压缩为zlib压缩。
- (nullable NSData *)jx_zlibbedDefault;

/// 从zlib压缩的数据中解压缩数据。
- (nullable NSData *)jx_unzlibbedData;

/// NSData转化成string(返回nil的解决方案)
-(NSString *)jx_convertedToUtf8String;
/// 从main bundle获取文件数据
/// @param name 文件名称（在main bundle）
+ (nullable NSData *)jx_mainBundleDataNamed:(NSString *)name type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
