//
//  NSObject+General.m
//  JXCategoryKit
//
//  Created by Barnett on 2021/4/1.
//  Copyright © 2021 Barnett. All rights reserved.
//

#import "NSObject+General.h"

@implementation NSObject (General)

- (NSString *)jx_jsonStringEncoded
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

- (NSData *)jx_plistData
{
    if ([self isKindOfClass:NSArray.class] || [self isKindOfClass:NSDictionary.class]) {
        NSError *error;
        NSData *data = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:&error];
        return data;
    }
    return nil;
}

+ (void)jx_convertWithPlistData:(NSData *)plistData resultBlock:(void(^)(NSDictionary *plistDictionary,NSArray *plistArray))resultBlock
{
    if (!plistData) {
        resultBlock(nil,nil);
        return;
    }
    NSError *error;
    id value = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:NULL error:&error];
    
    if ([value isKindOfClass:[NSArray class]]) {
        resultBlock(nil,value);
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        resultBlock(value,nil);
    } else {
        resultBlock(nil,nil);
    }
}

@end
