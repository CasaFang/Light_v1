//
//  AvatarEditViewController.m
//  Light
//
//  Created by 郑来贤 on 15/9/1.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AvatarEditViewController.h"
#import "AvatarEditContentView.h"
#import <RSKImageCropper.h>
#import "LightUser+Change.h"
#import "LightMyShareManager.h"
#import "UIView+Hud.h"
#import "AppDelegate.h"

@interface AvatarEditViewController ()<AvatarEditContentViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,RSKImageCropViewControllerDelegate>
{
    AvatarEditContentView *contentView;
    UIImagePickerController *imagePickerController;
    UIImage  *_croppedImage;
}

@end

@implementation AvatarEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改头像";
    
    [self buildUI];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    contentView.avatarImageView.image = _avatarImage;
}

#pragma mark -- actions
- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    
    
    contentView = [AvatarEditContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = CGSizeMake(0, contentView.frame.size.height);
}

- (void)back:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate resetRevealController];
}

#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1: //相机
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2: //相册
                    return;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                 sourceType =UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else {
                return;
            }
        }
        // 跳转到相机或相册页面
        if (imagePickerController == nil) {
            
            imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
        }
       
        //        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
    
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        [self openCropperImageViewControllerWithImage:image];
    }];
}

- (void)openCropperImageViewControllerWithImage:(UIImage *)image

{
    RSKImageCropViewController *cropViewController = [[RSKImageCropViewController alloc]initWithImage:image cropMode:RSKImageCropModeCircle];
    cropViewController.delegate = self;
    cropViewController.applyMaskToCroppedImage = YES;
    [self presentViewController:cropViewController animated:YES completion:nil];
}

#pragma mark - RSKImageCropViewControllerDelegate

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect
{
    _croppedImage = croppedImage;
    
    contentView.avatarImageView.image = _croppedImage;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [self httpUploadImageWithImageData:UIImageJPEGRepresentation(_croppedImage, .5) andCropImage:croppedImage];
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)cropImageCanclePickerImage
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)httpUploadImageWithImageData:(NSData *)imageData andCropImage:(UIImage *)cropImage
{
    [self.view showHudWithText:@"请稍等..."];
    [[LightMyShareManager shareUser].owner upLoadAvatarWithImageData:imageData andBlock:^(BOOL isSuccess, NSError *error) {
        [self.view hideHud];
        
        if (isSuccess) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
        
            [self.view showTipAlertWithContent:error.domain];
        }
    } andProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
        [ self.view showProgress:(CGFloat)totalBytesWritten/totalBytesExpectedToWrite status:@"正在上传..."];
    }];
}

#pragma mark --AvatarEditContentViewDelegate

- (void)avatarEditContentViewDidClickedEditAvatar:(AvatarEditContentView *)v
{
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册中选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册中选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}


@end
