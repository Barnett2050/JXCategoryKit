//
//  UITextField+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UITextField+JXGeneral.h"

@implementation UITextField (JXGeneral)

- (BOOL)jx_isTextPosition
{
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    BOOL flag = position != nil;
    return flag;
}

@end
