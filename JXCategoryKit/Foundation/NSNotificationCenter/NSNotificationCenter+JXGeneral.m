//
//  NSNotificationCenter+JXGeneral.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/17.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSNotificationCenter+JXGeneral.h"
#include <pthread.h>

@implementation NSNotificationCenter (JXGeneral)

- (void)jx_postNotificationOnMainThread:(NSNotification *)notification
{
    if (pthread_main_np()) return [self postNotification:notification];
    [self jx_postNotificationOnMainThread:notification waitUntilDone:NO];
}

- (void)jx_postNotificationOnMainThread:(NSNotification *)notification waitUntilDone:(BOOL)wait
{
    if (pthread_main_np()) return [self postNotification:notification];
    [[self class] performSelectorOnMainThread:@selector(p_postNotification:) withObject:notification waitUntilDone:wait];
}

- (void)jx_postNotificationOnMainThreadWithName:(NSString *)name object:(id)object
{
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:nil];
    [self jx_postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
}

- (void)jx_postNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo
{
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    [self jx_postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
}

- (void)jx_postNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo waitUntilDone:(BOOL)wait
{
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if (name) [info setObject:name forKey:@"name"];
    if (object) [info setObject:object forKey:@"object"];
    if (userInfo) [info setObject:userInfo forKey:@"userInfo"];
    [[self class] performSelectorOnMainThread:@selector(p_postNotificationName:) withObject:info waitUntilDone:wait];
}

#pragma mark - private
+ (void)p_postNotification:(NSNotification *)notification {
    [[self defaultCenter] postNotification:notification];
}

+ (void)p_postNotificationName:(NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    
    [[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

@end
