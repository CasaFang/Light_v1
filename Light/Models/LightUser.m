//
//  User.m
//  Light
//
//  Created by 郑来贤 on 15/7/30.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser.h"
#import "HtttpReques.h"
#import "NSString+Extention.h"
#import "ModelConfig.h"
#import <SMS_SDK/SMS_SDK.h>


@interface LightUser ()


@end

@implementation LightUser



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
        _Id = [Id integerValue];
    }
    
    NSString *Id1 = Light_GetStringValueFromDicWithKey(dic, @"id");
    if (![Id1 isEqualToString:@""]&&Id1) {
        _Id = [Id1 integerValue];
    }
    
    NSString *physiology_gender = Light_GetStringValueFromDicWithKey(dic, @"physiology_gender");
    
    if (![physiology_gender isEqualToString:@""]&&physiology_gender) {
        
        _physiology_gender = [physiology_gender integerValue];
    }
    
    NSString *society_gender = Light_GetStringValueFromDicWithKey(dic, @"society_gender");
    if (![society_gender isEqualToString:@""]&&society_gender) {
        _society_gender = [society_gender integerValue];
    }
    NSString *req_id = Light_GetStringValueFromDicWithKey(dic, @"req_id");
    if (![req_id isEqualToString:@""]&&req_id) {
        _req_id = [req_id integerValue];
    }
    NSString *status = Light_GetStringValueFromDicWithKey(dic, @"status");
    if (![status isEqualToString:@""]&&status) {
        _status = [status integerValue];
    }
    
    NSString *area = Light_GetStringValueFromDicWithKey(dic, @"area");
    if (![area isEqualToString:@""]&&area) {
        _area = area;
    }
    NSString *sigNature = Light_GetStringValueFromDicWithKey(dic, @"description");
    if (![sigNature isEqualToString:@""]&&sigNature) {
        _sigNature = sigNature;
    }
    NSString *birthday = Light_GetStringValueFromDicWithKey(dic, @"birthday");
    if (![birthday isEqualToString:@""]&&birthday) {
        _birthday = [birthday integerValue];
    }
    NSString *email = Light_GetStringValueFromDicWithKey(dic, @"email");
    if (![email isEqualToString:@""]&&email) {
        self.email = email;
    }
    NSString *phone = Light_GetStringValueFromDicWithKey(dic, @"tel");
    if (![phone isEqualToString:@""]&&phone) {
        self.phone = phone;
    }
    NSString *marryId = Light_GetStringValueFromDicWithKey(dic, @"marryId");
    if (![marryId isEqualToString:@""]&&marryId) {
        self.marryId = marryId;
    }
    NSString *marryPageId = Light_GetStringValueFromDicWithKey(dic, @"marryPageId");
    if (![marryPageId isEqualToString:@""]&&marryPageId) {
        self.marryPageId = marryPageId;
    }

}


- (void)setPhone:(NSString *)phone{

    _phone =  phone;
    [[NSUserDefaults standardUserDefaults] setValue:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)setEmail:(NSString *)email{

    _email =  email;
    [[NSUserDefaults standardUserDefaults] setValue:email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setPassword:(NSString *)password{

    _password = password;
    [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (void)setLogin:(BOOL)login{

    _login = login;
    
    [[NSUserDefaults standardUserDefaults] setBool:login forKey:@"login"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    
    if (self) {
        
        [self parseData:dic];
        
    }
    return self;
}


- (NSString *)getSexWithSexType:(NSInteger )sexType{

    if (sexType == 0) {
        return @"女";
    }
    if (sexType == 1) {
        return @"男";
    }
    return @"其他";
}


@end
