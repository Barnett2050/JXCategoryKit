//
//  NSObject+JXKVO.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/4/17.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSObject+JXKVO.h"
#import <objc/runtime.h>

static const int block_key;

@interface JXNSObjectKVOBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(__weak id obj, id oldVal, id newVal);

- (id)initWithBlock:(void (^)(__weak id obj, id oldVal, id newVal))block;

@end

@implementation JXNSObjectKVOBlockTarget

- (id)initWithBlock:(void (^)(__weak id obj, id oldVal, id newVal))block {
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (!self.block) return;
    
    BOOL isPrior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    if (isPrior) return;
    
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) return;
    
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldVal == [NSNull null]) oldVal = nil;
    
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    if (newVal == [NSNull null]) newVal = nil;
    
    self.block(object, oldVal, newVal);
}

@end

@implementation NSObject (JXKVO)

- (void)jx_addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(__weak id obj, id oldVal, id newVal))block
{
    if (!keyPath || !block) return;
    JXNSObjectKVOBlockTarget *target = [[JXNSObjectKVOBlockTarget alloc] initWithBlock:block];
    NSMutableDictionary *dic = [self p_allNSObjectObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    if (!arr) {
        arr = [NSMutableArray new];
        dic[keyPath] = arr;
    }
    [arr addObject:target];
    [self addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)jx_removeObserverBlocksForKeyPath:(NSString *)keyPath
{
    if (!keyPath) return;
    NSMutableDictionary *dic = [self p_allNSObjectObserverBlocks];
    NSMutableArray *arr = dic[keyPath];
    [arr enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeObserver:obj forKeyPath:keyPath];
    }];
    
    [dic removeObjectForKey:keyPath];
}

- (void)jx_removeObserverBlocks
{
    NSMutableDictionary *dic = [self p_allNSObjectObserverBlocks];
    [dic enumerateKeysAndObjectsUsingBlock: ^(NSString *key, NSArray *arr, BOOL *stop) {
        [arr enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
            [self removeObserver:obj forKeyPath:key];
        }];
    }];
    
    [dic removeAllObjects];
}

- (NSMutableDictionary *)p_allNSObjectObserverBlocks
{
    NSMutableDictionary *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
