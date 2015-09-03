//
//  KDHtttpReques.m
//  KDStore
//
//  Created by 郑来贤 on 14-9-24.
//  Copyright (c) 2014年 zhenglaixian. All rights reserved.
//

#import "HtttpReques.h"
#import <AFNetworking.h>
#import "networkConfig.h"


@implementation HtttpReques

+ (void)httpRequestWithUlr:(NSString *)urlStr andParameters:(NSDictionary *)parameters andBlock:(resultBlock)completedBlock
{
    HtttpReques *instance = [[self alloc]init];

    // 如果上一个请求还没有完成,则取消上一个请求，从下开始下一个请求
    if (instance->requestOperation) {
        [instance->requestOperation cancel];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/xml", nil] ;
    
    instance->requestOperation = [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completedBlock(YES,responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        completedBlock(NO,nil,error);
    }];
    
    
}

+ (void)httpUploadImageData:(NSData *)imageData WithUrl:(NSString *)urlStr andParamters:(NSDictionary *)parameters andFileKey:(NSString *)fileKey andBlock:(resultBlock)compeletedBLock andProgressBlock:(uploadProgressBlock)progressBlock{

    
    HtttpReques *instance = [[self alloc]init];
    
    // 如果上一个请求还没有完成,则取消上一个请求，从下开始下一个请求
    if (instance->requestOperation) {
        [instance->requestOperation cancel];
    }

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 120;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json", nil] ;
    
   instance->requestOperation = [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
         [formData appendPartWithFileData:imageData name:fileKey fileName:@"11" mimeType:@"file"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        compeletedBLock(YES,responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         compeletedBLock(NO,nil,error);
    }];
    
    [instance->requestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        progressBlock(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
    }];

}

@end
