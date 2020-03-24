//
//  UITableViewCell+JXAnimation.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (JXAnimation)

/**
 显示缩放效果
 */
- (void)jx_showScaleAnimation;
/**
 显示缩进效果
 */
- (void)jx_showIndentAnimationWithCell;
/**
 显示旋转效果
 */
- (void)jx_showRoatationAnimation;

@end

NS_ASSUME_NONNULL_END
