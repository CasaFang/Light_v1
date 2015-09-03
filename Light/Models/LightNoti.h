//
//  LightNoti.h
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^getNotisBlock)(BOOL isSuccess , NSArray *notis,NSError *error);
@interface LightNoti : NSObject

- (void)getNotisBlock:(getNotisBlock)compeletedBlock;

@end
