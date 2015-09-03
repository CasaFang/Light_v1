//
//  LightTextField.m
//  
//
//  Created by FLY on 15/6/15.
//
//

#import "LightTextField.h"

@implementation LightTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDeaultValue];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initDeaultValue];
    }
    return self;
}

- (void)initDeaultValue{

    _placeHolderColor = [UIColor lightGrayColor];
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , _horizontalPadding , _verticalPadding );
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , _horizontalPadding , _verticalPadding );
}

//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    if (_placeHolderColor) {
        
        [[self placeholder] drawInRect:rect withAttributes:@{NSForegroundColorAttributeName:_placeHolderColor}];
        
    }
    
}

@end
