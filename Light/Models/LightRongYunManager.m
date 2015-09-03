//
//  LightRongYunManager.m
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightRongYunManager.h"
#import <RongIMKit/RongIMKit.h>
#import "ModelConfig.h"
#import "LightUser+Friend.h"
#import "LightNPC.h"
#import "LightExperts.h"
#import "LightUser+Friend.h"

@interface LightRongYunManager ()<RCIMUserInfoDataSource>
{

    NSMutableArray *rongYunUsers;
}

@property (strong , nonatomic) NSString *token;


@end

@implementation LightRongYunManager

- (void)synchronizationUserWithBlock:(synchronizationBlock)block{

    [[LightMyShareManager shareUser].owner getFriendsWithBlock:^(BOOL isSuccess, NSArray *friends, NSError *error) {
        
        if (isSuccess) {
            
        }
        else
        {
            block(NO,error);
        }
        
    }];
    
    [[LightNPC new] getNpcsWithBlock:^(BOOL isSuccess, NSArray *npcs, NSError *error) {
        
        if (isSuccess) {
            
            block(YES,nil);
        }
        else{
            block(NO,error);
        }
    }];
    
    [[LightExperts new] getExpertsWithField:LightExpertFieldLvShi andBlock:^(BOOL isSuccess, NSArray *experts, NSError *error) {
        
    }];
    [[LightExperts new] getExpertsWithField:LightExpertFieldMingLiShi andBlock:^(BOOL isSuccess, NSArray *experts, NSError *error) {
        
    }];
    [[LightExperts new] getExpertsWithField:LightExpertFieldXinLiZiXunShi andBlock:^(BOOL isSuccess, NSArray *experts, NSError *error) {
        
    }];
    [[LightExperts new] getExpertsWithField:LightExpertFieldPeiBanShi andBlock:^(BOOL isSuccess, NSArray *experts, NSError *error) {
        
    }];


}

+ (instancetype)shareManager
{
    static LightRongYunManager *shareManager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        shareManager = [[self alloc] init];
    });
    return shareManager;
}

- (void)login{

    [self getRongYunToken:^(BOOL isSuccess, NSError *error) {
        
        [self loginRongYunCloud:^(BOOL isSuccess, NSError *error) {
            
            if (isSuccess) {
                
                [self synchronizationUserWithBlock:^(BOOL isSucess, NSError *error) {
                   
                    if (!isSuccess) {
                        NSLog(@"同步容云用户信息失败");
                    }
                }];
            }
            else{
                NSLog(@"登录容云失败");
            }
        }];
    }];

}
- (void)getRongYunToken:(getRongYunTokenBlock)compeletdBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:[LightMyShareManager shareUser].owner.Id] forKey:@"user_id"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/im/getToken.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                self.token = Light_GetStringValueFromDicWithKey(resturnDic, @"token");
                
                compeletdBlock(YES,nil);
            }
            else
            {
                compeletdBlock(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            compeletdBlock(NO,error);
        }
        
    }];
}

- (void)loginRongYunCloud:(loginRongYunBlock)compeletedBlock
{
    
    [[RCIM sharedRCIM] connectWithToken:_token success:^(NSString *userId) {
        
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            compeletedBlock(YES , nil);
        });
        
    } error:^(RCConnectErrorCode status) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            compeletedBlock(NO , [NSError errorWithDomain:@"登录容云失败" code:1000 userInfo:nil]);
        });
    } tokenIncorrect:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            compeletedBlock(NO , [NSError errorWithDomain:@"登录容云失败" code:1000 userInfo:nil]);
        });
    }];
}

- (void)logout{
    
    [[RCIM sharedRCIM] disconnect:YES];
}

- (void)addToRongYunUserWithUserID:(NSString *)userid andUserName:(NSString *)userName andUserPic:(NSString *)avatar{

    if (rongYunUsers == nil) {
        
        rongYunUsers = [NSMutableArray new];
    }
    NSInteger count = rongYunUsers.count;
    
    for (int i = 0; i<count; i++) {
        
        RCUserInfo *userHave = rongYunUsers[i];
        
        if ([userid isEqualToString:userHave.userId]) {
            
            return;
        }
    }
    
    RCUserInfo *user = [[RCUserInfo alloc]init];
    user.userId = userid;
    user.name = userName;
    user.portraitUri = avatar;
    [rongYunUsers addObject:user];

}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    // 这里的id匹配一下
    LightUser *owner = [LightMyShareManager shareUser].owner;
    
    if (userId.integerValue == owner.Id ) {
        
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = [NSString stringWithFormat:@"%ld",(long)owner.Id];
        user.name = owner.name;
        user.portraitUri = owner.avatar;
        
        return completion(user);

    }
    else
    {
        for (RCUserInfo *user in rongYunUsers) {
            
            if ([user.userId isEqualToString:userId]) {
                return completion(user);
            }
        }
    }
    
   
}

@end
