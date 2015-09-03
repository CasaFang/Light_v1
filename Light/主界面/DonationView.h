//
//  DonationView.h
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightCloseKeyboardView.h"
@protocol DonationViewDelegate;

@interface DonationView : LightCloseKeyboardView

@property (weak , nonatomic) id<DonationViewDelegate> delegate;

+ (instancetype)initFromNib;


@end

@protocol DonationViewDelegate <NSObject>



@end