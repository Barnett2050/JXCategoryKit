//
//  UIView+JXGesture.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JXGesture)

/**
 添加Tap手势
 
 @param target target description
 @param action 方法名
 */
- (void)jx_addTapGestureRecognizerWithTarget:(id)target action:(SEL)action;


/**
 添加Pan手势
 
 @param target target description
 @param action 方法名
 */
- (void)jx_addPanGestureRecognizerWithTarget:(id)target action:(SEL)action;


/**
 添加LongPress手势
 
 @param target target description
 @param action 方法名
 */
- (void)jx_addLongPressGestureRecognizerWithTarget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
