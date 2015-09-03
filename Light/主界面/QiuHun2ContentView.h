//
//  QiuHun2ContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QiuHun2ContentViewDelegate ;

@interface QiuHun2ContentView : UIView

@property (weak , nonatomic) id<QiuHun2ContentViewDelegate> delegate;

@property (weak , nonatomic) IBOutlet UITextView *contentTextView;

@property (weak , nonatomic) IBOutlet UIView  *bgView;

+ (instancetype)initFromNib;

@end


@protocol QiuHun2ContentViewDelegate <NSObject>


@end