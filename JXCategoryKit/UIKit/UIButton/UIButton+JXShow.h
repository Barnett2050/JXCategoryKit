//
//  UIButton+JXShow.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JXButtonShowStyle) {
    JXButtonShowStyleNormal = 0,              //默认无效果
    JXButtonShowStyleImageLeftTextRight,             //图片在左，文字在右
    JXButtonShowStyleImageRightTextLeft,             //图片在右，文字在左
    JXButtonShowStyleImageTopTextBottom,             //图片在上，文字在下
    JXButtonShowStyleImageBottomTextTop              //图片在下，文字在上
};

@interface UIButton (JXShow)

/// 样式
@property (nonatomic, assign, readonly) JXButtonShowStyle buttonShowStyle;

/// 设置自定义图片文字位置按钮
/// @param style 样式
/// @param spacing 图片和文字间隙
- (void)jx_setButtonStyle:(JXButtonShowStyle)style spacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
