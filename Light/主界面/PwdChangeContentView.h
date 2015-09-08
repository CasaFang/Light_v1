//
//  PwdChangeContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PwdChangeContentViewDelegate;
@interface PwdChangeContentView : UIView

@property (weak , nonatomic) IBOutlet UITextField *nPwdTextField;
@property (weak , nonatomic) IBOutlet UITextField *confirmPwdTextField;

@property (weak , nonatomic) IBOutlet UIButton  *fistBtn;
@property (weak , nonatomic) IBOutlet UIButton  *secondBtn;


@property (weak , nonatomic) id<PwdChangeContentViewDelegate >delegate;

+ (instancetype)initFromNib;

@end

@protocol PwdChangeContentViewDelegate <NSObject>

- (void)pwdChangeContentViewDidCompleted:(PwdChangeContentView *)v;

@end

