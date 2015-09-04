//
//  LightNoti.h
//  Light
//
//  Created by 郑来贤 on 15/8/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^getNotisBlock)(BOOL isSuccess , NSArray *notis,NSError *error);
@interface LightNoti : NSObject


@property (nonatomic , assign) NSInteger Id;
@property (nonatomic , assign) long create_time;
@property (nonatomic , assign) long update_time;

//type int 通知类型：3求婚请求，4求婚回复
@property (nonatomic , assign) NSInteger type;

@property (nonatomic , strong) id notiObject;


- (NSString *)getTypeStatusStringValue;


- (void)getNotisBlock:(getNotisBlock)compeletedBlock;

@end

@interface LightMarry : NSObject;

@property (nonatomic , assign) NSInteger Id;

// 求婚者信息
@property (nonatomic , strong) NSString *marryerName;
@property (nonatomic , assign) NSInteger marryerId;
@property (nonatomic , strong) NSString *marryerAvatar;

// 被求婚者信息
@property (nonatomic , strong) NSString *marryedName;
@property (nonatomic , assign) NSInteger marryedId;
@property (nonatomic , strong) NSString *marryedAvatar;

// 求婚的话
@property (nonatomic , strong) NSString *content;

//status int 求婚状态：-1已拒接，0已发送，1已同意
@property (nonatomic , assign) NSInteger status;
@property (nonatomic , assign) long create_time;
@property (nonatomic , assign) long update_time;

- (NSString *)getMarryStatusStringValue;

- (instancetype)initFromDic:(NSDictionary *)d;

@end
