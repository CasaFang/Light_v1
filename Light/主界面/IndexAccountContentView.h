//
//  IndexAccountContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightUser.h"
@protocol IndexAccountContentViewDelegate ;
@interface IndexAccountContentView : UIView

@property (weak , nonatomic) id<IndexAccountContentViewDelegate > delegate;

@property (weak , nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak , nonatomic) IBOutlet UILabel *emailLabel;
@property (weak , nonatomic) IBOutlet UILabel *Label;

- (IBAction)onClicked:(UIControl *)sender;

- (void)displayViewUser:(LightUser *)user;

+ (instancetype)initFromNib;

@end

@protocol IndexAccountContentViewDelegate <NSObject>

- (void)accountContentView:(IndexAccountContentView *)v didSelectedSection:(NSInteger )section;

@end
