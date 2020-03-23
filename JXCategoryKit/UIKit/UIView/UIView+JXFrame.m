//
//  UIView+JXFrame.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIView+JXFrame.h"

@implementation UIView (JXFrame)

- (void)setJx_x:(CGFloat)jx_x
{
    CGRect frame = self.frame;
    frame.origin.x = jx_x;
    self.frame = frame;
}

- (void)setJx_y:(CGFloat)jx_y
{
    CGRect frame = self.frame;
    frame.origin.y = jx_y;
    self.frame = frame;
}

- (CGFloat)jx_x
{
    return self.frame.origin.x;
}

- (CGFloat)jx_y
{
    return self.frame.origin.y;
}

- (void)setJx_centerX:(CGFloat)jx_centerX
{
    CGPoint center = self.center;
    center.x = jx_centerX;
    self.center = center;
}

- (void)setJx_centerY:(CGFloat)jx_centerY
{
    CGPoint center = self.center;
    center.y = jx_centerY;
    self.center = center;
}

- (CGFloat)jx_centerX
{
    return self.center.x;
}

- (CGFloat)jx_centerY
{
    return self.center.y;
}

- (void)setJx_width:(CGFloat)jx_width
{
    CGRect frame = self.frame;
    frame.size.width = jx_width;
    self.frame = frame;
}

- (void)setJx_height:(CGFloat)jx_height
{
    CGRect frame = self.frame;
    frame.size.height = jx_height;
    self.frame = frame;
}

- (CGFloat)jx_width
{
    return self.frame.size.width;
}

- (CGFloat)jx_height
{
    return self.frame.size.height;
}

- (void)setJx_size:(CGSize)jx_size
{
    CGRect frame = self.frame;
    frame.size = jx_size;
    self.frame = frame;
}

- (void)setJx_origin:(CGPoint)jx_origin
{
    CGRect frame = self.frame;
    frame.origin = jx_origin;
    self.frame = frame;
}

- (CGSize)jx_size
{
    return self.frame.size;
}

- (CGPoint)jx_origin
{
    return self.frame.origin;
}


- (CGFloat)jx_maxX
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)jx_maxY
{
    return self.frame.origin.y + self.frame.size.height;
}


/**
 水平居中
 只适用于frame布局
 */
- (void)jx_alignHorizontal
{
    self.jx_x = (self.superview.jx_width - self.jx_width) * 0.5;
}

/**
 垂直居中
 只适用于frame布局
 */
- (void)jx_alignVertical
{
    self.jx_y = (self.superview.jx_height - self.jx_height) * 0.5;
}

@end
