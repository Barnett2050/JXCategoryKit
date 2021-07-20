//
//  UITabBarController+JXAnimation.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UITabBarController+JXAnimation.h"

static const int TABBAR_HEIGHT = 49;

@implementation UITabBarController (JXAnimation)

- (void)jx_setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
    
    if ([self.view.subviews count] < 2) {
        return;
    }
    
    if(hidden) {
        if(animated) {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                                                self.view.bounds.size.height,
                                                                self.view.bounds.size.width,
                                                                TABBAR_HEIGHT);
                             }
                             completion:^(BOOL finished) {
                                 self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                                                self.view.bounds.size.height,
                                                                self.view.bounds.size.width,
                                                                TABBAR_HEIGHT);
                             }];
        } else {
            
            self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.size.height,
                                           self.view.bounds.size.width,
                                           TABBAR_HEIGHT);
        }
    } else {
        if(animated) {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                                                self.view.bounds.size.height - TABBAR_HEIGHT,
                                                                self.view.bounds.size.width,
                                                                TABBAR_HEIGHT);
                             }   completion:^(BOOL finished) {
                                 
                             }];
        } else {
            
            self.tabBar.frame = CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.size.height - TABBAR_HEIGHT,
                                           self.view.bounds.size.width,
                                           TABBAR_HEIGHT);
        }
    }
}


@end
