//
//  LoveContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoveContentViewDelegate;

@interface LoveContentView : UIView

@property (weak , nonatomic) id<LoveContentViewDelegate> delegate;

+ (instancetype)initFromNib;

@end

@protocol LoveContentViewDelegate <NSObject>

- (void)loveContentView:(LoveContentView *)v didSelectedSection:(NSInteger )section;

@end
