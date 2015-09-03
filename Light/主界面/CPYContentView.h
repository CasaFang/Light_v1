//
//  CPYContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPYContentViewDelegate;
@interface CPYContentView : UIView

@property (weak , nonatomic) id<CPYContentViewDelegate > delegate;

+ (instancetype)initFromNib;

@end

@protocol CPYContentViewDelegate <NSObject>

- (void)cpyContentView:(CPYContentView *)v didSelectedSectionIndex:(NSInteger )section;

@end
