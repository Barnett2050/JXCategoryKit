//
//  UITableViewCell+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UITableViewCell+JXGeneral.h"

@implementation UITableViewCell (JXGeneral)

/**
 分割线左边距,右边距
 */
- (void)jx_setCellBottomLineLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace
{
    self.layoutMargins = UIEdgeInsetsMake(0, leftSpace, 0, rightSpace);
    self.separatorInset = UIEdgeInsetsMake(0, leftSpace, 0, rightSpace);
}

- (void)jx_setCellBottomLineLeftSpace:(CGFloat)leftSpace
{
    [self jx_setCellBottomLineLeftSpace:leftSpace rightSpace:0];
}

- (void)jx_setCellBottomLineZeroSpace
{
    [self jx_setCellBottomLineLeftSpace:0 rightSpace:0];
}

/// 隐藏分割线
- (void)hiddenCellBottomLine
{
    self.layoutMargins = UIEdgeInsetsMake(0, CGRectGetWidth([UIScreen mainScreen].bounds), 0, 0);
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth([UIScreen mainScreen].bounds), 0, 0);
}

@end
