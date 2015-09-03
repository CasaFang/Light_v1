//
//  LightMsg.m
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightMsg.h"
#import <RongIMLib/RongIMLib.h>

@implementation LightMsg

- (instancetype)initFromDic:(NSDictionary *)dic
{
    self = [super init];
    
    if (self) {
        
        
    }
    return self;
}

- (void)getMessagesBlock:(getMessagesBlock)compeletedBlock
{
    
    NSArray *arr = [[RCIMClient sharedRCIMClient] getConversationList:@[@(ConversationType_PRIVATE)]];
    compeletedBlock(YES ,arr,nil);
}
@end
