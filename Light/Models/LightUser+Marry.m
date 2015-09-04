//
//  LightUser+Marry.m
//  Light
//
//  Created by 郑来贤 on 15/8/24.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser+Marry.h"
#import "HtttpReques.h"
#import "LightValidateCode.h"
#import "LightMyShareManager.h"

NSString *const LightUserMarryNoti = @"LightUserMarryNoti";

@implementation LightUser (Marry)

- (void)marryToUser:(NSInteger )userId andContent:(NSString *)content andCompletedBlock:(marryBlock)completedBlock
{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:userId] forKey:@"to_user_id"];
    [parameters setValue:content forKey:@"content"];
    [parameters setValue:[NSNumber numberWithInteger:[LightMyShareManager shareUser].owner.Id] forKey:@"from_user_id"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/marry/add.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                completedBlock(YES,nil);
            }
            else
            {
                completedBlock(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            completedBlock(NO,error);
        }
        
    }];

}
- (void)marryReponseWithMarryId:(NSInteger)marrayId andStatus:(NSInteger)status andBlock:(marryBlock)completedBlock{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:marrayId] forKey:@"req_id"];
    [parameters setValue:[NSNumber numberWithInteger:status] forKey:@"status"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/marry/add/resp.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LightUserMarryNoti object:nil];
                
                completedBlock(YES,nil);
            }
            else
            {
                completedBlock(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            completedBlock(NO,error);
        }
        
    }];
}

@end
