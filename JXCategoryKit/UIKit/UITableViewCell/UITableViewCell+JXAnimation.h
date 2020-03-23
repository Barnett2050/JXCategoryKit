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
 缩放效果
 */
- (void)jx_showScaleAnimation;
/**
 缩进效果
 */
- (void)jx_showIndentAnimationWithCell;
/**
 旋转效果
 */
- (void)jx_showRoatationAnimation;

@end

NS_ASSUME_NONNULL_END
