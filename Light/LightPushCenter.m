//
//  LightPushCenter.m
//  Light
//
//  Created by 郑来贤 on 15/8/30.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightPushCenter.h"
#import <UIKit/UIKit.h>


NSString *const LightPushAddFriendNoti = @"LightPushAddFriendNoti";
NSString *const LightPushMarryNoti = @"LightPushMarryNoti";


@implementation LightPushCenter

+ (instancetype)shareCenter
{
    static LightPushCenter *sharedLightUserInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedLightUserInstance = [[self alloc] init];
    });
    return sharedLightUserInstance;
}


- (void)receiveRemoteNotification:(NSDictionary *)userInfo{

    NSString *pushType = userInfo[@"pushType"];
    
    NSInteger count = [UIApplication sharedApplication].applicationIconBadgeNumber;
    
    NSInteger nowCount = count + 1;
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:nowCount];
    
    if ([pushType isEqualToString:@"1"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LightPushAddFriendNoti object:userInfo];
    }
    else if ([pushType isEqualToString:@"3"]){
    
        [[NSNotificationCenter defaultCenter] postNotificationName:LightPushMarryNoti object:userInfo];
    }

}

- (void)didReadRemotoPushNotiWithCount:(NSInteger)readCount{

    NSInteger count = [UIApplication sharedApplication].applicationIconBadgeNumber;
    NSInteger nowCount = count - readCount;
    
    if (nowCount <=0) {
        nowCount = 0;
    }
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:nowCount];
}
@end
