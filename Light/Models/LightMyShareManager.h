//
//  LightMyShareManager.h
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LightUser;

@interface LightMyShareManager : NSObject

@property (strong , nonatomic) LightUser *owner;

// 单利
+ (instancetype)shareUser;

@end
