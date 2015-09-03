//
//  LoveAuthAddViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/3.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "LoveAuthAddViewController.h"
#import "LoveAuthAddContentView.h"
#import "UIView+Hud.h"
#import <RSKImageCropper.h>


@interface LoveAuthAddViewController ()<LoveAuthAddContentViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,RSKImageCropViewControllerDataSource,RSKImageCropViewControllerDelegate>
{
    UIImagePickerController *imagePickerController;
    
    UIImage *_croppedImage;
    
    LoveAuthAddContentView *loveContentView;
}

@end

@implementation LoveAuthAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"上传证书";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn setImage:[UIImage imageNamed:@"msg_add"] forState:UIControlStateNormal];
    [uploadBtn setTitle:@"完成" forState:UIControlStateNormal];
    uploadBtn.backgroundColor = [UIColor clearColor];
    [uploadBtn setTitleColor:LightBlue forState:UIControlStateNormal];
    [uploadBtn addTarget:self action:@selector(uploadAuth:) forControlEvents:UIControlEventTouchUpInside];
    uploadBtn.frame = CGRectMake(0, 0, 44, 44);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:uploadBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self buildUI];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- actions
-(void)back:(UIButton *)btn{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height-(64))];
    container.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:container];
    
    loveContentView = [LoveAuthAddContentView initFromNib];
    CGRect f = loveContentView.frame;
    f.size.width = WINSIZE.width;
    loveContentView.frame = f;
    
    loveContentView.delegate = self;
    [container addSubview:loveContentView];
    container.contentSize = loveContentView.frame.size;
}

- (void)uploadAuth:(UIButton *)btn
{
    //    [self.view showHudWithText:@"正在上传..."];
    //保存图像
    NSData *imageData = UIImageJPEGRepresentation(_croppedImage, 1);
    [self httpUploadImageWithImageData:imageData andCropImage:_croppedImage];
}

#pragma mark -- 
- (void)loveAuthUploadAuth:(LoveAuthAddContentView *)v
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


#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 2:
                    return;
                    break;
                case 0: //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1: //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 1) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
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
    RSKImageCropViewController *cropViewController = [[RSKImageCropViewController alloc]initWithImage:image cropMode:RSKImageCropModeCustom];
    cropViewController.delegate   = self;
    cropViewController.dataSource = self;
    
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
    
    loveContentView.image = _croppedImage;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark --RSKImageCropViewControllerDataSource
// Returns a custom rect for the mask.
- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller
{
    CGSize maskSize = CGSizeMake(WINSIZE.width, WINSIZE.width/320 *180);
    
    CGFloat viewWidth = CGRectGetWidth(controller.view.frame);
    CGFloat viewHeight = CGRectGetHeight(controller.view.frame);
    
    CGRect maskRect = CGRectMake((viewWidth - maskSize.width) * 0.5f,
                                 (viewHeight - maskSize.height) * 0.5f,
                                 maskSize.width,
                                 maskSize.height);
    
    return maskRect;
}

// Returns a custom path for the mask.
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    CGRect rect = controller.maskRect;
    CGPoint point1 = rect.origin;
    CGPoint point2 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPoint point3 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPoint point4 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    
    UIBezierPath *rectangle = [UIBezierPath bezierPath];
    [rectangle moveToPoint:point1];
    [rectangle addLineToPoint:point2];
    [rectangle addLineToPoint:point3];
    [rectangle addLineToPoint:point4];
    [rectangle closePath];
    
    return rectangle;
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
    // 上传证书
//    
//    [[KDUserInfoModel shareUserInfoMode].owner uploadUserThumbWithImageData:imageData andCompletedBlock:^(BOOL isSuccess, NSError *error) {
//        
//        if (isSuccess)
//        {
//            [userCenterFrameView kd_showTextHUDWithPromptMessage:@"上传成功" andOffset_y:HUD_Offset_y andMargin:HUD_Margin andDuration:HUD_Animation_Duration];
//        }else
//        {
//            [hud hide:YES];
//            
//            [userCenterFrameView kd_showTextHUDWithPromptMessage:error.domain andOffset_y:HUD_Offset_y andMargin:HUD_Margin andDuration:HUD_Animation_Duration];
//        }
//        
//    } andUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        MBRoundProgressView *roundProgressView = (MBRoundProgressView *)hud.customView;
//        roundProgressView.progress = (float)totalBytesWritten/totalBytesExpectedToWrite;
//        if (roundProgressView.progress >=1.0) {
//            [hud hide:YES];
//        }
//    }];
}


@end
