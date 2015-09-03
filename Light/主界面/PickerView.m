//
//  PickerView.m
//  Light
//
//  Created by 郑来贤 on 15/8/30.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "PickerView.h"
#import "LightAddress.h"
#import "NSDate+NSString.h"

@interface PickerView ()

@property (weak , nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak , nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak , nonatomic) IBOutlet UILabel      *selectedValueLabel;


- (IBAction)onCLickedOK:(id)sender;
- (IBAction)onClickekCancel:(id)sender;

- (IBAction)pickerValueChanged:(id)sender;

@end

@implementation PickerView

+ (instancetype)initFromNib
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"PickerView" owner:self options:nil];
    return arr[0];
}

- (void)setCurrentDate:(NSDate *)date{

    [_datePicker setDate:date animated:YES];
}

- (void)onCLickedOK:(id)sender{

    NSString *str = [_datePicker.date dateToStringWithFormat:@"YYYYMMdd"];
    
    if ([_delegate respondsToSelector:@selector(picker:didSelectedValue:)]) {
        [_delegate picker:self didSelectedValue:str];
    }
}
- (void)onClickekCancel:(id)sender{

    if ([_delegate respondsToSelector:@selector(pickerDidCancle:)]) {
        [_delegate pickerDidCancle:self];
    }
}

- (void)displayPicker:(BOOL)isDatePicker withPickerArray:(NSArray *)pickerArray
{
    if (!isDatePicker) {
        
        _pickerView.hidden = NO;
        _datePicker.hidden = YES;
        
    }
    else{
    
        _pickerView.hidden = YES;
        _datePicker.hidden = NO;
    }
}

- (void)pickerValueChanged:(id)sender{

}


#pragma mark -- picker delegate and datesource


@end
