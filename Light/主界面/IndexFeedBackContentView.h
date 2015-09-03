//
//  IndexFeedBackContentView.h
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IndexFeedBackContentViewDelegate;

@interface IndexFeedBackContentView : UIView

@property (weak , nonatomic) id<IndexFeedBackContentViewDelegate> delegate;
@property (weak , nonatomic) IBOutlet UIImageView *imageView;
@property (weak , nonatomic) IBOutlet UITextView  *contentTextView;
@property (strong , nonatomic) UIImage *image;

+ (instancetype)initFromNib;

- (IBAction)onUploadPic:(UITapGestureRecognizer *)sender;

@end


@protocol IndexFeedBackContentViewDelegate <NSObject>

- (void)feedBackContentViewDidClickedUploadPic:(IndexFeedBackContentView *)v;
@end
