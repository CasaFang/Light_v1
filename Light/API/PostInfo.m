//
//  PostInfo.m
//  
//
//  Created by FLY on 15/6/17.
//
//

#import "PostInfo.h"
#import <UIKit/UIKit.h>

@implementation PostInfo

-(void)postInfo:(NSDictionary *)info infourl:(NSURL *)url{
    NSError *error;
    //创建data数据
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&error];
    //NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
    
    //创建请求
    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:url];
    
    [requst setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requst setHTTPMethod:@"POST"];
    [requst setHTTPBody:jsonData];
    
    //连接服务器
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:requst delegate:self];
    if (connection){
        _receivedData = [[NSMutableData alloc]init];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"连接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    /*
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:requst queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSString *error1 = dict[@"error"];
            if(error1){
                NSLog(@"连接失败 %@",error1);
            }
            else
            {
                NSString *success = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"连接成功 %@",success);
                
                _result = dict;
            }
        }else{
            NSLog(@"connection error");
        }
    }];
     */
}

#pragma mark - connection
//接受相应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"%@",[res allHeaderFields]);
    _receivedData = [NSMutableData data];
}

//接收到数据
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_receivedData appendData:data];
}

//数据加载完毕
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    _result = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingMutableLeaves error:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"postResult" object:_result];
    NSLog(@"%@",[_result description]);
}

//数据加载失败
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"%@",[error localizedDescription]);
}
@end
