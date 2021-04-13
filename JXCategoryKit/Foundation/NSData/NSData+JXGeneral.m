//
//  NSData+JXGeneral.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/14.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSData+JXGeneral.h"
#include <zlib.h>

@implementation NSData (JXGeneral)

- (BOOL)jx_isGzippedData
{
    const UInt8 *bytes = (const UInt8 *)self.bytes;
    return (self.length >= 2 && bytes[0] == 0x1f && bytes[1] == 0x8b);
}

- (BOOL)jx_isZlibbedData
{
    const UInt8 *bytes = (const UInt8 *)self.bytes;
    return (self.length >= 2 && bytes[0] == 0x78);
}


- (NSData *)jx_gzippedDataWithCompressionLevel:(float)level
{
    if (self.length == 0 || [self jx_isGzippedData]) {
        return self;
    }

    z_stream stream;
    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    stream.opaque = Z_NULL;
    stream.avail_in = (uint)self.length;
    stream.next_in = (Bytef *)(void *)self.bytes;
    stream.total_out = 0;
    stream.avail_out = 0;

    static const NSUInteger ChunkSize = 16384;

    NSMutableData *output = nil;
    int compression = (level < 0.0f)? Z_DEFAULT_COMPRESSION: (int)(roundf(level * 9));
    if (deflateInit2(&stream, compression, Z_DEFLATED, 31, 8, Z_DEFAULT_STRATEGY) == Z_OK) {
        output = [NSMutableData dataWithLength:ChunkSize];
        while (stream.avail_out == 0)
        {
            if (stream.total_out >= output.length)
            {
                output.length += ChunkSize;
            }
            stream.next_out = (uint8_t *)output.mutableBytes + stream.total_out;
            stream.avail_out = (uInt)(output.length - stream.total_out);
            deflate(&stream, Z_FINISH);
        }
        deflateEnd(&stream);
        output.length = stream.total_out;
    }

    return output;
}

- (NSData *)jx_gzippedDefault
{
    return [self jx_gzippedDataWithCompressionLevel:-1.0f];
}

- (NSData *)jx_gunzippedData
{
    if (self.length == 0 || ![self jx_isGzippedData]) { return self; }

    z_stream stream;
    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    stream.avail_in = (uint)self.length;
    stream.next_in = (Bytef *)self.bytes;
    stream.total_out = 0;
    stream.avail_out = 0;

    NSMutableData *output = nil;
    if (inflateInit2(&stream, 47) == Z_OK) {
        int status = Z_OK;
        output = [NSMutableData dataWithCapacity:self.length * 2];
        while (status == Z_OK) {
            if (stream.total_out >= output.length) {
                output.length += self.length / 2;
            }
            stream.next_out = (uint8_t *)output.mutableBytes + stream.total_out;
            stream.avail_out = (uInt)(output.length - stream.total_out);
            status = inflate (&stream, Z_SYNC_FLUSH);
        }
        if (inflateEnd(&stream) == Z_OK) {
            if (status == Z_STREAM_END) {
                output.length = stream.total_out;
            }
        }
    }

    return output;
}



- (nullable NSData *)jx_zlibbedDataWithCompressionLevel:(float)level
{
    if (self.length == 0 || [self jx_isZlibbedData]) { return self; }

    z_stream strm;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)[self length];

    static const NSUInteger ChunkSize = 16384;
    // Compresssion Levels:
    //   Z_NO_COMPRESSION         0
    //   Z_BEST_SPEED             1
    //   Z_BEST_COMPRESSION       9
    //   Z_DEFAULT_COMPRESSION    -1
    int compression = (level < 0.0f)? Z_DEFAULT_COMPRESSION: (int)(roundf(level * 9));

    if (deflateInit(&strm, compression) != Z_OK) return nil;

    // 16K chuncks for expansion
    NSMutableData *compressed = [NSMutableData dataWithLength:ChunkSize];

    do {
        if (strm.total_out >= [compressed length])
            [compressed increaseLengthBy:ChunkSize];

        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);

        deflate(&strm, Z_FINISH);
    }
    while (strm.avail_out == 0);

    deflateEnd(&strm);

    [compressed setLength:strm.total_out];
    return [NSData dataWithData:compressed];
}

