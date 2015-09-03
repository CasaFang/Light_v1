//
//  MainArticleDetailContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightArticle.h"

@protocol MainArticleDetailContentViewDelegate;
@interface MainArticleDetailContentView : UIView


@property (weak , nonatomic) id<MainArticleDetailContentViewDelegate> delegate;

+(instancetype)initFromNib;


- (void)displayContentView:(LightArticle *)article;

+ (CGFloat)heightForContentViewWithArticle:(LightArticle *)article;



@end

@protocol MainArticleDetailContentViewDelegate <NSObject>

-(void)articleDetailContentViewDidBack:(MainArticleDetailContentView *)v;
-(void)articleDetailContentViewDidGeiMoney:(MainArticleDetailContentView *)v;

@end
