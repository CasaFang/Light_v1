//
//  LightUser+Change.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser+Change.h"
#import "ModelConfig.h"
#import <SMS_SDK/SMS_SDK.h>


 NSString *const  LightUserChangeNickNameSuccessNoti = @"LightUserChangeNickNameSuccessNoti";
 NSString *const  LightUserChangeSigntureSuccessNoti = @"LightUserChangeSigntureSuccessNoti";
 NSString *const  LightUserChangeAvatarSuccessNoti   = @"LightUserChangeAvatarSuccessNoti";
 NSString *const  LightUserChangePhoneSuccessNoti    = @"LightUserChangePhoneSuccessNoti";
 NSString *const  LightUserChangePWDSuccessNoti      = @"LightUserChangePWDSuccessNoti";
 NSString *const  LightUserChangeEmailSuccessNoti    = @"LightUserChangeEmailSuccessNoti";


@implementation LightUser (Change)

- (void)changeSignature:(NSString *)signture andBlock:(changeNameBlock)compeletedBlock{


    signture = [signture trimWhiteSpace];
    
    if (signture.length == 0) {
        
        compeletedBlock(NO,[NSError errorWithDomain:@"请填写签名" code:1000 userInfo:nil]);
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    [parameters setValue:signture forKey:@"description"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/change/description.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                [self parseData:resturnDic];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LightUserChangeSigntureSuccessNoti object:signture];
                
                [LightMyShareManager shareUser].owner.sigNature = signture;
                
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

- (void)changeNameWithNewName:(NSString *)newName andBlock:(changeNameBlock)compeletedBlock
{
    newName = [newName trimWhiteSpace];
    if (newName.length == 0) {
        
        compeletedBlock(NO,[NSError errorWithDomain:@"请填写昵称" code:1000 userInfo:nil]);
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    [parameters setValue:newName forKey:@"name"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/name/change.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                [self parseData:resturnDic];
                
                [LightMyShareManager shareUser].owner.name = newName;
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LightUserChangeNickNameSuccessNoti object:newName];
                
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

- (void)getUserInfoWithBlock:(getUserInfoBlock)completedBlock{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/info.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                [self parseData:resturnDic];
                
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

- (void)changeBirthday:(NSInteger)birthday andBlock:(changeNameBlock)block{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    
    [parameters setValue:[NSNumber numberWithInteger:birthday] forKey:@"birthday"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/change/birthday.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                block(YES,nil);
            }
            else
            {
                block(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            block(NO,error);
        }
        
    }];
}

- (void)changeArea:(NSString *)area andBlock:(changeNameBlock)block{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    
    [parameters setValue:area forKey:@"area"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/change/area.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                block(YES,nil);
            }
            else
            {
                block(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            block(NO,error);
        }
        
    }];
}

- (void)changePhysiology_gender:(NSInteger)physiology_gender andBlock:(changeNameBlock)block{

    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    
    [parameters setValue:[NSNumber numberWithInteger:physiology_gender] forKey:@"physiology_gender"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/change/gender.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                block(YES,nil);
            }
            else
            {
                block(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            block(NO,error);
        }
        
    }];

}

- (void)changeSociety_gender:(NSInteger)society_gender andBlock:(changeNameBlock)block
{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    
    [parameters setValue:[NSNumber numberWithInteger:society_gender] forKey:@"society_gender"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/change/gender.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                block(YES,nil);
            }
            else
            {
                block(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            block(NO,error);
        }
        
    }];

}

- (void)upLoadAvatarWithImageData:(NSData *)data andBlock:(uploadImageBlock)compeletedBLock andProgressBlock:(uploadImageProgressBlock)progressBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithLong:self.Id] forKey:@"user_id"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/avatar/change.shtml";
    
    [HtttpReques httpUploadImageData:data WithUrl:server andParamters:parameters andFileKey:@"avatar" andBlock:^(BOOL isSuccess,NSDictionary *returnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:returnDic];
            
            if (validate.result_code == 0) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LightUserChangeAvatarSuccessNoti object:data];
                
                compeletedBLock(YES , nil);
            }
            else{
                
                compeletedBLock(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else{
            
            compeletedBLock (NO, error);
        }
        
    } andProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        progressBlock(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
    }];
}

- (void)changeWithEmailCode:(NSString *)code
         andCompeletedBlock:(changeBlock)compeletedBLock
{
    code = [code trimWhiteSpace];
    
    if (code.length == 0) {
        compeletedBLock(NO,[NSError errorWithDomain:@"请填写邮箱" code:1000 userInfo:nil]);
        return;
    }
    
    if (![code isEmailFormat]) {
        
        compeletedBLock(NO,[NSError errorWithDomain:@"邮箱格式不正确" code:1000 userInfo:nil]);
        return;
    }
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/getValCode.shtml";
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithLong:self.Id] forKey:@"userId"];
    [parameters setValue:code forKey:@"email"];
    NSLog(@"入参: %@",parameters);
    
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

- (void)changeWithPhoneCode:(NSString *)code
         andCompeletedBlock:(changeBlock)compeletedBLock
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
            
            NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/changeTel.shtml";
            
            NSMutableDictionary *parameters = [NSMutableDictionary new];
            [parameters setValue:[NSNumber numberWithLong:self.Id] forKey:@"id"];
            [parameters setValue:code forKey:@"tel"];
            
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



- (void)updateEmailWithEmail:(NSString *)email  andCompletedBlock:(changeInfoBlock)completedBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setValue:[NSNumber numberWithLong:self.Id] forKey:@"id"];
    
    NSLog(@"email的值 %@",email);
    [parameters setValue:email forKey:@"email"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/changeEmail.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                [LightMyShareManager shareUser].owner.email = email;
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LightUserChangeEmailSuccessNoti object:email];

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


- (void)updatePhoneWithPhone:(NSString *)phone andCompletedBlock:(changeInfoBlock)completedBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setValue:[NSNumber numberWithLong:self.Id] forKey:@"id"];
    
    [parameters setValue:phone forKey:@"tel"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/changeTel.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                [LightMyShareManager shareUser].owner.phone = phone;
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LightUserChangePhoneSuccessNoti object:phone];
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

- (void)updatePwdWithNewPwd:(NSString *)newPwd andOriginalPwd:(NSString *)originalPwd andCompletedBlock:(changeInfoBlock)completedBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setValue:[NSNumber numberWithLong:self.Id] forKey:@"id"];
    
    [parameters setValue:newPwd forKey:@"pwd"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/changePwd.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                [LightMyShareManager shareUser].owner.password = newPwd;
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LightUserChangePWDSuccessNoti object:newPwd];
                
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
