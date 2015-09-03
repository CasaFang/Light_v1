//
//  QiuHun1ContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QiuHun1ContentViewDelegate ;
@interface QiuHun1ContentView : UIView

@property (weak , nonatomic) id<QiuHun1ContentViewDelegate> delegate;
@property (weak , nonatomic) IBOutlet UITextField  *nameLabel;
+ (instancetype)initFromNib;

- (IBAction)onCLIcKedSelectUser:(id)sender;

@end


@protocol QiuHun1ContentViewDelegate  <NSObject>

- (void)qiuHun1ContentViewDidClickedSelectedUser:(QiuHun1ContentView *)v;

@end
