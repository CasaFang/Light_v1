//
//  IndexAboutContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IndexAboutContentViewDelegate ;
@interface IndexAboutContentView : UIView

@property (weak , nonatomic) id<IndexAboutContentViewDelegate> delegate;

@property (weak , nonatomic) IBOutlet UILabel *versionLabel;

+ (instancetype)initFromNib;

- (IBAction)onClicked:(UIControl *)sender;

@end

@protocol IndexAboutContentViewDelegate <NSObject>

- (void)aboutContentView:(IndexAboutContentView *)v didSelectedSection:(NSInteger )section;

@end
