//
//  UIGestureRecognizer+JXBlock.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/21.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "UIGestureRecognizer+JXBlock.h"
#import <objc/runtime.h>

static const int block_key;

@interface JXUIGestureRecognizerBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);

- (id)initWithBlock:(void (^)(id sender))block;
- (void)invoke:(id)sender;

@end

@implementation JXUIGestureRecognizerBlockTarget

- (id)initWithBlock:(void (^)(id sender))block{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end

@implementation UIGestureRecognizer (JXBlock)

- (instancetype)initWithActionBlock:(void (^)(id sender))block {
    self = [self init];
    [self addActionBlock:block];
    return self;
}

- (void)addActionBlock:(void (^)(id sender))block {
    JXUIGestureRecognizerBlockTarget *target = [[JXUIGestureRecognizerBlockTarget alloc] initWithBlock:block];
    [self addTarget:target action:@selector(invoke:)];
    NSMutableArray *targets = [self p_allUIGestureRecognizerBlockTargets];
    [targets addObject:target];
}

- (void)removeAllActionBlocks{
    NSMutableArray *targets = [self p_allUIGestureRecognizerBlockTargets];
    [targets enumerateObjectsUsingBlock:^(id target, NSUInteger idx, BOOL *stop) {
        [self removeTarget:target action:@selector(invoke:)];
    }];
    [targets removeAllObjects];
}

- (NSMutableArray *)p_allUIGestureRecognizerBlockTargets
{
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
