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
/// 为按钮添加点击间隔 单位：秒
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;
/// bool true 忽略点击事件   false 允许点击事件
@property (nonatomic, assign) BOOL ignoreEventTimeInterval;
/// sendAction 回调
@property (nonatomic, copy) void (^sendActionBlock)(SEL action,id target, UIEvent *event);

@end

@implementation UIButton (JXGeneral)

- (void)setIgnoreEventTimeInterval:(BOOL)ignoreEventTimeInterval
{
    objc_setAssociatedObject(self, @selector(ignoreEventTimeInterval), @(ignoreEventTimeInterval), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)ignoreEventTimeInterval
{
    return [objc_getAssociatedObject(self, @selector(ignoreEventTimeInterval)) boolValue];
}

- (NSTimeInterval)eventTimeInterval
{
    return [objc_getAssociatedObject(self, @selector(eventTimeInterval)) doubleValue];
}

- (void)setEventTimeInterval:(NSTimeInterval)eventTimeInterval
{
    objc_setAssociatedObject(self, @selector(eventTimeInterval), @(eventTimeInterval), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setHitEdgeInsets:(UIEdgeInsets)hitEdgeInsets
{
    NSValue *hitvalue = [NSValue valueWithUIEdgeInsets:hitEdgeInsets];
    objc_setAssociatedObject(self, @selector(hitEdgeInsets), hitvalue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIEdgeInsets)hitEdgeInsets
{
    NSValue *value = objc_getAssociatedObject(self, @selector(hitEdgeInsets));
    return value.UIEdgeInsetsValue;
}
- (void)setSendActionBlock:(void (^)(SEL, id, UIEvent *))sendActionBlock
{
    objc_setAssociatedObject(self, @selector(sendActionBlock), sendActionBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(SEL, id, UIEvent *))sendActionBlock
{
    return objc_getAssociatedObject(self, @selector(sendActionBlock));
}

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL oriSel = @selector(sendAction:to:forEvent:);
        SEL swiSel = @selector(wxd_sendAction:to:forEvent:);
        Method originInstanceMethod = class_getInstanceMethod(self, oriSel);
        Method swizzleInstanceMethod = class_getInstanceMethod(self, swiSel);
        if (!originInstanceMethod || !swizzleInstanceMethod) { return; }
        
        BOOL didAddMethod = class_addMethod(self, oriSel, method_getImplementation(swizzleInstanceMethod), method_getTypeEncoding(swizzleInstanceMethod));

        if (didAddMethod) {
            class_replaceMethod(self, swiSel, method_getImplementation(originInstanceMethod), method_getTypeEncoding(originInstanceMethod));
        } else {
            method_exchangeImplementations(originInstanceMethod, swizzleInstanceMethod);
        }
    });
}

- (void)setEventTimeIntervalWith:(NSTimeInterval)interval sendActionBlock:(void (^)(SEL _Nonnull, id _Nonnull, UIEvent * _Nonnull))sendActionBlock
{
    self.eventTimeInterval = interval;
    self.sendActionBlock = sendActionBlock;
}

- (void)wxd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.eventTimeInterval == 0) {
        [self wxd_sendAction:action to:target forEvent:event];
    } else {
        if (self.ignoreEventTimeInterval){
            return;
        }else if (self.eventTimeInterval > 0){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.eventTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self setIgnoreEventTimeInterval:false];
            });
        }
        self.ignoreEventTimeInterval = true;
        if (self.sendActionBlock) {
            self.sendActionBlock(action, target, event);
        }
        // 这里看上去会陷入递归调用死循环，但在运行期此方法是和sendAction:to:forEvent:互换的，相当于执行sendAction:to:forEvent:方法，所以并不会陷入死循环。
        [self wxd_sendAction:action to:target forEvent:event];
    }
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    if (!UIEdgeInsetsEqualToEdgeInsets(self.hitEdgeInsets, UIEdgeInsetsZero)) {
        CGRect btnBounds = self.bounds;
        btnBounds = UIEdgeInsetsInsetRect(btnBounds, self.hitEdgeInsets);
        return CGRectContainsPoint(btnBounds, point);
    } else {
        return CGRectContainsPoint(self.bounds, point);
    }
}
@end
