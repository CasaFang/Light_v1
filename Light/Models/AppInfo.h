//
//  AppInfo.h
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestAppInfoBlock)(BOOL isSuccess ,BOOL isNewVersion, NSError *error);
typedef void(^feedbackBlock)(BOOL isSuccess , NSError *error);

@interface AppInfo : NSObject

@property (strong , nonatomic) NSString *update_log;
@property (strong , nonatomic) NSString *url;
@property (assign , nonatomic) NSInteger version_code;
@property (assign , nonatomic) BOOL is_force;

- (void)requestAppInfoWithVersion_code:(NSInteger )version_code andBlock:(requestAppInfoBlock)compeletedBlock;

-(void)feedBackWithContent:(NSString *)content andUserId:(NSInteger )userId andBlock:(feedbackBlock)completedBlock;

@end
