//
//  UITableViewCell+JXAnimation.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UITableViewCell+JXAnimation.h"

@implementation UITableViewCell (JXAnimation)

- (void)jx_showScaleAnimation
{
    CATransform3D transform = CATransform3DMakeScale(0.68, 0.68, 1.0);
    self.layer.transform = transform;
    // 不透明度
    self.layer.opacity = 0;
    [UIView beginAnimations:@"s" context:nil];
    [UIView setAnimationDuration:0.5];
    self.layer.transform = CATransform3DIdentity;
    self.layer.opacity = 1;
    [UIView commitAnimations];
    
}

- (void)jx_showIndentAnimationWithCell
{
    CGRect originalRect = self.frame;
    CGRect newRect = self.frame;
    newRect.origin.x = CGRectGetWidth([UIScreen mainScreen].bounds);
    self.frame = newRect;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = originalRect;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)jx_showRoatationAnimation
{
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( M_PI/6, 0.0, 0.5, 0.4);
    rotation.m34 = 1.0/ -600;
    
    self.layer.shadowColor = [[UIColor blackColor]CGColor];
    self.layer.shadowOffset = CGSizeMake(10, 10);
    self.alpha = 0;
    self.layer.transform = rotation;
    
    [UIView beginAnimations:@"rotation" context:nil];
    [UIView setAnimationDuration:0.5];
    self.layer.transform = CATransform3DIdentity;
    self.alpha = 1;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

@end
