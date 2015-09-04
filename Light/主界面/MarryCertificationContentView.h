//
//  MarryCertificationContentView.h
//  Light
//
//  Created by 郑来贤 on 15/9/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MarryCertificationContentViewDelegate;
@interface MarryCertificationContentView : UIView

+ (instancetype)initFromNib;

- (IBAction)onBack:(id)sender;

@property (weak , nonatomic) id<MarryCertificationContentViewDelegate >delegate;

@end


@protocol MarryCertificationContentViewDelegate <NSObject>

- (void)marryCertificationContentViewDidBack:(MarryCertificationContentView *)v;

@end
