//
//  UIViewController+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/24.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIViewController+JXGeneral.h"

@implementation UIViewController (JXGeneral)

- (void)jx_setNavigationBarTitleColor:(nullable UIColor *)color font:(nullable UIFont *)font
{
    if (self.navigationController == nil) {
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (color != nil) {
        [dic setValue:color forKey:NSForegroundColorAttributeName];
    }
    if (font != nil) {
        [dic setValue:font forKey:NSFontAttributeName];
    }
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

- (void)jx_setStatusBarBackgroundColor:(UIColor *)color
{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

/**
 返回按钮点击
 */
- (void)jx_clickReturnBarButtonItemAction:(UIButton *)sender
{
    if (self.navigationController == nil) {
        return;
    }
    if (self.navigationController.viewControllers.count != 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}
/**
 隐藏返回按钮
 */
- (void)jx_hiddenLeftBarButtonItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:0 target:nil action:nil];
}

@end
