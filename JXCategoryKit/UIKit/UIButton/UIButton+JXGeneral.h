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

/// 扩展点击区域，默认为（0，0，0，0)负为扩大
@property (nonatomic, assign) UIEdgeInsets hitEdgeInsets;

/// 为按钮添加点击间隔 单位：秒
/// @param interval 时间间隔
/// @param sendActionBlock 内部hook了sendAction方法，但是引出了sendAction方法
- (void)setEventTimeIntervalWith:(NSTimeInterval)interval sendActionBlock:(void(^)(SEL action,id target, UIEvent *event))sendActionBlock;

@end

NS_ASSUME_NONNULL_END
