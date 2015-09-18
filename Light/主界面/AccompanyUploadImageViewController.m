//
//  AccompanyUploadImageViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/18.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AccompanyUploadImageViewController.h"
#import "AccomPanyUploadImageContentView.h"
#import "UIView+Hud.h"

@interface AccompanyUploadImageViewController ()<AccomPanyUploadImageContentViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    AccomPanyUploadImageContentView *contentView;
    
    UIImagePickerController *imagePickerController;
    
}

@end

@implementation AccompanyUploadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"上次照片";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];

    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self buildUI];
    
    if (_accompany.selectedImage) {
        
        contentView.imageView.image = _accompany.selectedImage;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)done:(UIButton *)btn{


    [_accompany upLoadImageWithImageData:UIImageJPEGRepresentation(contentView.imageView.image, .5) andBlock:^(BOOL isSuccess, NSError *error) {
        
        [self.view hideHud];
        
        if (isSuccess) {
            
            if ([_delegate respondsToSelector:@selector(accompanyUploadImageViewController:didSelectedImage:)]) {
                [_delegate accompanyUploadImageViewController:self didSelectedImage:contentView.imageView.image];
            }
        }
        else{
        
            [self.view showHudWithText:error.domain];
        }
        
    } andProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
    
       [ self.view showProgress:(CGFloat)totalBytesWritten/totalBytesExpectedToWrite status:@"正在上传..."];
    }];
    
    
}
- (void)back:(UIButton *)btn{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buildUI{
    
    UIScrollView *containerScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height -64)];
    containerScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containerScroll];
    
    contentView = [AccomPanyUploadImageContentView initFromNib];
    CGRect contentViewFrame = contentView.frame;
    contentViewFrame.size.width = WINSIZE.width;
    contentView.frame = contentViewFrame;
    contentView.delegate = self;
    [containerScroll addSubview:contentView];
    containerScroll.contentSize = CGSizeMake(0, contentView.frame.size.height);

}


#pragma mark --AccomPanyUploadImageContentViewDelegate

- (void)accomPanyUploadImageContentViewdidSelectedDoneWithImage:(UIImage *)image{

    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    [actionSheet showInView:self.view];
}

#pragma mark --UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        [self takePhoto];
    }
    else if (buttonIndex == 1){
    
        [self LocalPhoto];
    }
}

//从相册选择
-(void)LocalPhoto{
    
    if (imagePickerController == nil) {
        
         imagePickerController = [[UIImagePickerController alloc] init];
    }
    //资源类型为图片库
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    //设置选择后的图片可被编辑
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:NULL];
}

//拍照
-(void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        if (imagePickerController == nil) {
            
            imagePickerController = [[UIImagePickerController alloc] init];
        }
        imagePickerController.delegate = self;
        //设置拍照后的图片可被编辑
        imagePickerController.allowsEditing = YES;
        //资源类型为照相机
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:NULL];
        
    }else {
        NSLog(@"该设备无摄像头");
    }
}

#pragma Delegate method UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        //图片显示在界面上
        contentView.imageView.image = image;
    }
    //关闭相册界面
    [picker dismissModalViewControllerAnimated:YES];
}
@end
