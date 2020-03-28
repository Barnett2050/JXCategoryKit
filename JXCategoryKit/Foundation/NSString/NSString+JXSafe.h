//
//  NSString+JXSafe.h
//  CustomCategory
//
//  Created by Barnett on 2020/3/26.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JXSafe)

/* hook方法如下：
 substringFromIndex:
 substringToIndex:
 substringWithRange:
 getLineStart:end:contentsEnd:forRange:
 lineRangeForRange:
 getParagraphStart:end:contentsEnd:forRange:
 paragraphRangeForRange:
 enumerateSubstringsInRange:options:usingBlock:
 stringByReplacingOccurrencesOfString:withString:options:range:
 stringByReplacingCharactersInRange:withString:
 
 内部做了安全取值处理
 */

@end

NS_ASSUME_NONNULL_END
