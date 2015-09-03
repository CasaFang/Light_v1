//
//  LightMsg.h
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LightUser;


typedef void(^getMessagesBlock)(BOOL isSuccess ,NSArray *messages ,NSError *error);
@interface LightMsg : NSObject

@property (strong , nonatomic) LightUser *user;

@property (strong , nonatomic) NSString *content;

- (instancetype)initFromDic:(NSDictionary *)dic;


// 这里的消息从容云获取，其中冲服务器拿到专家信息填充到secion1
- (void)getMessagesBlock:(getMessagesBlock)compeletedBlock;

@end
