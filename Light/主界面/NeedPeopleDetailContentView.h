//
//  NeedPeopleDetailContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightAccompany.h"

@protocol NeedPeopleDetailContentViewDelegate ;
@interface NeedPeopleDetailContentView : UIView

@property (weak , nonatomic) id<NeedPeopleDetailContentViewDelegate >delegate;

+ (instancetype)initFromNib;
+ (CGFloat)heightForViewWithAccompany:(LightAccompany *)accompany;
- (void)displayViewWithAccompany:(LightAccompany *)accompany;

@end

@protocol NeedPeopleDetailContentViewDelegate <NSObject>

- (void)needPeopleDetailContentView:(NeedPeopleDetailContentView *)v didSelectedIndex:(int)index;

@end
