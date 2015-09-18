//
//  UIViewController+ImagePicker.h
//  TavelEasy
//
//  Created by 郑来贤 on 15/9/6.
//  Copyright (c) 2015年 zhenglaixian. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (ImagePicker)

/**
 *  这里只读， 不要赋值
 */
@property (strong , nonatomic) UIImagePickerController *imagePickerController;

- (UIImagePickerController *)openImagePickerWithSourceType:(UIImagePickerControllerSourceType )sourceType
                                                  andError:(NSError *__autoreleasing *)error
                                    andImagePickerDelegate:(id)delegate;



- (void)dismissImagePicker;


@end
