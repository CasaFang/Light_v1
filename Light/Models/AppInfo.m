//
//  AppInfo.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AppInfo.h"
#import "ModelConfig.h"

@implementation AppInfo

- (void)requestAppInfoWithVersion_code:(NSInteger)version_code andBlock:(requestAppInfoBlock)compeletedBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:@(1) forKey:@"platform"];
    [parameters setValue:@(version_code) forKey:@"version_code"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/version/current.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                compeletedBlock(YES,YES,nil);
            }
            else if(validate.result_code == 1){
                
                compeletedBlock(YES,NO,nil);
            }
            else
            {
                compeletedBlock(NO,NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            compeletedBlock(NO,NO,error);
        }
        
    }];

}

- (void)feedBackWithContent:(NSString *)content andUserId:(NSInteger)userId andBlock:(feedbackBlock)completedBlock{

    
    if (content.trimWhiteSpace.length == 0) {
        completedBlock(NO,[NSError errorWithDomain:@"请填写反馈意见" code:100 userInfo:nil]);
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:content forKey:@"content"];
    [parameters setValue:@(userId) forKey:@"user_id"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/feedback/add.shtml";
    
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

@end
