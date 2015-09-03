//
//  LightUser+Login.h
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser.h"

#pragma mark  -- blocks
typedef void(^loginBlock)(BOOL isSuccess, NSError *error);

@interface LightUser (Login)

- (void)loginWithCode:(NSString *)code
          andPassword:(NSString *)password
   andCompeletedBlock:(loginBlock)compeletedBLock;

@end
