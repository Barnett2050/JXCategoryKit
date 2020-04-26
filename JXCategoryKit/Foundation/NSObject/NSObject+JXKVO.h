//
//  NSObject+JXKVO.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/17.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JXKVO)

/// 添加一个kvo的block
- (void)jx_addObserverBlockForKeyPath:(NSString*)keyPath
                             block:(void (^)(id _Nonnull obj, id _Nonnull oldVal, id _Nonnull newVal))block;
/// 根据给定的keyPath移除相应的观察者
- (void)jx_removeObserverBlocksForKeyPath:(NSString*)keyPath;

/// 释放所有的观察者
- (void)jx_removeObserverBlocks;


@end

NS_ASSUME_NONNULL_END
