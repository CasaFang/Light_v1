//
//  LightUser+Register.h
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser.h"

typedef void(^registerBlock)(BOOL isSuccess,  NSError *error);
typedef void(^AddRegisterBlock)(BOOL isSuccess, NSError *error);
typedef void(^validateBlock)(BOOL isSuccess, NSError *error);
typedef void(^changeBlock)(BOOL isSuccess, NSError *error);

@interface LightUser (Register)

- (void)validateCodeWithCode:(NSString *)code
                   checkType:(int)type
          andCompeletedBlock:(validateBlock)compeletedBlock;


- (void)registerWithEmailCode:(NSString *)code
           andCompeletedBlock:(registerBlock)compeletedBLock;

- (void)registerWithPhoneCode:(NSString *)code
           andCompeletedBlock:(registerBlock)compeletedBLock;

- (void)ChangeWithEmailCode:(NSString *)code
           andCompeletedBlock:(changeBlock)compeletedBLock;

- (void)ChangeWithPhoneCode:(NSString *)code
           andCompeletedBlock:(changeBlock)compeletedBLock;


- (void)addRegisterWithPassword:(NSString *)password
                        andName:(NSString *)name
             andCompeletedBlock:(AddRegisterBlock)compeletedBlock;

- (void)addRegisterWithPassword:(NSString *)password
                        andName:(NSString *)name
           andPhysiology_gender:(NSInteger)physiology_gender
             andCompeletedBlock:(AddRegisterBlock)compeletedBlock;

- (void)addRegisterWithPassword:(NSString *)password
                        andName:(NSString *)name
              andSociety_gender:(NSInteger)society_gender
             andCompeletedBlock:(AddRegisterBlock)compeletedBlock;

@end
