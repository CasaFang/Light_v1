//
//  IndexAccountContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IndexAccountContentViewDelegate ;
@interface IndexAccountContentView : UIView

@property (weak , nonatomic) id<IndexAccountContentViewDelegate > delegate;

- (IBAction)onClicked:(UIControl *)sender;

+ (instancetype)initFromNib;

@end

@protocol IndexAccountContentViewDelegate <NSObject>

- (void)accountContentView:(IndexAccountContentView *)v didSelectedSection:(NSInteger )section;

@end
