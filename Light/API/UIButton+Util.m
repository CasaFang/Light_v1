//
//  UIButton+Util.m
//  
//
//  Created by FLY on 15/6/14.
//
//

#import "UIButton+Util.h"

@implementation UIButton_Util

- (void) click {
    //判断_delegate实例是否实现了onClick:方法（注意方法名是"onClick:",后面有个:）
    //避免未实现ButtonDelegate的类也作为KCButton的监听
    if ([_delegate  respondsToSelector:@selector(onClick:)]){
        [_delegate onClick:self];
    }
}

@end
