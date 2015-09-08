//
//  LightUser+Login.m
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser+Login.h"
#import "ModelConfig.h"
#import "LightRongYunManager.h"

@implementation LightUser (Login)

- (void)loginWithCode:(NSString *)code andPassword:(NSString *)password andCompeletedBlock:(loginBlock)compeletedBLock{
    
    code = [code trimWhiteSpace];
    if (code.length == 0) {
        
        compeletedBLock(NO,[NSError errorWithDomain:@"请填写邮箱或手机" code:1000 userInfo:nil]);
        return;
    }
    
    password = [password trimWhiteSpace];
    if (password.length == 0) {
        
        compeletedBLock(NO,[NSError errorWithDomain:@"请填写密码" code:1000 userInfo:nil]);
        return;
    }
    
    if ([code isPhoneFormat] || [code isEmailFormat]) {
        
    }
    else
    {
        compeletedBLock(NO,[NSError errorWithDomain:@"账号格式不正确" code:1000 userInfo:nil]);
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:code forKey:@"code"];
    [parameters setValue:password forKey:@"pwd"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/login.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                [self parseData:resturnDic];
                self.password = password;
                
                if ([code isPhoneFormat]) {
                    
                    self.phone = code;
                }
                else{
                
                    self.email = code;
                }
                
                
                [LightMyShareManager shareUser].owner = self;
                
                [[LightRongYunManager shareManager] addToRongYunUserWithUserID:[NSString stringWithFormat:@"%ld",(long)self.Id] andUserName:self.name andUserPic:self.avatar];
                [[LightRongYunManager shareManager] login];
                
                
                
                compeletedBLock(YES,nil);
            }
            else
            {
                compeletedBLock(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            compeletedBLock(NO,error);
        }
        
    }];
}


@end
