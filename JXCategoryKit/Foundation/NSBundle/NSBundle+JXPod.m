//
//  NSBundle+JXPod.m
//  CustomCategory
//
//  Created by edz on 2019/10/11.
//  Copyright © 2019 Barnett. All rights reserved.
//

#import "NSBundle+JXPod.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSBundle (JXPod)

+ (NSString *)jx_pathWithFileName:(NSString *)fileName podName:(NSString *)podName ofType:(NSString *)ext{
    
    if (!fileName ) {
        return nil;
    }
    NSBundle * pod_bundle =[self jx_bundleWithPodName:podName];
    if (!pod_bundle) {
        return nil;
    }
    if (!pod_bundle.loaded) {
        [pod_bundle load];
    }
    NSString *filePath =[pod_bundle pathForResource:fileName ofType:ext];
    return filePath;
}


+ (NSBundle *)jx_bundleWithPodName:(NSString *)podName{
    if (!podName) {
        return [NSBundle mainBundle];
    }
    NSBundle * bundle = [NSBundle bundleForClass:NSClassFromString(podName)];
    NSURL * url = [bundle URLForResource:podName withExtension:@"bundle"];
    if (!url) {
        NSArray *frameWorks = [NSBundle allFrameworks];
        BOOL isContain = false;
        for (NSBundle *tempBundle in frameWorks) {
            url = [tempBundle URLForResource:podName withExtension:@"bundle"];
            if (url) {
                bundle =[NSBundle bundleWithURL:url];
                if (!bundle.loaded) {
                    [bundle load];
                }
                return bundle;
            }
        }
        if (!isContain) {
            return [NSBundle mainBundle];
        }
    }else{
        bundle =[NSBundle bundleWithURL:url];
        return bundle;
    }
    return nil;
}

+ (NSBundle *)jx_bundleWithBundleName:(NSString *)bundleName{
    if (!bundleName) {
        return [NSBundle mainBundle];
    }
    
    NSString *bundlePath = [NSBundle mainBundle].bundlePath;
    bundlePath = [NSString stringWithFormat:@"%@/%@.bundle",bundlePath,bundleName];
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"file://%@",bundlePath] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters]];
    NSBundle *bundle =[NSBundle bundleWithURL:url];
    return bundle;
}

+ (NSString *)jx_filePathWithBundleName:(NSString *)bundleName fileName:(NSString *)fileName podName:(NSString *)podName{
    if (!podName) {
        NSBundle *bundle = [self jx_bundleWithBundleName:bundleName];
        NSString *filePath = [bundle pathForResource:fileName ofType:nil];
        return filePath;
    }
    
    NSBundle *pod_bundle = [self jx_bundleWithPodName:podName];
    if (!bundleName) {
        NSString *filePath = [pod_bundle pathForResource:fileName ofType:nil];
        return filePath;
    }
    
    NSString *bundlePath = pod_bundle.bundlePath;
    bundlePath = [NSString stringWithFormat:@"%@/%@.bundle",bundlePath,podName];
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"file://%@/%@.bundle",bundlePath,bundleName] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters]];
    NSBundle *bundle =[NSBundle bundleWithURL:url];
    if (bundle) {
        NSString *filePath = [bundle pathForResource:fileName ofType:nil];
        return filePath;
    }
    return nil;
}

+ (NSURL *)jx_fileURLWithBundleName:(NSString *)bundleName fileName:(NSString *)fileName podName:(NSString *)podName{
    NSString *filePath = [self jx_filePathWithBundleName:bundleName fileName:fileName podName:podName];
    NSString *fileURLStr = [NSString stringWithFormat:@"file://%@",filePath];
    NSURL *fileURL = [NSURL URLWithString:fileURLStr];
    if (!fileURL) {
        fileURLStr = [fileURLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        fileURL = [NSURL URLWithString:fileURLStr];
    }
    return fileURL;
}

+ (id)jx_loadNibName:(NSString *)nibName podName:(NSString *)podName{
    NSBundle *bundle =[self jx_bundleWithPodName:podName];
    if (!bundle) {
        return nil;
    }
    id object = [[bundle loadNibNamed:nibName owner:nil options:nil] lastObject];
    return object;
}

+ (UIStoryboard *)jx_storyboardWithName:(NSString *)name podName:(NSString *)podName{
    NSBundle *bundle =[self jx_bundleWithPodName:podName];
    if (!bundle) {
        return nil;
    }
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:bundle];
    return storyBoard;
}

+ (UIImage *)jx_imageWithName:(NSString *)imageName podName:(NSString *)podName {
    NSBundle * pod_bundle =[self jx_bundleWithPodName:podName];
    if (!pod_bundle) {
        return nil;
    }
    if (!pod_bundle.loaded) {
        [pod_bundle load];
    }
    UIImage *image = [UIImage imageNamed:imageName inBundle:pod_bundle compatibleWithTraitCollection:nil];
    return image;
}

+ (NSString*)jx_fileMD5HashStringWithPath:(NSString*)filePath{
    return [self jx_fileMD5HashStringWithPath:filePath WithSize:1024 *8];
}

+ (NSString*)jx_fileMD5HashStringWithPath:(NSString*)filePath WithSize:(size_t)chunkSizeForReadingData{
    
    NSMutableString *result=nil;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    
    CC_MD5_CTX hashObject;
    bool hasMoreData = true;
    bool didSucceed;
    
    if (!fileURL) goto done;
    
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = 1024*8;
    }
    
    // Feed the data to the hash object
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,
                                                  (UInt8 *)buffer,
                                                  (CFIndex)sizeof(buffer));
        if (readBytesCount == -1)break;
        if (readBytesCount == 0) {
            hasMoreData =false;
            continue;
        }
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    result = [NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++){
        [result appendFormat:@"%02x",digest[i]];
    }
    
done:
    
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}

+ (NSString *)jx_localizedStringForKey:(NSString *)key language:(NSString *)language{
    return [self jx_localizedStringForKey:key language:language podName:nil];
}

+ (NSString *)jx_localizedStringForKey:(NSString *)key language:(NSString *)language podName:(nullable NSString *)podName
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle jx_bundleWithPodName:podName] pathForResource:language ofType:@"lproj"]];
    NSString *value = [bundle localizedStringForKey:key value:nil table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

+ (NSArray *)jx_getTotalBundle
{
    NSArray *arr = [[NSBundle mainBundle] URLsForResourcesWithExtension:@".bundle" subdirectory:nil];
    return arr;
}

+ (NSString *)jx_getPodResourcePathWith:(Class)cla fileName:(NSString *)fileName
{
    NSBundle *bundle = [NSBundle bundleForClass:cla];
    NSDictionary *bundleDic = bundle.infoDictionary;
    NSString *bundleName = [bundleDic objectForKey:@"CFBundleExecutable"];
    NSString *path = [bundle pathForResource:fileName ofType:nil inDirectory:[NSString stringWithFormat:@"%@.bundle",bundleName]];
    return path;
}
@end
