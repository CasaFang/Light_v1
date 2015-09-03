//
//  LightValidateCode.h
//  
//
//  Created by FLY on 15/6/14.
//
//

#import <Foundation/Foundation.h>

@interface LightValidateCode : NSObject

@property (nonatomic, assign)   NSInteger result_code;
@property (nonatomic, strong)   NSString *result_msg;
@property (nonatomic, assign)   NSInteger sys_code;
@property (nonatomic, strong)   NSString *sys_msg;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
