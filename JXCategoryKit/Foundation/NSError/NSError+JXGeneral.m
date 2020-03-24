//
//  NSError+JXGeneral.m
//  JXCategoryKit
//
//  Created by Barnett on 2020/3/24.
//  Copyright © 2020 Barnett. All rights reserved.
//

#import "NSError+JXGeneral.h"

@implementation NSError (JXGeneral)

+ (NSError *)jx_errorWithCode:(int)code errorMessage:(NSString*)errorMsg
{
    NSString *domain = @"com.project.ErrorDomain";
    NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] initWithCapacity:2];
    [userInfo setValue:[NSString stringWithFormat:@"%ld", (long)code] forKey:@"errorCode"];
    if (errorMsg)
    {
        [userInfo setValue:errorMsg ? errorMsg : @"" forKey:@"errorMsg"];
    }
    NSError *error = [NSError errorWithDomain:domain code:code userInfo:userInfo];
    return error;
}

- (NSInteger)jx_errorCode
{
    return self.code;
}

- (NSString*)jx_errorMsg
{
    NSString* errorMsg = nil;
    errorMsg = [self.userInfo objectForKey:@"errorMsg"];
    
    if (nil == errorMsg)
    {
        if (NSOrderedSame == [self.domain compare:@"NSURLErrorDomain"])
        {
            switch (self.code)
            {
                case NSURLErrorNotConnectedToInternet:
                    errorMsg = @"网络连接失败，请稍候再试";
                    break;
                case NSURLErrorTimedOut:
                    errorMsg = @"连接超时";
                    break;
                case kCFURLErrorCancelled:
                    errorMsg = @"网络连接失败，请稍候再试";
                    break;
                case kCFURLErrorCannotFindHost:
                    errorMsg = @"连接服务器失败，请检查网络试试";
                    break;
                default:
                    // 更改默认服务器出错提示
                    errorMsg = @"更改默认服务器出错";
                    break;
            }
        }
        else
        {
            errorMsg = @"未知错误";
        }
    }
    
    return errorMsg;
}


@end