- (nullable NSData *)jx_zlibbedDefault
{
    return [self jx_zlibbedDataWithCompressionLevel:-1.0f];
}

- (nullable NSData *)jx_unzlibbedData
{
    if (self.length == 0 || ![self jx_isZlibbedData]) {
        return self;
    }
    NSUInteger full_length = [self length];
    NSUInteger half_length = [self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData
                                   dataWithLength:full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)full_length;
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit(&strm) != Z_OK) return nil;
    
    while (!done) {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length])
            [decompressed increaseLengthBy:half_length];
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        
        // Inflate another chunk.
        status = inflate(&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) done = YES;
        else if (status != Z_OK) break;
    }
    if (inflateEnd(&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done) {
        [decompressed setLength:strm.total_out];
        return [NSData dataWithData:decompressed];
    } else return nil;
}

-(NSString *)jx_convertedToUtf8String
{
    NSString *string = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    if (string == nil) {
        string = [[NSString alloc] initWithData:[self UTF8Data] encoding:NSUTF8StringEncoding];
    }
    return string;
    
}

+ (nullable NSData *)jx_mainBundleDataNamed:(NSString *)name type:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (!path) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

#pragma mark - private
-(NSData *)UTF8Data
{
    NSMutableData *resData = [[NSMutableData alloc] initWithCapacity:self.length];
    NSData *replacement = [@"�" dataUsingEncoding:NSUTF8StringEncoding];
    
    uint64_t index = 0;
    const uint8_t *bytes = self.bytes;
    
    long dataLength = (long) self.length;
    
    while (index < dataLength) {
        uint8_t len = 0;
        uint8_t firstChar = bytes[index];

        
        if ((firstChar & 0x80) == 0 && (firstChar == 0x09 || firstChar == 0x0A || firstChar == 0x0D || (0x20 <= firstChar && firstChar <= 0x7E))) { // 1个字节
            len = 1;
        }else if ((firstChar & 0xE0) == 0xC0 && (0xC2 <= firstChar && firstChar <= 0xDF)) { // 2个字节
            if (index + 1 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                if (0x80 <= secondChar && secondChar <= 0xBF) {
                    len = 2;
                }
            }
        }else if ((firstChar & 0xF0) == 0xE0) { // 3个字节
            if (index + 2 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                uint8_t thirdChar = bytes[index + 2];
                
                if (firstChar == 0xE0 && (0xA0 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                } else if (((0xE1 <= firstChar && firstChar <= 0xEC) || firstChar == 0xEE || firstChar == 0xEF) && (0x80 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                } else if (firstChar == 0xED && (0x80 <= secondChar && secondChar <= 0x9F) && (0x80 <= thirdChar && thirdChar <= 0xBF)) {
                    len = 3;
                }
            }
        } else if ((firstChar & 0xF8) == 0xF0) { // 4个字节
            if (index + 3 < dataLength) {
                uint8_t secondChar = bytes[index + 1];
                uint8_t thirdChar = bytes[index + 2];
                uint8_t fourthChar = bytes[index + 3];
                
                if (firstChar == 0xF0) {
                    if ((0x90 <= secondChar & secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                } else if ((0xF1 <= firstChar && firstChar <= 0xF3)) {
                    if ((0x80 <= secondChar && secondChar <= 0xBF) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                } else if (firstChar == 0xF3) {
                    if ((0x80 <= secondChar && secondChar <= 0x8F) && (0x80 <= thirdChar && thirdChar <= 0xBF) && (0x80 <= fourthChar && fourthChar <= 0xBF)) {
                        len = 4;
                    }
                }
            }
        } else if ((firstChar & 0xFC) == 0xF8) { // 5个字节
            len = 0;
        } else if ((firstChar & 0xFE) == 0xFC) { // 6个字节
            len = 0;
        }
        
        if (len == 0) {
            index++;
            [resData appendData:replacement];
        } else {
            [resData appendBytes:bytes + index length:len];
            index += len;
        }
    }
    
    return resData;
}

@end
