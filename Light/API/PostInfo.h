//
//  PostInfo.h
//  
//
//  Created by FLY on 15/6/17.
//
//

#import <Foundation/Foundation.h>

@interface PostInfo : NSObject
@property (nonatomic,assign) NSDictionary *info;
@property (nonatomic,assign) NSURL *url;

@property (nonatomic,assign) NSDictionary *result;
@property (nonatomic,strong) NSMutableData *receivedData;


-(void)postInfo:(NSDictionary *)info infourl:(NSURL *)url;

@end
