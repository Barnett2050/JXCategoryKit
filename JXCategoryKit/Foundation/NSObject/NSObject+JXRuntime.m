//
//  NSObject+JXRuntime.m
//  CustomCategory
//
//  Created by edz on 2019/10/9.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSObject+JXRuntime.h"
#import <objc/runtime.h>
@implementation NSObject (JXRuntime)

+ (void)jx_swizzleClassMethodOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel
{
    Class cls = object_getClass(self);
    Method originClassMethod = class_getClassMethod(cls, oriSel);
    Method swizzleClassMethod = class_getClassMethod(cls, swiSel);
    
    [self p_swizzleMethodWithOriginSel:oriSel oriMethod:originClassMethod swizzledSel:swiSel swizzledMethod:swizzleClassMethod class:cls];
}

+ (void)jx_swizzleClassInstanceMethodWithOriginSel:(SEL)oriSel swizzleSel:(SEL)swiSel
{
    Method originClassMethod = class_getInstanceMethod(self, oriSel);
    Method swizzleClassMethod = class_getInstanceMethod(self, swiSel);
    
    [self p_swizzleMethodWithOriginSel:oriSel oriMethod:originClassMethod swizzledSel:swiSel swizzledMethod:swizzleClassMethod class:self];
}

- (BOOL)jx_isMethodOverride:(Class)cls selector:(SEL)sel {
    IMP clsIMP = class_getMethodImplementation(cls, sel);
    IMP superClsIMP = class_getMethodImplementation([cls superclass], sel);
    
    return clsIMP != superClsIMP;
}

- (void)jx_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)jx_setAssociateWeakValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)jx_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)jx_removeAssociatedValues {
    objc_removeAssociatedObjects(self);
}

+ (BOOL)jx_isMainBundleClass:(Class)cls {
    return cls && [[NSBundle bundleForClass:cls] isEqual:[NSBundle mainBundle]];
}

+ (void)jx_printClassMethodList
{
    unsigned int methodCount =0;
    Method *methodList = class_copyMethodList([self class],&methodCount);
    
    for(int i = 0; i < methodCount; i++)
    {
        Method temp = methodList[i];
//        IMP imp = method_getImplementation(temp);
//        SEL name_f = method_getName(temp);
        const char *name_s = sel_getName(method_getName(temp));
        int arguments = method_getNumberOfArguments(temp);
        const char *encoding = method_getTypeEncoding(temp);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,
              [NSString stringWithUTF8String:encoding]);
    }
    free(methodList);
}
+ (void)jx_printClassPropertyList
{
    unsigned int count = 0;
    objc_property_t *propertys = class_copyPropertyList(self.class, &count);
    
    for (int i = 0; i < count; i++) {
        
        objc_property_t property = propertys[i];
        // 属性名称
        const char *name = property_getName(property);
        NSLog(@"property name:%s",name);
    }
    free(propertys);
}
- (NSDictionary *)jx_properties_aps {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i< outCount; i++)
    {
        objc_property_t property = properties[i];
        const char *char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setValue:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

- (void)jx_cleanWithAllProperties {
    unsigned int pro_count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &pro_count);
    for (int i = 0; i < pro_count; i ++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithFormat:@"%s", property_getName(property)];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        
        if (!propertyValue ||
            [propertyValue isKindOfClass:[NSNull class]]) {
            continue;
        }
        
        if ([propertyValue isKindOfClass:[NSString class]]) {
            [self setValue:@"" forKey:propertyName];
        } else if ([propertyValue isKindOfClass:[NSNumber class]]) {
            [self setValue:[NSNumber numberWithInteger:0] forKey:propertyName];
        } else if ([propertyValue isKindOfClass:[NSDictionary class]]) {
            [self setValue:@{} forKey:propertyName];
        }else if ([propertyValue isKindOfClass:[NSMutableDictionary class]]) {
            [self setValue:[NSMutableDictionary dictionary] forKey:propertyName];
        }else if ([propertyValue isKindOfClass:[NSArray class]]) {
            [self setValue:@[] forKey:propertyName];
        }else if ([propertyValue isKindOfClass:[NSMutableArray class]]) {
            [self setValue:[NSMutableArray array] forKey:propertyName];
        }  else {
            [self setValue:nil forKey:propertyName];
        }
    }
    free(properties);
}


#pragma mark - private
+ (void)p_swizzleMethodWithOriginSel:(SEL)oriSel
                         oriMethod:(Method)oriMethod
                       swizzledSel:(SEL)swizzledSel
                    swizzledMethod:(Method)swizzledMethod
                             class:(Class)cls {
    BOOL didAddMethod = class_addMethod(cls, oriSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, swizzledMethod);
    }
}

@end
