//
//  UIScrollView+JXGeneral.h
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/22.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (JXGeneral)

/// 滚动到顶部，默认使用动画效果
- (void)jx_scrollToTop;
/// 滚动到底部，默认使用动画效果
- (void)jx_scrollToBottom;
/// 滚动到左顶，默认使用动画效果
- (void)jx_scrollToLeft;
/// 滚动到右顶，默认使用动画效果
- (void)jx_scrollToRight;

/// 滚动到顶部
/// @param animated 使用动画效果
- (void)jx_scrollToTopAnimated:(BOOL)animated;
/// 滚动到底部
/// @param animated 使用动画效果
- (void)jx_scrollToBottomAnimated:(BOOL)animated;
/// 滚动到左
/// @param animated 使用动画效果
- (void)jx_scrollToLeftAnimated:(BOOL)animated;
/// 滚动到右
/// @param animated 使用动画效果
- (void)jx_scrollToRightAnimated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
