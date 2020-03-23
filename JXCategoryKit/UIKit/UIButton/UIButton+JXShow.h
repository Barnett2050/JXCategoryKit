//
//  UIButton+JXShow.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JXImagePosition) {
    JXImageLeftTextRightPosition = 0,              //图片在左，文字在右，默认
    JXImageRightTextLeftPosition = 1,             //图片在右，文字在左
    JXImageTopTextBottomPosition = 2,               //图片在上，文字在下
    JXImageBottomTextTopPosition = 3,            //图片在下，文字在上
};

@interface UIButton (JXShow)

/**
 设置自定义图片文字位置按钮

 @param postion 位置
 @param spacing 图片和文字间隙
 */
- (void)jx_setImagePosition:(JXImagePosition)postion spacing:(CGFloat)spacing;

/**
 开始加载菊花动画

 @param transform 菊花比例
 @param color 菊花颜色
 @param isHideTitle 是否隐藏标题
 */
- (void)jx_startAnimationWithTransform:(CGFloat)transform color:(UIColor *)color isHideTitle:(BOOL)isHideTitle;
/**
 停止动画

 @param isShowTitle 是否显示按钮名称
 */
- (void)jx_stopAnimationAndShowTitle:(BOOL)isShowTitle;

@end

NS_ASSUME_NONNULL_END
