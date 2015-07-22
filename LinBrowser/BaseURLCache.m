//
//  BaseURLCache.m
//  LinBrowser
//
//  Created by lin on 15-4-8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BaseURLCache.h"

@implementation BaseURLCache

- (instancetype)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path {
    return [super initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path];
}

+ (NSURLCache *)sharedURLCache {
    return [super sharedURLCache];
}

+ (void)setSharedURLCache:(NSURLCache *)cache {
    [super setSharedURLCache:cache];
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    if([request.HTTPMethod compare:@"GET"] != NSOrderedSame) {    //GET时才取缓存
        return [super cachedResponseForRequest:request];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager]; 
    if(![fileManager fileExistsAtPath:kCachePath]) {              //缓存文件不存在
        NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/http_www.qiushibaike.com_0.localstorage",kCachePath]];
        return [super cachedResponseForRequest:request];
    }
    return [super cachedResponseForRequest:request];
}

- (NSCachedURLResponse *)saveCache:(NSURLRequest *)request {
    __block NSCachedURLResponse *cacheResponse = nil;
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(response && data) {
            cacheResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
        }
    }];
    return cacheResponse;
}

@end
