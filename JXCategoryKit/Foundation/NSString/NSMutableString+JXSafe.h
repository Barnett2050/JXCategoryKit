//
//  NSMutableString+JXSafe.h
//  CustomCategory
//
//  Created by Barnett on 2020/3/27.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableString (JXSafe)

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
 
 replaceCharactersInRange:withString:
 insertString:atIndex:
 deleteCharactersInRange:
 replaceOccurrencesOfString:withString:options:range:
 applyTransform:reverse:range:updatedRange:
 
 内部做了安全取值处理
*/

@end

NS_ASSUME_NONNULL_END
