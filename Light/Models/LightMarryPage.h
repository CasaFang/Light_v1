//
//  LightMarryPage.h
//  Light
//
//  Created by 郑来贤 on 15/9/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LightMarryPage;

typedef void(^getMarryDetailBlock)(BOOL isSuccess , LightMarryPage *marryPage , NSError *error);

typedef void(^getMarryPicsBlock)(BOOL isSuccess , NSArray *pics, NSError *error);

typedef void(^uploadImageBlock)(BOOL isSuccess, NSError *error);
typedef void(^uploadImageProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);
typedef void(^addMarryPicBlock)(BOOL isSuccess, NSError *error);

@interface LightMarryPage : NSObject

@property (strong , nonatomic) NSString *Id;
@property (strong , nonatomic) NSString *fromUserId     ;// 申请人id
@property (strong , nonatomic) NSString *toUserId          ;//  接受人id
@property (strong , nonatomic) NSString *marryId             ;// 结婚id
@property (strong , nonatomic) NSString *title                    ;//   主题
@property (strong , nonatomic) NSString *content               ;//爱情故事
@property (strong , nonatomic) NSString *cover                      ;//封面图片url
@property (strong , nonatomic) NSString *createTime        ;//认证时间
@property (strong , nonatomic) NSString *fromUserName  ;//申请人名字
@property (strong , nonatomic) NSString *fromAvatar         ;//  申请人头像url
@property (strong , nonatomic) NSString *toUserName          ;//接收人名字
@property (strong , nonatomic) NSString *toAvatar                 ;// 接收人头像

@property (strong , nonatomic) NSArray *pics;



- (instancetype)initFromDic:(NSDictionary *)dic;

- (void)getMarryDetailWithMarryId:(NSString *)marryId andCompletedBlock:(getMarryDetailBlock )completedBlock;

- (void)getMarryPagePicksWithMarryId:(NSString *)pageId andCompletedBlock:(getMarryPicsBlock )completedBlock;

- (void)upLoadImageWithImageData:(NSData *)data andBlock:(uploadImageBlock)compeletedBLock andProgressBlock:(uploadImageProgressBlock)progressBlock;

- (void)addMarryPicWithPicId:(NSString *)picId andMarryId:(NSString *)marrayId andCompletedBlock:(addMarryPicBlock )completedBlock;


@end
