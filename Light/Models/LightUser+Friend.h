//
//  LightUser+Friend.h
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser.h"

extern NSString *const  LightUserAddFriendsSuccessNoti;



typedef void(^getFriendsBlock)(BOOL isSuccess ,NSArray *friends, NSError *error);
typedef void(^searchFriendsBlock)(BOOL isSuccess ,NSArray *friends, NSError *error);
typedef void(^addFriendsBlock)(BOOL isSuccess, NSError *error);
typedef void(^agreeAddFriendsBlock)(BOOL isSuccess, NSError *error);
typedef void(^getNewFriendsBlock)(BOOL isSuccess ,NSArray *newFriends , NSError *error);

@interface LightUser (Friend)

- (void)addFriend:(LightUser *)user andBlock:(addFriendsBlock)compeletedBlock;

- (void)agreeAddFriend:(LightUser *)user andBlock:(agreeAddFriendsBlock)compeletedBlock;

- (void)getFriendsWithBlock:(getFriendsBlock )compeletedBlock;

- (NSArray *)getIndexArray;

- (void)searchUserWithKey:(NSString *)key andPageSize:(NSInteger )pageSize andPageNo:(NSInteger )pageNo andBlock:(searchFriendsBlock)compeletedBlock;


- (void)getNewFriendsWithBLock:(getNewFriendsBlock)compeletedBlock;



@end
