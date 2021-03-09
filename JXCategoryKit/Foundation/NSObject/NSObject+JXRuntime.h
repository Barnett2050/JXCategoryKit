//
//  NSObject+JXRuntime.h
//  CustomCategory
//
//  Created by edz on 2019/10/9.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JXRuntime)

/// swizzle交换类方法
/// @param oriSel 原有方法
/// @param swiSel 替换方法
+ (void)jx_swizzleClassMethodOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel;

/// swizzle交换类实例方法
/// @param oriSel 原有方法
/// @param swiSel 替换方法
+ (void)jx_swizzleClassInstanceMethodWithOriginSel:(SEL)oriSel swizzleSel:(SEL)swiSel;

/// 判断方法是否在子类里override了
/// @param cls 传入要判断的Class
/// @param sel 传入要判断的Selector
- (BOOL)jx_isMethodOverride:(Class)cls selector:(SEL)sel;

/// 将一个对象与“self”相关联，它是一个strong属性（strong，nonatomic）。
- (void)jx_setAssociateValue:(nullable id)value withKey:(void *)key;

/// 将一个对象与“self”相关联，它是一个弱属性（assign，nonatomic）。
- (void)jx_setAssociateWeakValue:(nullable id)value withKey:(void *)key;

/// 获取一个关联对象
- (nullable id)jx_getAssociatedValueForKey:(void *)key;

/// 移除所有的关联对象
- (void)jx_removeAssociatedValues;

/// 判断当前类是否在主bundle里
/// @param cls 类
+ (BOOL)jx_isMainBundleClass:(Class)cls;

/// 输出类方法
+ (void)jx_printClassMethodList;

/// 输出类属性
+ (void)jx_printClassPropertyList;

/// 返回类属性字典
- (NSDictionary *)jx_properties_aps;

/// 清空所有属性值
- (void)jx_cleanWithAllProperties;
@end

NS_ASSUME_NONNULL_END
