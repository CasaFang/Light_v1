//
//  LoveQiuHunContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoveQiuHunContentViewDelegate ;
@interface LoveQiuHunContentView : UIView

@property (weak , nonatomic) id<LoveQiuHunContentViewDelegate >delegate;

- (IBAction)onQiuHun:(id)sender;

+ (instancetype)initFromNib;

@end

@protocol LoveQiuHunContentViewDelegate <NSObject>

- (void)loveQiuHunContentViewDidQiuHun:(LoveQiuHunContentView *)v;

@end
