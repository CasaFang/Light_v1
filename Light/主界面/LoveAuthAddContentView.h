//
//  LoveAuthAddContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoveAuthAddContentViewDelegate;

@interface LoveAuthAddContentView : UIView

@property (weak , nonatomic) id<LoveAuthAddContentViewDelegate> delegate;
@property (strong , nonatomic) UIImage *image;

+ (instancetype)initFromNib;

@end


@protocol LoveAuthAddContentViewDelegate <NSObject>

- (void)loveAuthUploadAuth:(LoveAuthAddContentView *)v;

@end
