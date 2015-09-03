//
//  LightUser+FindPwd.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser+FindPwd.h"
#import "NSString+Extention.h"
#import "ModelConfig.h"
#import <SMS_SDK/SMS_SDK.h>

@implementation LightUser (FindPwd)

- (void)validateCode:(NSString *)code andCompeletedBlock:(validateCodeBlock)compeletedBLock
{
    code = [code trimWhiteSpace];
    
    if (code.length == 0) {
        compeletedBLock(NO,[NSError errorWithDomain:@"请填写邮箱/手机" code:1000 userInfo:nil]);
        return;
    }
    
    if (![code isPhoneFormat] &&![code isEmailFormat]) {
        
        compeletedBLock(NO,[NSError errorWithDomain:@"手机/邮箱 格式不正确" code:1000 userInfo:nil]);
        return;
    }
    
    if ([code isPhoneFormat]) {
        
        [SMS_SDK getVerificationCodeBySMSWithPhone:code zone:@"86" result:^(SMS_SDKError *error) {
            
            if(!error){
                
                NSString *server = @"http://123.57.221.116:8080/light-server/intf/forget/forget.shtml";
                
                NSMutableDictionary *parameters = [NSMutableDictionary new];
                [parameters setValue:code forKey:@"code"];
                
                [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
                    
                    if (isSuccess) {
                        
                        LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
                        
                        
                        if (validate.result_code == 0) {
                            
                            [self parseData:resturnDic];
                            
                            compeletedBLock(YES,nil);
                        }
                        else if (validate.result_code == -1002)
                        {
                            compeletedBLock(NO, [NSError errorWithDomain:@"账号不存在" code:-1002 userInfo:nil]);
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
            else
            {
                compeletedBLock(NO,error);
            }
        }];

    }
    else if([code isEmailFormat]){
    
        NSString *server = @"http://123.57.221.116:8080/light-server/intf/forget/forget.shtml";
        
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        [parameters setValue:code forKey:@"code"];
        
        [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
            
            if (isSuccess) {
                
                LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
                
                
                if (validate.result_code == 0) {
                    
                    [self parseData:resturnDic];
                    
                    compeletedBLock(YES,nil);
                }
                else if (validate.result_code == -1002)
                {
                    compeletedBLock(NO, [NSError errorWithDomain:@"账号不存在" code:-1002 userInfo:nil]);
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
    
}

- (void)fpValidateCode:(NSString *)code checkType:(int)type andCompeletedBlock:(validateCodeBlock)compeletedBlock
{
    
    code = [code trimWhiteSpace];
    
    if (code.length == 0) {
        
        compeletedBlock(NO,[NSError errorWithDomain:@"请填写验证码" code:1000 userInfo:nil]);
        
        return;
    }
    
    
    if (type == 1) {
        
        NSString *server = @"http://123.57.221.116:8080/light-server/intf/forget/validate.shtml";
        
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        [parameters setValue:code forKey:@"val_code"];
        [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
        
        [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
            
            if (isSuccess) {
                
                NSInteger  validate_result = [Light_GetStringValueFromDicWithKey(resturnDic, @"validate_result") integerValue];
                
                if (validate_result == 1) {
                    
                    compeletedBlock(YES,nil);
                }
                else
                {
                    compeletedBlock(NO,[NSError errorWithDomain:@"验证码错误" code:1000 userInfo:nil]);
                    
                }
            }
            else
            {
                compeletedBlock(NO,error);
            }
            
        }];
        
    }
    else
    {
        [SMS_SDK commitVerifyCode:code result:^(enum SMS_ResponseState state) {
            
            if (1 == state)
            {
                compeletedBlock(YES,nil);
            }
            else if(0 == state)
            {
                compeletedBlock(NO,[NSError errorWithDomain:@"验证失败" code:1000 userInfo:nil]);
            }
        }];
        
    }
}


- (void)changePwdWithNewPwd:(NSString *)newPwd andBlock:(validateCodeBlock)compeletedBlock
{
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/forget/change.shtml";
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:newPwd forKey:@"pwd"];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                compeletedBlock(YES,nil);
            }
            else
            {
                compeletedBlock(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
        }
        else
        {
            compeletedBlock(NO,error);
        }
        
    }];

}

@end
