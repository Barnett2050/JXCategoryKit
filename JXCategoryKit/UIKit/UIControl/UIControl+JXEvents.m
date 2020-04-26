//
//  UIControl+JXEvents.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/21.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "UIControl+JXEvents.h"
#import <objc/runtime.h>

static const int block_key;

@interface JXUIControlBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);
@property (nonatomic, assign) UIControlEvents events;

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events;
- (void)invoke:(id)sender;

@end

@implementation JXUIControlBlockTarget

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events
{
    self = [super init];
    if (self) {
        _block = [block copy];
        _events = events;
    }
    return self;
}

- (void)invoke:(id)sender
{
    if (_block) _block(sender);
}

@end

@implementation UIControl (JXEvents)

- (void)jx_removeAllTargets {
    [[self allTargets] enumerateObjectsUsingBlock: ^(id object, BOOL *stop) {
        [self removeTarget:object action:NULL forControlEvents:UIControlEventAllEvents];
    }];
    [[self p_allUIControlBlockTargets] removeAllObjects];
}

- (void)jx_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (!target || !action || !controlEvents) return;
    NSSet *targets = [self allTargets];
    for (id currentTarget in targets) {
        NSArray *actions = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
        for (NSString *currentAction in actions) {
            [self removeTarget:currentTarget action:NSSelectorFromString(currentAction)
                forControlEvents:controlEvents];
        }
    }
    [self addTarget:target action:action forControlEvents:controlEvents];
}

- (void)jx_addBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id sender))block {
    if (!controlEvents) return;
    JXUIControlBlockTarget *target = [[JXUIControlBlockTarget alloc]
                                       initWithBlock:block events:controlEvents];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
    NSMutableArray *targets = [self p_allUIControlBlockTargets];
    [targets addObject:target];
}

- (void)jx_setBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id sender))block {
    [self jx_removeAllBlocksForControlEvents:UIControlEventAllEvents];
    [self jx_addBlockForControlEvents:controlEvents block:block];
}

- (void)jx_removeAllBlocksForControlEvents:(UIControlEvents)controlEvents
{
    if (!controlEvents) return;
    
    NSMutableArray *targets = [self p_allUIControlBlockTargets];
    NSMutableArray *removes = [NSMutableArray array];
    for (JXUIControlBlockTarget *target in targets) {
        if (target.events & controlEvents) {
            UIControlEvents newEvent = target.events & (~controlEvents);
            if (newEvent) {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                target.events = newEvent;
                [self addTarget:target action:@selector(invoke:) forControlEvents:target.events];
            } else {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                [removes addObject:target];
            }
        }
    }
    [targets removeObjectsInArray:removes];
}

#pragma mark - private
- (NSMutableArray *)p_allUIControlBlockTargets
{
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}


@end
