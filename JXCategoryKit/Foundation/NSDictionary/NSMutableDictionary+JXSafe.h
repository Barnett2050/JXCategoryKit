//
//  NSMutableDictionary+JXSafe.h
//  CustomCategory
//
//  Created by edz on 2019/10/10.
//  Copyright © 2019 Barnett. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (JXSafe)

/* hook方法如下：
 setObject:forKey:
 
 内部做了安全取值处理
*/


@end

NS_ASSUME_NONNULL_END
