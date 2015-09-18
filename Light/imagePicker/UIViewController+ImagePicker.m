//
//  UIViewController+ImagePicker.m
//  TavelEasy
//
//  Created by 郑来贤 on 15/9/6.
//  Copyright (c) 2015年 zhenglaixian. All rights reserved.
//

#import "UIViewController+ImagePicker.h"
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>

@implementation UIViewController (ImagePicker)

#pragma mark - imagePickerController
static const char CustomimagePickerController = '\0';
- (void)setImagePickerController:(UIImagePickerController *)imagePickerController
{
    if (imagePickerController != self.imagePickerController) {
        // 存储新的
        [self willChangeValueForKey:@"imagePickerController"]; // KVO
         objc_setAssociatedObject(self, &CustomimagePickerController,
                                 imagePickerController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"imagePickerController"]; // KVO
    }
}

- (UIImagePickerController *)imagePickerController
{
    return objc_getAssociatedObject(self, &CustomimagePickerController);
}


- (UIImagePickerController *)openImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType andError:(NSError *__autoreleasing *)error andImagePickerDelegate:(id)delegate{

    if (!self.imagePickerController) {
        
        self.imagePickerController = [[UIImagePickerController alloc]init];
        self.imagePickerController.delegate  = delegate;
    }
    
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        
        *error = [NSError errorWithDomain:@"当前设备不支持sourceType" code:1000 userInfo:nil];
        
        NSLog(@"%@",*error);
    }
    // 照片不需要检查， 系统帮我们做了检查和提醒
    if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary|| sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
        
    }
    else if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        [self checkauthStatusWithSourceType:AVMediaTypeVideo andDelegate:delegate];
    }
    self.imagePickerController.sourceType = sourceType;
    
    [self presentViewController:self.imagePickerController animated:YES completion:^{
        
    }];
    
    return self.imagePickerController;
}

- (void)dismissImagePicker{

    [self.imagePickerController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)checkauthStatusWithSourceType:(NSString *)mediaType andDelegate:(id)delegate {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        NSLog(@"相机权限受限");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请在设备的\"设置-隐私-相机\"中允许访问相机。"
                                                       delegate:delegate
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    else if (authStatus == AVAuthorizationStatusAuthorized){
    
    
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined)
    {
    
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted)
        {
            if(granted)
            {
                //点击允许访问时调用
                //用户明确许可与否，媒体需要捕获，但用户尚未授予或拒绝许可。
                NSLog(@"Granted access to %@", mediaType);
            }
            else {
                
                NSLog(@"Not granted access to %@", mediaType);
                
                [self dismissImagePicker];
                
                return ;
            }
            
        }];
    }
    else{
    
        [NSException raise:@"相机权限问题" format:nil];
        return;
    }
}

@end
