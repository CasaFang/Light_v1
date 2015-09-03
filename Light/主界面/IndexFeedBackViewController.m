//
//  IndexFeedBackViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexFeedBackViewController.h"
#import "AppDelegate.h"
#import "IndexFeedBackContentView.h"
#import <RSKImageCropper.h>
#import "AppInfo.h"
#import "LightMyShareManager.h"
#import "LightUser.h"
#import "UIView+Hud.h"

@interface IndexFeedBackViewController ()<IndexFeedBackContentViewDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,RSKImageCropViewControllerDataSource,RSKImageCropViewControllerDelegate>
{
    UIImagePickerController *imagePickerController;
    
    UIImage *_croppedImage;
    
    IndexFeedBackContentView *contentView;
}
@end

@implementation IndexFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"反馈";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backToMain:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(feedBack:)];;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self buildUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --actions

- (void)feedBack:(UIButton *)btn{

    NSInteger userId = [LightMyShareManager shareUser].owner.Id;
    [[AppInfo new] feedBackWithContent:contentView.contentTextView.text andUserId:userId andBlock:^(BOOL isSuccess, NSError *error) {
        
        if (isSuccess) {
            
            [self.view showTipAlertWithContent:@" 反馈成功"];
            contentView.contentTextView.text = @"";
        }
        else{
        
            [self.view showTipAlertWithContent:error.domain];
        }
    }];
}
- (void)backToMain:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate resetRevealController];
}

- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
     container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    
    contentView = [IndexFeedBackContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}

#pragma mark --
- (void)feedBackContentViewDidClickedUploadPic:(IndexFeedBackContentView *)v
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
                case 0:
                    return;
                    break;
                case 1: //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2: //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
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
    
    contentView.image = _croppedImage;
    
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

}

@end
