//
//  NSMutableDictionary+JXSafe.m
//  CustomCategory
//
//  Created by edz on 2019/10/10.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSMutableDictionary+JXSafe.h"
#import "NSObject+JXRuntime.h"
#import <objc/runtime.h>

static const char *NSDictionaryM = "__NSDictionaryM";

@implementation NSMutableDictionary (JXSafe)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [objc_getClass(NSDictionaryM) jx_swizzleClassInstanceMethodWithOriginSel:@selector(setObject:forKey:) swizzleSel:@selector(dictionaryM_setObject:forKey:)];
    });
}

- (void)dictionaryM_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject != nil) {
        [self dictionaryM_setObject:anObject forKey:aKey];
    }
}

@end
