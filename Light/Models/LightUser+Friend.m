//
//  LightUser+Friend.m
//  Light
//
//  Created by 郑来贤 on 15/8/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightUser+Friend.h"
#import "ModelConfig.h"
#import <UIKit/UILocalizedIndexedCollation.h>
#import <RongIMKit/RongIMKit.h>
#import "LightRongYunManager.h"
#import <RongIMKit/RongIMKit.h>


NSString *const  LightUserAddFriendsSuccessNoti = @"LightUserAddFriendsSuccessNoti";

@implementation LightUser (Friend)

- (void)addFriend:(LightUser *)user andBlock:(addFriendsBlock)compeletedBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    [parameters setValue:[NSNumber numberWithInteger:user.Id] forKey:@"to_user_id"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/friend/add.shtml";
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess)
        {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LightUserAddFriendsSuccessNoti object:nil];
                
                 [[LightRongYunManager shareManager] addToRongYunUserWithUserID:[NSString stringWithFormat:@"%ld",(long)user.Id] andUserName:user.name andUserPic:user.avatar];
                compeletedBlock(YES , nil);
            }
            
            else
            {
                compeletedBlock(NO,[NSError errorWithDomain:validate.result_msg code:validate. result_code userInfo:nil]);
            }
        }
        else{
            
            compeletedBlock(NO,error);
        }
    }];

}

- (void)searchUserWithKey:(NSString *)key andPageSize:(NSInteger)pageSize andPageNo:(NSInteger)pageNo andBlock:(searchFriendsBlock)compeletedBlock
{
    key = [key trimWhiteSpace];
    
    if (key.length == 0) {
        compeletedBlock(YES , nil,[NSError errorWithDomain:@"请输入关键字" code:1000 userInfo:nil]);
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:pageSize] forKey:@"page_size"];
    [parameters setValue:[NSNumber numberWithInteger:pageNo] forKey:@"page_no"];
    [parameters setValue:key forKey:@"key"];

    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/friend/search.shtml";
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess)
        {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            NSMutableArray *contactsArray = [NSMutableArray new];
            
            if (validate.result_code == 0) {
                
                NSArray *returnFriends = [resturnDic valueForKey:@"friends"];
                for (NSDictionary *d in returnFriends)
                {
                    
                    LightUser *user = [[LightUser alloc]initWithDic:d];
                    [contactsArray addObject:user];
                    
                   
                }
                
                compeletedBlock(YES,contactsArray,nil);

            }
            else if (validate.result_code == 1)
            {
                compeletedBlock(YES,contactsArray,[NSError errorWithDomain:@"暂无数据" code:100 userInfo:nil]);
            }
            else
            {
                compeletedBlock(NO,contactsArray,[NSError errorWithDomain:validate.result_msg code:validate. result_code userInfo:nil]);
            }
        }
        else{
        
            compeletedBlock(NO,nil,error);
        }
    }];
}

- (void)getFriendsWithBlock:(getFriendsBlock)compeletedBlock
{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/friend/list.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error)
    {
        
        if (isSuccess)
        {
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            NSMutableArray *contactsArray = [NSMutableArray new];

            if (validate.result_code == 0) {
                
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^
                {
                    
                    NSMutableArray *medels = [NSMutableArray new];
                    NSArray *returnFriends = [resturnDic valueForKey:@"friends"];
                    for (NSDictionary *d in returnFriends)
                    {
                        
                        LightUser *user = [[LightUser alloc]initWithDic:d];
                        [medels addObject:user];
                        
                         [[LightRongYunManager shareManager] addToRongYunUserWithUserID:[NSString stringWithFormat:@"%ld",(long)user.Id] andUserName:user.name andUserPic:user.avatar];
                        
                    }
                    
                    NSMutableArray *unsortedSections;
                    unsortedSections = [self convertArrayForContacts:medels];
                    
                    NSInteger count = unsortedSections.count;
                    //
                    for (int i = 0; i<count; i++)
                    {
                        NSDictionary *d = unsortedSections[i];
                        NSArray *arr = [d valueForKey:@"array"];
                        if (arr== nil || arr.count == 0)
                        {
                            
                        }
                        else
                        {
                            [contactsArray addObject:d];
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^
                    {
                        
                        compeletedBlock(YES,contactsArray,nil);
                    });
                    
                });

            }
            else if (validate.result_code == 1)
            {
                compeletedBlock(YES,contactsArray,nil);
            }
            else
            {
                compeletedBlock(NO,contactsArray,[NSError errorWithDomain:validate.result_msg code:validate. result_code userInfo:nil]);
            }
            
        }
        else
        {
            compeletedBlock(NO,nil,error);
        }
        
    }];
}

- (NSMutableArray *)convertArrayForContacts:(NSMutableArray *)tempArr
{
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    
    NSMutableArray *unsortedSections = [[NSMutableArray alloc] initWithCapacity:[[collation sectionTitles] count]];
    
    for (NSUInteger i = 0; i < [[collation sectionTitles] count]; i++)
    {
        NSString *title = [collation sectionTitles][i];
        [unsortedSections addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSMutableArray new],@"array",title,@"title", nil]];
    }
    
    //先取出名字，按名字分区。再编历把数组的元素放到指字的INDEX；
    for (int i =0;i<tempArr.count;i++)
    {
        NSInteger index = [collation sectionForObject:[tempArr objectAtIndex:i] collationStringSelector:@selector(name)];
        
        [[[unsortedSections objectAtIndex:index] valueForKey:@"array"] addObject:tempArr[i]];
        
    }
    return unsortedSections;
}

- (NSArray *)getIndexArray
{
    return [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
}


- (void)getNewFriendsWithBLock:(getNewFriendsBlock)compeletedBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/friend/new.shtml";
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess)
        {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            NSMutableArray *contactsArray = [NSMutableArray new];
            
            if (validate.result_code == 0) {
                
                NSArray *returnFriends = [resturnDic valueForKey:@"friends"];
                for (NSDictionary *d in returnFriends)
                {
                    
                    LightUser *user = [[LightUser alloc]initWithDic:d];
                    [contactsArray addObject:user];
                }
                
                compeletedBlock(YES,contactsArray,nil);
                
            }
            else if (validate.result_code == 1)
            {
                compeletedBlock(YES,contactsArray,[NSError errorWithDomain:@"暂无数据" code:100 userInfo:nil]);
            }
            else
            {
                compeletedBlock(NO,contactsArray,[NSError errorWithDomain:validate.result_msg code:validate. result_code userInfo:nil]);
            }
        }
        else{
            
            compeletedBlock(NO,nil,error);
        }
    }];

}
- (void)agreeAddFriend:(LightUser *)user andBlock:(agreeAddFriendsBlock)compeletedBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithInteger:self.Id] forKey:@"user_id"];
    [parameters setValue:[NSNumber numberWithInteger:user.req_id] forKey:@"req_id"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/friend/add/resp.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess)
        {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LightUserAddFriendsSuccessNoti object:nil];
                
                compeletedBlock(YES,nil);
                
            }
            
            else
            {
                compeletedBlock(NO,[NSError errorWithDomain:validate.result_msg code:validate. result_code userInfo:nil]);
            }
        }
        else{
            
            compeletedBlock(NO,error);
        }
    }];

}

@end
