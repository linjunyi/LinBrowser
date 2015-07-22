//
//  BaseURLCache.h
//  LinBrowser
//
//  Created by lin on 15-4-8.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDefinition.h"

@interface BaseURLCache : NSURLCache

- (instancetype)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path;
+ (NSURLCache *)sharedURLCache;
+ (void)setSharedURLCache:(NSURLCache *)cache;

@end
