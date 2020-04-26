//
//  NSArray+JXGeneral.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/13.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSArray+JXGeneral.h"

@implementation NSArray (JXGeneral)

- (NSArray *)jx_sortNSIndexArray
{
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"section" ascending:YES];
    NSSortDescriptor *sorter1 = [[NSSortDescriptor alloc] initWithKey:@"row" ascending:YES];
    NSArray *arr = [self sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sorter,sorter1,nil]];
    return arr;
}

+ (NSArray *)jx_arrayWithPlistData:(NSData *)plist
{
    if (!plist) return nil;
    NSArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:NULL error:NULL];
    if ([array isKindOfClass:[NSArray class]]) return array;
    return nil;
}

+ (NSArray *)jx_arrayWithPlistString:(NSString *)plist
{
    if (!plist) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self jx_arrayWithPlistData:data];
}

- (NSData *)jx_plistData
{
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:NULL];
}

- (NSString *)jx_plistString
{
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
    NSString *xmlString = nil;
    if (xmlData) {
        xmlString = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding];
    }
    return xmlString;
}

- (id)jx_randomObject
{
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

- (NSString *)jx_jsonStringEncoded
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

- (NSString *)jx_jsonPrettyStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

@end
