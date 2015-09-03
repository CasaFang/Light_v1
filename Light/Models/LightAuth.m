//
//  LightAuth.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightAuth.h"
#import "ModelConfig.h"

@implementation LightAuth

- (instancetype)initFromDic:(NSDictionary *)dic
{

    if (self = [super init]) {
        
        [self parseData:dic];
    }
    return self;
}


- (void)parseData:(NSDictionary *)dic
{
    NSString *Id1 = Light_GetStringValueFromDicWithKey(dic, @"id");
    if (![Id1 isEqualToString:@""]&&Id1) {
        _Id = [Id1 integerValue];
    }
    
    NSString *title = Light_GetStringValueFromDicWithKey(dic, @"title");
    
    if (![title isEqualToString:@""]&&title) {
        _title = title;
    }
    
    NSString *pic = Light_GetStringValueFromDicWithKey(dic, @"pic");
    if (![pic isEqualToString:@""]&&pic) {
        _pic = pic;
    }
    
    self.create_time = [dic[@"create_time"] longValue];
    self.update_time = [dic[@"update_time"] longValue];
    self.brief = dic[@"description"];
    self.content = dic[@"content"];
}

- (void)getAuthsWithPageSize:(NSInteger)pageSize andPageNo:(NSInteger)pageNo andVersion:(long)version andCompeletedBlock:(getAuthsBlock)compeltedBlock
{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:pageSize] forKey:@"page_size"];
    [parameters setValue:[NSNumber numberWithInteger:pageNo] forKey:@"page_no"];
//    [parameters setValue:[NSNumber numberWithLong:version] forKey:@"version"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/certificate/list.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            NSMutableArray *arr = [NSMutableArray new];
            
            if (validate.result_code == 0) {
                
                NSArray *certificates = resturnDic[@"certificates"];
                
                if (certificates && ![certificates isKindOfClass:[NSNull class]]) {
                    
                    for (NSDictionary *d in certificates) {
                        
                        LightAuth *instance = [[LightAuth alloc]initFromDic:d];
                        
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

@end
