//
//  CALayer+JXAnimation.m
//  CustomCategory
//
//  Created by Barnett on 2020/3/23.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "CALayer+JXAnimation.h"

@implementation CALayer (JXAnimation)

- (void)jx_shakeAnimation
{
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat s = 5;
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    //时长
    kfa.duration = 0.3f;
    //重复
    kfa.repeatCount = 2;
    //移除
    kfa.removedOnCompletion = YES;
    [self addAnimation:kfa forKey:@"shake"];
}

@end
