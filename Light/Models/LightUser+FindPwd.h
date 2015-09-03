//
//  LightUser+FindPwd.h
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser.h"

typedef void(^validateCodeBlock)(BOOL isSuccess ,NSError *error);

@interface LightUser (FindPwd)

- (void)validateCode:(NSString *)code andCompeletedBlock:(validateCodeBlock)compeletedBLock;

- (void)fpValidateCode:(NSString *)code checkType:(int)type andCompeletedBlock:(validateCodeBlock)compeletedBlock;

- (void)changePwdWithNewPwd:(NSString *)newPwd andBlock:(validateCodeBlock)compeletedBlock;

@end
