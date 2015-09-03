//
//  ChatListViewController.h
//  RongCloudDemo
//
//  Created by 杜立召 on 15/4/18.
//  Copyright (c) 2015年 dlz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
#import "LightUser.h"

@interface ChatListViewController : RCConversationListViewController

- (void)openConversionWithUser:(LightUser *)user;

@end
