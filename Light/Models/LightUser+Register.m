//
//  LightUser+Register.m
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser+Register.h"
#import "ModelConfig.h"
#import <SMS_SDK/SMS_SDK.h>

@implementation LightUser (Register)

- (void)registerWithPhoneCode:(NSString *)code andCompeletedBlock:(registerBlock)compeletedBLock
{
    code = [code trimWhiteSpace];
    
    if (code.length == 0) {
        compeletedBLock(NO,[NSError errorWithDomain:@"请填写邮箱" code:1000 userInfo:nil]);
        return;
    }
    
    if (![code isPhoneFormat]) {
        
        compeletedBLock(NO,[NSError errorWithDomain:@"手机号格式不正确" code:1000 userInfo:nil]);
        return;
    }
    
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:code zone:@"86" result:^(SMS_SDKError *error) {
        
        if(!error){
            
            NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/register.shtml";
            
            NSMutableDictionary *parameters = [NSMutableDictionary new];
            [parameters setValue:code forKey:@"code"];
            
            [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
                
                if (isSuccess) {
                    
                    LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
                    
                    
                    if (validate.result_code == 0) {
                        
                        [self parseData:resturnDic];
                        
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
        else
        {
            compeletedBLock(NO,error);
        }
    }];
    
}

- (void)registerWithEmailCode:(NSString *)code andCompeletedBlock:(registerBlock)compeletedBLock{
    
    code = [code trimWhiteSpace];
    
    if (code.length == 0) {
        compeletedBLock(NO,[NSError errorWithDomain:@"请填写邮箱" code:1000 userInfo:nil]);
        return;
    }
    
    if (![code isEmailFormat]) {
        
        compeletedBLock(NO,[NSError errorWithDomain:@"邮箱格式不正确" code:1000 userInfo:nil]);
        return;
    }
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/register.shtml";
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:code forKey:@"code"];
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            
            if (validate.result_code == 0) {
                
                [self parseData:resturnDic];
                
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

- (void)validateCodeWithCode:(NSString *)code checkType:(int)type andCompeletedBlock:(validateBlock)compeletedBlock
{
    
    code = [code trimWhiteSpace];
    
    if (code.length == 0) {
        
        compeletedBlock(NO,[NSError errorWithDomain:@"请填写验证码" code:1000 userInfo:nil]);
        
        return;
    }
    
    
    if (type == 1) {
        
        NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/validate.shtml";
        
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
                NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/validate.shtml";
                
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
            else if(0 == state)
            {
                compeletedBlock(NO,[NSError errorWithDomain:@"验证失败" code:1000 userInfo:nil]);
            }
        }];
        
    }
}

- (void)addRegisterWithPassword:(NSString *)password andName:(NSString *)name andCompeletedBlock:(AddRegisterBlock)compeletedBlock
{
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/addInfo.shtml";
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    [parameters setValue:password forKey:@"pwd"];
    [parameters setValue:name forKey:@"name"];
    [parameters  setValue:[NSNumber numberWithInteger:2] forKey:@"society_gender"];
    [parameters  setValue:[NSNumber numberWithInteger:2] forKey:@"physiology_gender"];
    
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            
            if (validate. result_code == 0) {
                
                [self parseData:resturnDic];
                
                compeletedBlock(YES,nil);
            }
            else
            {
                compeletedBlock(NO,[NSError errorWithDomain:validate. result_msg code:validate.result_code userInfo:nil]);
            }
        }
        else
        {
            compeletedBlock(NO,error);
        }
        
    }];
    
}


- (void)addRegisterWithPassword:(NSString *)password andName:(NSString *)name andSociety_gender:(NSInteger)society_gender andCompeletedBlock:(AddRegisterBlock)compeletedBlock
{
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/addInfo.shtml";
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    [parameters setValue:password forKey:@"pwd"];
    [parameters setValue:name forKey:@"name"];
    [parameters  setValue:[NSNumber numberWithInteger:society_gender] forKey:@"society_gender"];
    [parameters  setValue:[NSNumber numberWithInteger:0] forKey:@"physiology_gender"];
    
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            
            if (validate. result_code == 0) {
                
                [self parseData:resturnDic];
                
                compeletedBlock(YES,nil);
            }
            else
            {
                compeletedBlock(NO,[NSError errorWithDomain:validate. result_msg code:validate.result_code userInfo:nil]);
            }
        }
        else
        {
            compeletedBlock(NO,error);
        }
        
    }];
    
}
- (void)addRegisterWithPassword:(NSString *)password andName:(NSString *)name andPhysiology_gender:(NSInteger)physiology_gender andCompeletedBlock:(AddRegisterBlock)compeletedBlock
{
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/addInfo.shtml";
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    [parameters setValue:password forKey:@"pwd"];
    [parameters setValue:name forKey:@"name"];
    [parameters  setValue:[NSNumber numberWithInteger:physiology_gender] forKey:@"physiology_gender"];
    [parameters  setValue:[NSNumber numberWithInteger:0] forKey:@"society_gender"];
    
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
             LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            
            if (validate.result_code == 0) {
                
                [self parseData:resturnDic];
                
                compeletedBlock(YES,nil);
            }
            else
            {
                compeletedBlock(NO,[NSError errorWithDomain:validate. result_msg code:validate. result_code userInfo:nil]);
            }
        }
        else
        {
            compeletedBlock(NO,error);
        }
        
    }];
    
}


@end
