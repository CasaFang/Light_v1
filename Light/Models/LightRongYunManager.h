//
//  LightRongYunManager.h
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^getRongYunTokenBlock)(BOOL isSuccess ,NSError *error );
typedef void(^loginRongYunBlock)(BOOL isSuccess ,NSError *error);
typedef void(^synchronizationBlock)(BOOL isSucess, NSError *error);

@interface LightRongYunManager : NSObject


// 单利
+ (instancetype)shareManager;

- (void)getRongYunToken:(getRongYunTokenBlock)compeletdBlock;
- (void)loginRongYunCloud:(loginRongYunBlock)compeletedBlock;
- (void)logout;
- (void)login;

- (void)synchronizationUserWithBlock:(synchronizationBlock)block;

- (void)addToRongYunUserWithUserID:(NSString *)userid andUserName:(NSString *)userName andUserPic:(NSString *)avatar;

@end
