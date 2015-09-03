//
//  LightPushCenter.h
//  Light
//
//  Created by 郑来贤 on 15/8/30.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *const LightPushAddFriendNoti;
extern NSString *const LightPushMarryNoti;

@interface LightPushCenter : NSObject

+ (instancetype)shareCenter;

- (void)receiveRemoteNotification:(NSDictionary *)userInfo;

- (void)didReadRemotoPushNotiWithCount:(NSInteger )readCount;

@end
