//
//  UIButton+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/14.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "UIButton+JXGeneral.h"
#import <objc/runtime.h>

@interface UIButton ()

/** bool true 忽略点击事件   false 允许点击事件 */
@property (nonatomic, assign) BOOL isIgnoreEvent;

@end

@implementation UIButton (JXGeneral)

// runtime 动态绑定 属性
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent
{
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, @selector(isIgnoreEvent)) boolValue];
}

- (NSTimeInterval)eventTimeInterval
{
    return [objc_getAssociatedObject(self, @selector(eventTimeInterval)) doubleValue];
}

- (void)setEventTimeInterval:(NSTimeInterval)eventTimeInterval
{
    objc_setAssociatedObject(self, @selector(eventTimeInterval), @(eventTimeInterval), OBJC_ASSOCIATION_ASSIGN);
}


+ (void)load
{
    Class cls = object_getClass(self);
    SEL oriSel = @selector(sendAction:to:forEvent:);
    SEL swiSel = @selector(wxd_sendAction:to:forEvent:);
    Method originClassMethod = class_getClassMethod(cls, oriSel);
    Method swizzleClassMethod = class_getClassMethod(cls, swiSel);
    BOOL didAddMethod = class_addMethod(cls, oriSel, method_getImplementation(swizzleClassMethod), method_getTypeEncoding(swizzleClassMethod));

    if (didAddMethod) {
        class_replaceMethod(cls, oriSel, method_getImplementation(originClassMethod), method_getTypeEncoding(originClassMethod));
    } else {
        method_exchangeImplementations(originClassMethod, swizzleClassMethod);
    }
}

- (void)wxd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.eventTimeInterval == 0) {
        [self wxd_sendAction:action to:target forEvent:event];
    }else
    {
        if (self.isIgnoreEvent){
            return;
        }else if (self.eventTimeInterval > 0){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.eventTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self setIsIgnoreEvent:false];
            });
        }
        self.isIgnoreEvent = true;
        // 实现自定义方法
        [self jx_sendAction:action to:target forEvent:event];
        // 这里看上去会陷入递归调用死循环，但在运行期此方法是和sendAction:to:forEvent:互换的，相当于执行sendAction:to:forEvent:方法，所以并不会陷入死循环。
        [self wxd_sendAction:action to:target forEvent:event];
    }
}

- (void)jx_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    
}
@end
