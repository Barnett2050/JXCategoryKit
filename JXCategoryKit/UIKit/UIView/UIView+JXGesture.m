//
//  UIView+JXGesture.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIView+JXGesture.h"

@implementation UIView (JXGesture)

// 添加Tap手势
- (void)jx_addTapGestureRecognizerWithTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

// 添加Pan手势
- (void)jx_addPanGestureRecognizerWithTarget:(id)target action:(SEL)action {
    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc]initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

// 添加LongPress手势
- (void)jx_addLongPressGestureRecognizerWithTarget:(id)target action:(SEL)action {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:longPress];
}

@end
