//
//  LightRelativeExperts.m
//  Light
//
//  Created by ming on 15/9/19.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightRelativeExperts.h"
#import "ModelConfig.h"
#import "LightRongYunManager.h"
@implementation LightRelativeExperts

- (instancetype)initFromDic:(NSDictionary *)d
{
    self = [super init];
    if (self) {
        
        [self parseData:d];
    }
    return self;
}

- (void)parseData:(NSDictionary *)dic
{
    NSString *name = Light_GetStringValueFromDicWithKey(dic, @"name");
    
    if (![name isEqualToString:@""]&&name) {
        _name = name;
    }
    
    NSString *avatar = Light_GetStringValueFromDicWithKey(dic, @"avatar");
    if (![avatar isEqualToString:@""]&&avatar) {
        _avatar = avatar;
    }
    
    
    NSString *Id = Light_GetStringValueFromDicWithKey(dic, @"user_id");
    if (![Id isEqualToString:@""]&&Id) {
        _user_id = [Id integerValue];
    }
    
    NSString *Id1 = Light_GetStringValueFromDicWithKey(dic, @"id");
    if (![Id1 isEqualToString:@""]&&Id1) {
        _Id = [Id1 integerValue];
    }
    
    NSString *goodAt = Light_GetStringValueFromDicWithKey(dic, @"good_at");
    if (![goodAt isEqualToString:@""]&&goodAt) {
        _good_at = goodAt;
    }
    
    
    NSString *lgbt = Light_GetStringValueFromDicWithKey(dic, @"lgbt");
    if (![lgbt isEqualToString:@""]&&lgbt) {
        _lgbt = lgbt;
    }
    
    NSString *pDescription = Light_GetStringValueFromDicWithKey(dic, @"description");
    if (![pDescription isEqualToString:@""]&&pDescription) {
        _pDescription = pDescription;
    }
    
    NSString *cases = Light_GetStringValueFromDicWithKey(dic, @"cases");
    if (![cases isEqualToString:@""]&&cases) {
        _cases = cases;
    }
    
}


- (void)getExpertsWithBlock:(getRelativeExpertsBlock)compeletedBlock
{
//    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/expert/relative.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:nil andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            NSMutableArray *modelExperts = [NSMutableArray new];
            
            if (validate.result_code == 0) {
                
                NSArray *returnExperts = [resturnDic valueForKey:@"relative_experts"];
                for (NSDictionary *d in returnExperts) {
                    
                    LightRelativeExperts *user = [[LightRelativeExperts alloc]initFromDic:d];
                    [modelExperts addObject:user];
                    
                    [[LightRongYunManager shareManager] addToRongYunUserWithUserID:[NSString stringWithFormat:@"%ld",(long)user.Id] andUserName:user.name andUserPic:user.avatar];
                }
                compeletedBlock(YES,modelExperts,nil);
            }
            else if (validate.result_code == 1)
            {
                compeletedBlock(YES,modelExperts,nil);
            }
            else
            {
                compeletedBlock(NO,modelExperts,[NSError errorWithDomain:validate.result_msg code:validate. result_code userInfo:nil]);
            }
            
        }
        else
        {
            compeletedBlock(NO,nil,error);
        }
        
    }];
    
}
@end
