//
//  UIView+JXFrame.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JXFrame)

@property (nonatomic, assign) CGFloat jx_x;
@property (nonatomic, assign) CGFloat jx_y;

@property (nonatomic, assign) CGFloat jx_width;
@property (nonatomic, assign) CGFloat jx_height;

@property (nonatomic, assign) CGFloat jx_centerX;
@property (nonatomic, assign) CGFloat jx_centerY;

@property (nonatomic, assign) CGSize jx_size;
@property (nonatomic, assign) CGPoint jx_origin;

@property (nonatomic, assign, readonly) CGFloat jx_maxX;
@property (nonatomic, assign, readonly) CGFloat jx_maxY;

/**
 水平居中
 只适用于frame布局
 */
- (void)jx_alignHorizontal;

/**
 垂直布局
 只适用于frame布局
 */
- (void)jx_alignVertical;

@end

NS_ASSUME_NONNULL_END
