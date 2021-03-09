//
//  NSNotificationCenter+JXGeneral.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/17.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNotificationCenter (JXGeneral)

/// 在主线程上将通知发送给接收者。
/// @param notification 定义通知
/// @param wait 指定是否阻塞当前线程直到指定选择器在主线程中执行完毕。选择YES会阻塞这个线程；选择NO，本方法会立刻返回。
+ (void)jx_postNotificationOnMainThread:(NSNotification *)notification waitUntilDone:(BOOL)wait;

/// 在主线程上向接收者发送给定的通知。如果当前线程是主线程，则通知被同步发送；否则，被异步发送。
+ (void)jx_postNotificationOnMainThread:(NSNotification *)notification;

/// 创建具有给定名称和发送方的通知，并将其发布到主线程上的接收方。 如果当前线程是主线程，则通知被同步发布； 否则，将被异步发布。
+ (void)jx_postNotificationOnMainThreadWithName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo waitUntilDone:(BOOL)wait;

/// 创建具有给定名称和发送方的通知，并将其发布到主线程上的接收方。 如果当前线程是主线程，则通知被同步发布； 否则，将被异步发布。
+ (void)jx_postNotificationOnMainThreadWithName:(NSString *)name object:(nullable id)object userInfo:(nullable NSDictionary *)userInfo;

/// 创建具有给定名称和发送方的通知，并将其发布到主线程上的接收方。 如果当前线程是主线程，则通知被同步发布； 否则，将被异步发布。
+ (void)jx_postNotificationOnMainThreadWithName:(NSString *)name object:(nullable id)object;

@end

NS_ASSUME_NONNULL_END
