//
//  UIButton+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (JXGeneral)

/// 为按钮添加点击间隔 单位：秒
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;
/// 扩展点击区域，默认为（0，0，0，0)负为扩大
@property (nonatomic, assign) UIEdgeInsets hitEdgeInsets;

/// 内部hook了sendAction方法，但是引出了sendAction方法，可以通过在基类或者子类实现方法，以及是否执行hook方法
- (void)jx_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;

@end

NS_ASSUME_NONNULL_END
