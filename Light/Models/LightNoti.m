//
//  LightNoti.m
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightNoti.h"
#import "LightMyShareManager.h"
#import "LightUser.h"
#import "ModelConfig.h"
#import "networkConfig.h"

@implementation LightNoti


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
    
    NSString *Id = Light_GetStringValueFromDicWithKey(dic, @"id");
    if (![Id isEqualToString:@""]&&Id) {
        _Id = [Id integerValue];
    }
    
    NSString *type = Light_GetStringValueFromDicWithKey(dic, @"type");
    if (![type isEqualToString:@""]&&type) {
        _type = [type integerValue];
    }
    
    NSString *create_time = Light_GetStringValueFromDicWithKey(dic, @"create_time");
    if (![create_time isEqualToString:@""]&&create_time) {
        _create_time = [create_time longLongValue];
    }
    
    NSString *update_time = Light_GetStringValueFromDicWithKey(dic, @"update_time");
    if (![update_time isEqualToString:@""]&&update_time) {
        _update_time = [update_time longLongValue];
    }

    if (_type == 3|| _type == 4) {
        
        _notiObject = [[LightMarry alloc]initFromDic:dic[@"data"]];
    }
}

- (NSString *)getTypeStatusStringValue{

    if (_type == 3) {
        
        return @"求婚请求";
    }
    if (_type == 4) {
        
        return @"求婚回复";
    }
    return nil;
}

- (void)getNotisBlock:(getNotisBlock)compeletedBlock{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger: [LightMyShareManager shareUser].owner.Id] forKey:@"user_id"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/notice/list.shtml";
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess)
        {
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            NSMutableArray *notiArray = [NSMutableArray new];
            
            if (validate.result_code == 0) {
                
                NSArray *array =  [resturnDic valueForKey:@"notice_data"];
                
                for (NSDictionary *d in array) {
                    
                    LightNoti *noti = [[LightNoti alloc]initFromDic:d];
                    [notiArray addObject:noti];
                }
                compeletedBlock(YES , notiArray, nil);
                
            }
            else
            {
                compeletedBlock(NO,notiArray,[NSError errorWithDomain:validate.result_msg code:validate. result_code userInfo:nil]);
            }
            
        }
        else
        {
            compeletedBlock(NO,nil,error);
        }
        
    }];

}

@end

@implementation LightMarry

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
    
    NSString *Id = Light_GetStringValueFromDicWithKey(dic, @"id");
    if (![Id isEqualToString:@""]&&Id) {
        _Id = [Id integerValue];
    }
    
    NSString *marryerName = Light_GetStringValueFromDicWithKey(dic, @"from_user_name");
    
    if (![marryerName isEqualToString:@""]&&marryerName) {
        _marryerName = marryerName;
    }
    
    NSString *marryerId = Light_GetStringValueFromDicWithKey(dic, @"from_user_id");
    if (![marryerId isEqualToString:@""]&&marryerId) {
        _marryerId = [marryerId integerValue];
    }
    
    NSString *marryerAvatar = Light_GetStringValueFromDicWithKey(dic, @"from_user_avatar");
    if (![marryerAvatar isEqualToString:@""]&&marryerAvatar) {
        _marryerAvatar = marryerAvatar;
    }
    
    
    NSString *marryedName = Light_GetStringValueFromDicWithKey(dic, @"to_user_avatar");
    
    if (![marryedName isEqualToString:@""]&&marryedName) {
        _marryedName = marryedName;
    }
    
    NSString *marryedId = Light_GetStringValueFromDicWithKey(dic, @"to_user_avatar");
    if (![marryedId isEqualToString:@""]&&marryedId) {
        _marryedId = [marryedId integerValue];
    }
    
    NSString *marryedAvatar = Light_GetStringValueFromDicWithKey(dic, @"to_user_avatar");
    if (![marryedAvatar isEqualToString:@""]&&marryedAvatar) {
        _marryedAvatar = marryedAvatar;
    }
    
    
    
    NSString *status = Light_GetStringValueFromDicWithKey(dic, @"status");
    if (![status isEqualToString:@""]&&status) {
        _status = [status integerValue];
    }
    
    NSString *create_time = Light_GetStringValueFromDicWithKey(dic, @"create_time");
    if (![create_time isEqualToString:@""]&&create_time) {
        _create_time = [create_time longLongValue];
    }
    NSString *update_time = Light_GetStringValueFromDicWithKey(dic, @"update_time");
    if (![update_time isEqualToString:@""]&&update_time) {
        _update_time = [update_time longLongValue];
    }
    
}

- (NSString *)getMarryStatusStringValue{
    
    if (self.status == -1) {
        return @"已拒接";
    }
    if (self.status == 0) {
        return @"已发送";
    }
    if (self.status == 1) {
        return @"已同意";
    }
    return nil;
}


@end
