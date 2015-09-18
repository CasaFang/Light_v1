//
//  Accompany.m
//  Light
//
//  Created by 郑来贤 on 15/8/17.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightAccompany.h"
#import "ModelConfig.h"

NSString  * const LightAccompanyAddSuccessNoti = @"LightAccompanyAddSuccessNoti";

@implementation LightAccompany

- (instancetype)initFromDic:(NSDictionary *)dic{

    self = [super init];
    if (self) {
        
        _Id = [dic[@"id"] integerValue];
        _user_id = [dic[@"user_id"] integerValue];
        _create_time = [dic[@"create_time"] longLongValue];
        _update_time = [dic[@"update_time"] longLongValue];
        _name = dic[@"name"];
        _avatar = dic[@"avatar"];
        _brief = dic[@"description"];
        _self_tag = dic[@"self_tag"];
        _target_tag = dic[@"target_tag"];
        _picture = dic[@"picture"];
    }
    return self;
}

- (void)getAccompanyPeoplesWithPageSize:(NSInteger)pageSize andPageNo:(NSInteger)pageNo andVersion:(long)version andCompeletedBlock:(getAccompanyPeoplesBlock)compeltedBlock{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:pageSize] forKey:@"page_size"];
    [parameters setValue:[NSNumber numberWithInteger:pageNo] forKey:@"page_no"];
    [parameters setValue:[NSNumber numberWithLong:version] forKey:@"version"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/accompany/list.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            NSMutableArray *arr = [NSMutableArray new];
            
            if (validate.result_code == 0) {
                
                
                NSArray *accompanys = resturnDic[@"data"];
                
                if (accompanys && ![accompanys isKindOfClass:[NSNull class]]) {
                    
                    for (NSDictionary *d in accompanys) {
                        
                         LightAccompany*instance = [[LightAccompany alloc]initFromDic:d];
                        
                        [arr addObject:instance];
                    }
                }
                
                compeltedBlock(YES,arr,nil);
            }
            else if (validate.result_code == 1)
            {
                compeltedBlock(YES,arr,nil);
            }
            else
            {
                compeltedBlock(NO,arr,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            compeltedBlock(NO,nil,error);
        }
        
    }];
}


- (void)upLoadImageWithImageData:(NSData *)data andBlock:(uploadImageBlock)compeletedBLock andProgressBlock:(uploadImageProgressBlock)progressBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithLong:1] forKey:@"type"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/picture/upload.shtml";
    
    [HtttpReques httpUploadImageData:data WithUrl:server andParamters:parameters andFileKey:@"picture" andBlock:^(BOOL isSuccess,NSDictionary *returnDic, NSError *error) {
        
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:returnDic];
            
            if (validate.result_code == 0) {
            
                self.picId = [returnDic[@"pic_id"] integerValue];
                compeletedBLock(YES , nil);
            }
            else{
            
               compeletedBLock(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else{
        
            self.picId = -1;
            compeletedBLock (NO, error);
        }
        
    } andProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        progressBlock(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
    }];

}

- (void)saveWithBlock:(saveAccompanyBlock)compeletedBlock{

    if (self.self_tag == nil || [self.self_tag trimWhiteSpace].length == 0 )
    {
        compeletedBlock(NO,[NSError errorWithDomain:@"请填写我的标签" code:100 userInfo:nil]);
        return;
    }
    
    if (self.target_tag == nil || [self.target_tag trimWhiteSpace].length == 0 )
    {
        compeletedBlock(NO,[NSError errorWithDomain:@"请填他的的标签" code:100 userInfo:nil]);
        return;
    }
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    LightUser *user = [LightMyShareManager shareUser].owner;
    [parameters setValue:[NSNumber numberWithInteger:user.Id] forKey:@"user_id"];
    [parameters setValue:[NSNumber numberWithInteger:self.picId] forKey:@"pic_id"];
    [parameters setValue:self.self_tag forKey:@"self_tag"];
    [parameters setValue:self.target_tag forKey:@"target_tag"];
    [parameters setValue:self.brief forKey:@"description"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/accompany/publish.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                compeletedBlock(YES,nil);
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LightAccompanyAddSuccessNoti object:nil];
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
