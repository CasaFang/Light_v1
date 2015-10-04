//
//  LightMarryPage.m
//  Light
//
//  Created by 郑来贤 on 15/9/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LightMarryPage.h"
#import "networkConfig.h"
#import "ModelConfig.h"
#import "HtttpReques.h"
#import "NSString+Date.h"
#import "NSDate+NSString.h"


@implementation LightMarryPage

- (instancetype)initFromDic:(NSDictionary *)dic{

    self = [super init];
    
    if (self) {
        
        [self parseFromDic:dic];
        
    }
    return self;
}

- (void)parseFromDic:(NSDictionary *)dic{

    self.Id = Light_GetStringValueFromDicWithKey(dic, @"marryId");
    self.fromUserId = Light_GetStringValueFromDicWithKey(dic, @"fromUserId");
    self.fromUserName = Light_GetStringValueFromDicWithKey(dic, @"fromUserName");
    self.fromAvatar = Light_GetStringValueFromDicWithKey(dic, @"fromAvatar");
    self.toUserId = Light_GetStringValueFromDicWithKey(dic, @"toUserId");
    self.toAvatar = Light_GetStringValueFromDicWithKey(dic, @"toAvatar");
    self.toUserName = Light_GetStringValueFromDicWithKey(dic, @"toUserName");
    self.cover = Light_GetStringValueFromDicWithKey(dic, @"cover");
    self.title = Light_GetStringValueFromDicWithKey(dic, @"title");
    self.content = Light_GetStringValueFromDicWithKey(dic, @"content");
    self.marryId = Light_GetStringValueFromDicWithKey(dic, @"marryId");
    
    long long createTime = [Light_GetStringValueFromDicWithKey(dic, @"createTime") longLongValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:createTime/1000];
    self.createTime = [date  dateToStringWithFormat:@"yyyy年MM月dd日"];
}

- (void)getMarryDetailWithMarryId:(NSString *)marryId andCompletedBlock:(getMarryDetailBlock)completedBlock{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:marryId forKey:@"id"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/marrypage/getMarryPageById.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                [self parseFromDic:[resturnDic valueForKey:@"data"]];
                
                completedBlock(YES,self,nil);
            }
            else
            {
                completedBlock(NO,self,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            completedBlock(NO,self,error);
        }
    }];
}


- (void)getMarryPagePicksWithMarryId:(NSString *)pageId andCompletedBlock:(getMarryPicsBlock)completedBlock{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:pageId forKey:@"pageId"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/marrypagepic/getMarryPics.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                
                NSArray *pics = [resturnDic valueForKey:@"pics"];
                self.pics = pics;
                
                completedBlock(YES,pics,nil);
            }
            else
            {
                completedBlock(NO,@[],[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            completedBlock(NO,@[],error);
        }
        
    }];

}

- (void)upLoadImageWithImageData:(NSData *)data andBlock:(uploadImageBlock)compeletedBLock andProgressBlock:(uploadImageProgressBlock)progressBlock
{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[NSNumber numberWithLong:3] forKey:@"type"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/picture/upload.shtml";
    
    [HtttpReques httpUploadImageData:data WithUrl:server andParamters:parameters andFileKey:@"picture" andBlock:^(BOOL isSuccess,NSDictionary *returnDic, NSError *error) {
        
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:returnDic];
            
            if (validate.result_code == 0) {
                
                // 这个时候绑定一下
                NSString *picId = returnDic[@"pic_id"];
                
                [self addMarryPicWithPicId:picId andMarryId:[LightMyShareManager shareUser].owner.marryPageId andCompletedBlock:^(BOOL isSuccess, NSError *error) {
                   
                    if (isSuccess) {
                        
                        compeletedBLock (YES , nil);
                    }
                    else{
                    
                        compeletedBLock(NO ,error);
                    }
                }];
                
            }
            else{
                
                compeletedBLock(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else{
           
            compeletedBLock (NO, error);
        }
        
    } andProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        progressBlock(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
    }];
    
}

- (void)addMarryPicWithPicId:(NSString *)picId andMarryId:(NSString *)marrayId andCompletedBlock:(addMarryPicBlock)completedBlock{

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:marrayId forKey:@"marryPageId"];
    [parameters setValue:picId forKey:@"picId"];
    
    NSString *server = @"http://123.57.221.116:8080/light-server/intf/user/marrypagepic/addMarryPic.shtml";
    
    [HtttpReques httpRequestWithUlr:server andParameters:parameters andBlock:^(BOOL isSuccess, NSDictionary *resturnDic, NSError *error) {
        
        if (isSuccess) {
            
            LightValidateCode *validate = [[LightValidateCode alloc]initWithDic:resturnDic];
            
            if (validate.result_code == 0) {
                

                completedBlock(YES,nil);
            }
            else
            {
                completedBlock(NO,[NSError errorWithDomain:validate.result_msg code:validate.result_code userInfo:nil]);
            }
            
        }
        else
        {
            completedBlock(NO,error);
        }
        
    }];

}

@end
