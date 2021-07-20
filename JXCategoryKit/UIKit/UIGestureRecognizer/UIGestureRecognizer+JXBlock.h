//
//  UIGestureRecognizer+JXBlock.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/21.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIGestureRecognizer (JXBlock)

/// block初始化手势
- (instancetype)initWithActionBlock:(void (^)(id sender))block;

/// block添加手势回调
- (void)addActionBlock:(void (^)(id sender))block;

/// 移除所有的手势block
- (void)removeAllActionBlocks;

@end

NS_ASSUME_NONNULL_END
