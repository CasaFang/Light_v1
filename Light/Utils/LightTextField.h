//
//  LightTextField.h
//  
//
//  Created by FLY on 15/6/15.
//
//

#import <UIKit/UIKit.h>

static CGFloat LightTextFieldCommonVerticalPadding=10;
static CGFloat LightTextFieldCommonHorizontalPadding=10;

@interface LightTextField : UITextField

@property (nonatomic, assign) CGFloat   verticalPadding;
@property (nonatomic, assign) CGFloat   horizontalPadding;
@property (nonatomic, strong) UIColor  *placeHolderColor;

@end
