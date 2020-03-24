//
//  NSMutableArray+JXSafe.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/3/24.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSMutableArray+JXSafe.h"

@implementation NSMutableArray (JXSafe)

- (void)jx_addObject:(id)anObject withKey:(NSString *)key
{
    if (self.count < 1) {
        [self addObject:anObject];
    } else {
        if ([anObject isKindOfClass:[NSDictionary class]]) {
            if (key.length > 0) {
                BOOL has = NO;
                for (NSDictionary *dic in self) {
                    NSString *pk = dic[key];
                    if ([pk isEqualToString:((NSDictionary *)anObject)[key]]) {
                        has = YES;
                        break;
                    }
                }
                if (!has) {
                    [self addObject:anObject];
                }
                
            } else {
                [self addObject:anObject];
            }
        } else if ([anObject isKindOfClass:[NSString class]] || [anObject isKindOfClass:[NSNumber class]]) {
            if (![self containsObject:anObject]) {
                [self addObject:anObject];
            }
        } else {
            if (key.length > 0) {
                BOOL has = NO;
                for (NSObject *obj in self) {
                    NSString *pk = [obj valueForKey:key];
                    if ([pk isEqualToString:[anObject valueForKey:key]]) {
                        has = YES;
                        break;
                    }
                }
                if (!has) {
                    [self addObject:anObject];
                }
                
            } else {
                [self addObject:anObject];
            }
        }
    }
}

@end
