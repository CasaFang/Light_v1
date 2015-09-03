//
//  LightMyShareManager.m
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightMyShareManager.h"

@implementation LightMyShareManager

+ (instancetype)shareUser
{
    static LightMyShareManager *sharedLightUserInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedLightUserInstance = [[self alloc] init];
    });
    return sharedLightUserInstance;
}

@end
