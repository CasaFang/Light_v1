//
//  AuthDetailContentView.h
//  Light
//
//  Created by 郑来贤 on 15/9/19.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightMarryPage.h"

@protocol AuthDetailContentViewDelegate;
@interface AuthDetailContentView : UIView

@property (weak , nonatomic) id<AuthDetailContentViewDelegate >delegate;

+ (instancetype)initFromNib;

- (void)displayWithMarryPage:(LightMarryPage *)marryPage;

-(void)disMarryPagePicsWithPics:(NSArray *)pics;

- (void)setMarryEditIng:(BOOL )isEditing;

@end

@protocol AuthDetailContentViewDelegate <NSObject>

- (void)authDetailContentViewDidClickedPic:(AuthDetailContentView *)v andPicArray:(NSArray *)pics andCurrentIndex:(NSIndexPath *)path;
- (void)authDetailContentViewDidClickedPicAdd:(AuthDetailContentView *)v ;

@end
