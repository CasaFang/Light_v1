//
//  MarryCertificationContentView.h
//  Light
//
//  Created by 郑来贤 on 15/9/4.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightMarryPage.h"

@protocol MarryCertificationContentViewDelegate;
@interface MarryCertificationContentView : UIView

+ (instancetype)initFromNib;

- (IBAction)onBack:(id)sender;

@property (weak , nonatomic) id<MarryCertificationContentViewDelegate >delegate;

- (void)displayWithMarryPage:(LightMarryPage *)marryPage;


-(void)disMarryPagePicsWithPics:(NSArray *)pics;


@end


@protocol MarryCertificationContentViewDelegate <NSObject>

- (void)marryCertificationContentViewDidBack:(MarryCertificationContentView *)v;
- (void)marryCertificationContentViewDidAddPic:(MarryCertificationContentView *)v;
- (void)marryCertificationContentViewDidClickedPic:(MarryCertificationContentView *)v andPicArray:(NSArray *)pics andCurrentIndex:(NSIndexPath *)path;


@end
