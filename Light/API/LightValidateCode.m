//
//  LightValidateCode.m
//  
//
//  Created by FLY on 15/6/14.
//
//

#import "LightValidateCode.h"
#import "ModelConfig.h"

@implementation LightValidateCode

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        
        NSString *result_code = Light_GetStringValueFromDicWithKey(dic, @"result_code");
        if (![result_code isEqualToString:@""]) {
            _result_code = [result_code integerValue];
        }
        
        NSString *result_msg = Light_GetStringValueFromDicWithKey(dic, @"result_msg");
        if (![result_msg isEqualToString:@""]) {
            _result_msg = result_msg;
        }
        
        NSString *sys_code = Light_GetStringValueFromDicWithKey(dic, @"sys_code");
        if (![sys_code isEqualToString:@""]) {
            _sys_code = [sys_code integerValue];
        }
        
        NSString *sys_msg = Light_GetStringValueFromDicWithKey(dic, @"sys_msg");
        if (![sys_msg isEqualToString:@""]) {
            _sys_msg = sys_msg;
        }

    }
    return self;
}

@end
