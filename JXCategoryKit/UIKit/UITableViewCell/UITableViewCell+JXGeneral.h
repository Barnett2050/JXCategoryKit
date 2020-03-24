//
//  UITableViewCell+JXGeneral.h
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (JXGeneral)

/**
 设置分割线左边距,右边距
 */
- (void)jx_setCellBottomLineLeftSpace:(CGFloat)leftSpace rightSpace:(CGFloat)rightSpace;
/**
 设置分割线左边距
 */
- (void)jx_setCellBottomLineLeftSpace:(CGFloat)leftSpace;
/// 设置左右边距为0
- (void)jx_setCellBottomLineZeroSpace;

@end

NS_ASSUME_NONNULL_END
