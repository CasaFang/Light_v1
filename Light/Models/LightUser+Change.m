//
//  LightUser+Change.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser+Change.h"
#import "ModelConfig.h"


 NSString *const  LightUserChangeNickNameSuccessNoti = @"LightUserChangeNickNameSuccessNoti";
 NSString *const  LightUserChangeSigntureSuccessNoti = @"LightUserChangeSigntureSuccessNoti";
 NSString *const  LightUserChangeAvatarSuccessNoti   = @"LightUserChangeAvatarSuccessNoti";



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

- (void)updateEmailWithEmail:(NSString *)email{


}

@end
