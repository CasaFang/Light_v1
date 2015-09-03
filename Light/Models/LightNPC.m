//
//  LightNPC.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightNPC.h"
#import "ModelConfig.h"
#import "LightMyShareManager.h"
#import "LightRongYunManager.h"

@interface LightNPC ()

@end

@implementation LightNPC

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        _avatar = dic[@"avatar"];
        _Id = [dic[@"id"] integerValue];
        _name = dic[@"name"];
        _welcomeWord = dic[@"welcome_word"];
        NSInteger fieldIntValue = [dic[@"field"] integerValue];
        
        if (fieldIntValue == 10) {
            _field = @"陪伴师";
        }
        else if (fieldIntValue == 11){
        
            _field = @"咨询师";
        }
        else if (fieldIntValue == 20){
            
            _field = @"命理师";
        }
        else if (fieldIntValue == 30){
            
            _field = @"律师";
        }
    }
    return self;
}

- (void)getNpcsWithBlock:(getNpcsBlock)compeletedBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    LightUser *user = [LightMyShareManager shareUser].owner;
    [parameters setValue:[NSNumber numberWithInteger:user.Id] forKey:@"user_id"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/friend/npcs.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            NSMutableArray *arr = [NSMutableArray new];
            
            if (validate.result_code == 0) {
                
                
                NSArray *npcs = resturnDic[@"npcs"];
                
                if (npcs && ![npcs isKindOfClass:[NSNull class]]) {
                    
                    for (NSDictionary *d in npcs) {
                        
                        LightNPC *user = [[LightNPC alloc]initWithDic:d];
                        
                        [arr addObject:user];
                        
                        [[LightRongYunManager shareManager] addToRongYunUserWithUserID:[NSString stringWithFormat:@"%ld",(long)user.Id] andUserName:user.name andUserPic:user.avatar];
                    }
                    
                }
                
                compeletedBlock(YES,arr,nil);
            }
            else if (validate.result_code == 1)
            {
                compeletedBlock(YES,arr,nil);
            }
            else
            {
                compeletedBlock(NO,arr,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            compeletedBlock(NO,nil,error);
        }
    }];
}



@end
