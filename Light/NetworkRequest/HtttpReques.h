//
//  KDHtttpReques.h
//  KDStore
//
//  Created by 郑来贤 on 14-9-24.
//  Copyright (c) 2014年 zhenglaixian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperation;


typedef void(^resultBlock)(BOOL isSuccess, NSDictionary *resturnDic, NSError *error);
typedef void(^uploadProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);

@interface HtttpReques : NSObject
{
    AFHTTPRequestOperation  *requestOperation;
}

+ (void)httpRequestWithUlr:(NSString*)urlStr andParameters:(NSDictionary *)parameters andBlock:(resultBlock)completedBlock;


+ (void)httpUploadImageData:(NSData *)imageData WithUrl:(NSString *)url andParamters:(NSDictionary *)parameters andFileKey:(NSString *)fileKey andBlock:(resultBlock)compeletedBLock andProgressBlock:(uploadProgressBlock)progressBlock;
@end
