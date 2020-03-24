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

/**
 swizzle交换类方法

 @param oriSel 原有方法
 @param swiSel 替换方法
 */
+ (void)jx_swizzleClassMethodOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel;

/**
 swizzle交换类实例方法

 @param oriSel 原有方法
 @param swiSel 替换方法
 */
+ (void)jx_swizzleClassInstanceMethodWithOriginSel:(SEL)oriSel swizzleSel:(SEL)swiSel;

/**
 判断方法是否在子类里override了
 
 @param cls 传入要判断的Class
 @param sel 传入要判断的Selector
 @return 返回判断是否被重载的结果
 */
- (BOOL)jx_isMethodOverride:(Class)cls selector:(SEL)sel;

/**
 判断当前类是否在主bundle里
 
 @param cls 出入类
 @return 返回判断结果
 */
+ (BOOL)jx_isMainBundleClass:(Class)cls;

/// 输出类方法
+ (void)jx_printClassMethodList;

/// 输出类属性
+ (void)jx_printClassPropertyList;
/**
 返回类属性字典
 */
- (NSDictionary *)jx_properties_aps;
@end

NS_ASSUME_NONNULL_END
