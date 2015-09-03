//
//  PickerView.h
//  Light
//
//  Created by 郑来贤 on 15/8/30.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewDelegate ;
@interface PickerView : UIView

@property (weak , nonatomic) id<PickerViewDelegate >delegate;

+ (instancetype)initFromNib;

- (void)setCurrentDate:(NSDate *)date;

@end

@protocol PickerViewDelegate <NSObject>

- (void)picker:(PickerView *)view didSelectedValue:(NSString *)value;
- (void)pickerDidCancle:(PickerView *)view;

@end
