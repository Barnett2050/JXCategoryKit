//
//  UIViewController+JXAlert.m
//  CustomCategory
//
//  Created by Barnett on 2019/10/13.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIViewController+JXAlert.h"

@implementation UIViewController (JXAlert)

#pragma mark - public
- (void)jx_showAlertControllerWithTitle:(nullable id)title message:(nullable id)message buttonTitles:(NSArray *)btnTitleArr buttonColors:(nullable NSArray *)btnColorArr  alertClick:(JXAlertClickIndexBlock)clickBlock
{
    // 判断是否为空，避免return
    if (title == nil) {
        title = @"";
    }
    if (message == nil) {
        message = @"";
    }
    // 判断 title 和 message 类型
    NSString *string = @"";
    NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:string];
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:string];
    NSMutableAttributedString *attributeMutableStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSArray *strClassArr = @[
        NSStringFromClass(string.class),
        NSStringFromClass(mutableStr.class)];
    NSArray *atrStrClassArr = @[
        NSStringFromClass(attributeStr.class),
        NSStringFromClass(attributeMutableStr.class)];
    
    NSArray *classArr = @[
        NSStringFromClass(string.class),
        NSStringFromClass(mutableStr.class),
        NSStringFromClass(attributeStr.class),
        NSStringFromClass(attributeMutableStr.class)];
    
    if (![classArr containsObject:NSStringFromClass([title class])] ||
        ![classArr containsObject:NSStringFromClass([message class])]) {
        NSLog(@"传入title或者message类型不对");
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        // title根据类型赋值
        if ([strClassArr containsObject:NSStringFromClass([title class])]) {
            alertController.title = title;
        }else if ([atrStrClassArr containsObject:NSStringFromClass([title class])])
        {
            [alertController setValue:title forKey:@"attributedTitle"];
        }
        // message根据类型赋值
        if ([strClassArr containsObject:NSStringFromClass([message class])]) {
            alertController.message = message;
        }else if ([atrStrClassArr containsObject:NSStringFromClass([message class])])
        {
            [alertController setValue:message forKey:@"attributedMessage"];
        }
        
        // 按钮颜色处理
        NSArray *colors;
        if (btnColorArr.count == 0 || btnColorArr.count != btnTitleArr.count) {
            if (btnColorArr.count == 1) {
                colors = btnColorArr;
            }else
            {
                colors = nil;
            }
        }else
        {
            colors = btnColorArr;
        }
        
        for (int i = 0; i < btnTitleArr.count; i++) {
            NSString *title = btnTitleArr[i];
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (clickBlock) {
                    NSInteger index = [btnTitleArr indexOfObject:action.title];
                    clickBlock(index);
                }
            }];
            if (colors.count != 0) {
                if (colors.count == 1) {
                    [action setValue:[colors firstObject] forKey:@"_titleTextColor"];
                }else
                {
                    [action setValue:colors[i] forKey:@"_titleTextColor"];
                }
            }
            [alertController addAction:action];
        }
        [self presentViewController:alertController animated:YES completion:nil];
    });
}
- (void)jx_showAlertControllerWithTitle:(nullable id)title message:(nullable id)message buttonTitles:(NSArray *)btnTitleArr alertClick:(JXAlertClickIndexBlock)clickBlock
{
    [self jx_showAlertControllerWithTitle:title message:message buttonTitles:btnTitleArr buttonColors:nil alertClick:clickBlock];
}

- (void)jx_showAlertControllerWithTitle:(nullable id)title message:(nullable id)message alertClick:(JXAlertClickIndexBlock)clickBlock
{
    [self jx_showAlertControllerWithTitle:title message:message buttonTitles:@[@"取消",@"确定"] buttonColors:nil alertClick:clickBlock];
}

#pragma mark - Alert Sheet
- (void)jx_showAlertSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitles:(NSArray *)btnTitleArr buttonColors:(nullable NSArray *)btnColorArr  alertClick:(JXAlertClickIndexBlock)clickBlock alertCancle:(JXAlertCancleBlock)cancleBlock
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        
        if (cancleBlock) {
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                cancleBlock();
            }];
            [alertController addAction:cancleAction];
        }
        
        NSArray *colors;
        if (btnColorArr.count == 0 || btnColorArr.count != btnTitleArr.count) {
            if (btnColorArr.count == 1) {
                colors = btnColorArr;
            }else
            {
                colors = nil;
            }
        }else
        {
            colors = btnColorArr;
        }
        
        for (int i = 0; i < btnTitleArr.count; i++) {
            NSString *title = btnTitleArr[i];
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (clickBlock) {
                    NSInteger index = [btnTitleArr indexOfObject:action.title];
                    clickBlock(index);
                }
            }];
            if (colors.count != 0) {
                if (colors.count == 1) {
                    [action setValue:[colors firstObject] forKey:@"_titleTextColor"];
                }else
                {
                    [action setValue:colors[i] forKey:@"_titleTextColor"];
                }
            }
            [alertController addAction:action];
        }
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

- (void)jx_showAlertSheetWithTitle:(nullable NSString *)title buttonTitles:(NSArray *)btnTitleArr buttonColors:(nullable NSArray *)btnColorArr  alertClick:(JXAlertClickIndexBlock)clickBlock alertCancle:(JXAlertCancleBlock)cancleBlock
{
    [self jx_showAlertSheetWithTitle:nil message:title buttonTitles:btnTitleArr buttonColors:btnColorArr alertClick:clickBlock alertCancle:cancleBlock];
}

- (void)jx_showAlertSheetWithTitle:(nullable NSString *)title buttonTitles:(NSArray *)btnTitleArr alertClick:(JXAlertClickIndexBlock)clickBlock alertCancle:(JXAlertCancleBlock)cancleBlock
{
    [self jx_showAlertSheetWithTitle:nil message:title buttonTitles:btnTitleArr buttonColors:nil alertClick:clickBlock alertCancle:cancleBlock];
}

- (void)jx_showAlertSheetWithButtonTitles:(NSArray *)btnTitleArr buttonColors:(nullable NSArray *)btnColorArr  alertClick:(JXAlertClickIndexBlock)clickBlock alertCancle:(JXAlertCancleBlock)cancleBlock
{
    [self jx_showAlertSheetWithTitle:nil message:nil buttonTitles:btnTitleArr buttonColors:btnColorArr alertClick:clickBlock alertCancle:cancleBlock];
}

- (void)jx_showAlertSheetWithButtonTitles:(NSArray *)btnTitleArr   alertClick:(JXAlertClickIndexBlock)clickBlock alertCancle:(JXAlertCancleBlock)cancleBlock
{
    [self jx_showAlertSheetWithTitle:nil message:nil buttonTitles:btnTitleArr buttonColors:nil alertClick:clickBlock alertCancle:cancleBlock];
}


@end
