//
//  LightUser+Marry.h
//  Light
//
//  Created by 郑来贤 on 15/8/24.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser.h"


typedef void(^marryBlock)(BOOL isSuccess ,NSError *error);
@interface LightUser (Marry)

- (void)marryToUser:(NSInteger )userId
         andContent:(NSString *)content
  andCompletedBlock:(marryBlock )completedBlock;

@end
