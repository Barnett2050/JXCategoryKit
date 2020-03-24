//
//  NSMutableAttributedString+JXGeneral.m
//  CustomCategory
//
//  Created by edz on 2019/10/12.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSMutableAttributedString+JXGeneral.h"

@implementation NSMutableAttributedString (JXGeneral)

- (NSDictionary *)jx_getAttributedDictionaryWith:(NSRange)range
{
    NSDictionary *dic = [self attributesAtIndex:range.location effectiveRange:&range];
    return dic;
}

@end
