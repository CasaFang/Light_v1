//
//  AccompanyBriefViewController.h
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AccompanyBriefViewControllerDelegate;
@interface AccompanyBriefViewController : UIViewController

@property (strong , nonatomic) NSString *brief;

@property (weak , nonatomic) id<AccompanyBriefViewControllerDelegate > delegate;

@end


@protocol AccompanyBriefViewControllerDelegate <NSObject>

- (void)AccompanyBriefViewController:(AccompanyBriefViewController *)c didSeletedBrief:(NSString *)brief;

@end
