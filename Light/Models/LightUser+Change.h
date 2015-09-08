//
//  LightUser+Change.h
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser.h"

extern NSString *const  LightUserChangeNickNameSuccessNoti;
extern NSString *const  LightUserChangeSigntureSuccessNoti;
extern NSString *const  LightUserChangeAvatarSuccessNoti;
extern NSString *const  LightUserChangePhoneSuccessNoti;
extern NSString *const  LightUserChangePWDSuccessNoti;
extern NSString *const  LightUserChangeEmailSuccessNoti;



typedef void(^changeNameBlock)(BOOL isSuccess ,NSError *error);
typedef void(^changeInfoBlock)(BOOL isSuccess ,NSError *error);
typedef void(^getUserInfoBlock)(BOOL isSuccess ,NSError *error);
typedef void(^uploadImageBlock)(BOOL isSuccess, NSError *error);
typedef void(^uploadImageProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);




@interface LightUser (Change)


- (void)changeNameWithNewName:(NSString *)newName andBlock:(changeNameBlock)compeletedBlock;

- (void)changeSignature:(NSString *)signture andBlock:(changeNameBlock)compeletedBlock;
- (void)getUserInfoWithBlock:(getUserInfoBlock )completedBlock;

- (void)changeBirthday:(NSInteger )birthday andBlock:(changeNameBlock )block;
- (void)changeArea:(NSString *)area andBlock:(changeNameBlock )block;

- (void)changePhysiology_gender:(NSInteger )physiology_gender andBlock:(changeNameBlock )block;

- (void)changeSociety_gender:(NSInteger )society_gender andBlock:(changeNameBlock )block;

- (void)upLoadAvatarWithImageData:(NSData *)data andBlock:(uploadImageBlock)compeletedBLock andProgressBlock:(uploadImageProgressBlock)progressBlock;


- (void)updateEmailWithEmail:(NSString *)email andCompletedBlock:(changeInfoBlock)completedBlock;
// phone 有值是位绑定， 为空位解绑
- (void)updatePhoneWithPhone:(NSString *)phone andCompletedBlock:(changeInfoBlock)completedBlock;

- (void)updatePwdWithNewPwd:(NSString *)newPwd andOriginalPwd:(NSString *)originalPwd andCompletedBlock:(changeInfoBlock)completedBlock;

- (void)updateUserDetailInfoWithCompletedBlock:(changeInfoBlock)completedBlock;


@end
