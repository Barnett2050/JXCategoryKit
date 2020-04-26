//
//  UIScrollView+JXGeneral.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/22.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "UIScrollView+JXGeneral.h"

@implementation UIScrollView (JXGeneral)

- (void)jx_scrollToTop {
    [self jx_scrollToTopAnimated:YES];
}

- (void)jx_scrollToBottom {
    [self jx_scrollToBottomAnimated:YES];
}

- (void)jx_scrollToLeft {
    [self jx_scrollToLeftAnimated:YES];
}

- (void)jx_scrollToRight {
    [self jx_scrollToRightAnimated:YES];
}

- (void)jx_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)jx_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)jx_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)jx_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
