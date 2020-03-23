//
//  CALayer+JXAnimation.h
//  CustomCategory
//
//  Created by Barnett on 2020/3/23.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (JXAnimation)

/// 摇动动画
- (void)jx_shakeAnimation;

@end

NS_ASSUME_NONNULL_END
