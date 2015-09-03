//
//  User.h
//  Light
//
//  Created by 郑来贤 on 15/7/30.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LightUser : NSObject

@property (strong , nonatomic) NSString   *name;
@property (strong , nonatomic) NSString   *avatar;
@property (assign , nonatomic) NSInteger  Id;
@property (assign , nonatomic) NSInteger  physiology_gender;
@property (assign , nonatomic) NSInteger  society_gender;
@property (assign , nonatomic) NSInteger  birthday;

@property (strong , nonatomic) NSString   *area;
@property (strong , nonatomic) NSString   *sigNature;




// 用户注册用的密码
@property (strong , nonatomic) NSString   *password;

// 添加好友的时候用到

@property (assign , nonatomic) NSInteger req_id;

//状态，0:对方已请求，自己未同意；1:已经成功添加好友
@property (assign , nonatomic) NSInteger status;

- (instancetype)initWithDic:(NSDictionary *)dic;

- (void)parseData:(NSDictionary *)dic;


- (NSString *)getSexWithSexType:(NSInteger )sexType;



@end
