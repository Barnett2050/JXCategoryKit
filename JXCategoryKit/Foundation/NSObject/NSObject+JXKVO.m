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
    /*
     当包含这个参数的时候，在被观察的property的值改变前和改变后，系统各会给观察者发送一个change notification；在property的值改变之前发送的change notification中，change参数会包含NSKeyValueChangeNotificationIsPriorKey并且值为@YES，但不会包含NSKeyValueChangeNewKey和它对应的值。
     */
    if ([[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue]) return;
    /*
     NSKeyValueChangeKindKey对应的value是一个枚举值（NSKeyValueChange，就是下面这个），当被观察的值被设置时（setter方法调用时）KindKey对应的值为1（NSKeyValueChangeSetting）。

     如果观测的值是一个可变数组，那么当数组执行插入，删除，替换时kindKey会对应Insertion，Removal和Replacement。

     typedefNS_ENUM(NSUInteger,NSKeyValueChange) {NSKeyValueChangeSetting= 1,NSKeyValueChangeInsertion= 2,NSKeyValueChangeRemoval= 3,NSKeyValueChangeReplacement= 4,};
     */
    if ([[change objectForKey:NSKeyValueChangeKindKey] integerValue] != NSKeyValueChangeSetting) return;
    
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
