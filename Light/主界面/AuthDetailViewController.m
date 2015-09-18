//
//  AuthDetailViewController.m
//  Light
//
//  Created by 郑来贤 on 15/9/19.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "AuthDetailViewController.h"
#import <TPKeyboardAvoidingScrollView.h>
#import "LightMarryPage.h"
#import "LightUser.h"
#import "LightMyShareManager.h"
#import "UIViewController+ImagePicker.h"
#import "UIView+Hud.h"
#import "AuthDetailContentView.h"
#import <MWPhotoBrowser.h>


@interface AuthDetailViewController ()<AuthDetailContentViewDelegate,MWPhotoBrowserDelegate,UIActionSheetDelegate>
{

    AuthDetailContentView *contentView;
    LightMarryPage *_marryPage;
    
    NSMutableArray *photos;
}

@end

@implementation AuthDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    [self buildUI];
    
    
    _marryPage = [LightMarryPage new];
    _marryPage.Id = _marryPageId;
    
    LightUser *user = [LightMyShareManager shareUser].owner;
    
    if ([user.marryPageId isEqualToString:_marryPageId]) {
        
        [contentView setMarryEditIng:YES];
    }
    else{
    
        [contentView setMarryEditIng:NO];
    }
    [_marryPage getMarryDetailWithMarryId:_marryPageId andCompletedBlock:^(BOOL isSuccess, LightMarryPage *marryPage, NSError *error) {
        
        [contentView displayWithMarryPage:marryPage];
    }];
    
    [self reloaMarryPagePics];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(UIButton *)btn{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)reloaMarryPagePics{
    
    [_marryPage getMarryPagePicksWithMarryId:_marryPageId andCompletedBlock:^(BOOL isSuccess, NSArray *pics, NSError *error) {
        
        [contentView disMarryPagePicsWithPics:pics];
        
    }];
}

#pragma mark -- actions
- (void)buildUI{
    
    TPKeyboardAvoidingScrollView *container = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height)];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    
    contentView = [AuthDetailContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = CGSizeMake(0, contentView.frame.size.height);
}


#pragma mark -- AuthDetailContentViewDelegate

- (void)authDetailContentViewDidClickedPicAdd:(AuthDetailContentView *)v{

    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    actionSheet.delegate  = self;
    [actionSheet showInView:self.view];
}
- (void)authDetailContentViewDidClickedPic:(AuthDetailContentView *)v andPicArray:(NSArray *)pics andCurrentIndex:(NSIndexPath *)path{

    photos = [[self transferArrayForPictureBrowserWithOriginalArray:pics] mutableCopy];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    browser.displayNavArrows = YES;
    browser.displaySelectionButtons = NO;
    browser.alwaysShowControls = NO;
    browser.zoomPhotosToFill = YES;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    browser.wantsFullScreenLayout = YES;
#endif
    browser.enableGrid = NO;
    browser.startOnGrid = NO;
    browser.enableSwipeToDismiss = NO;
    
    [browser setCurrentPhotoIndex:path.row];
    [self.navigationController pushViewController:browser animated:YES];
}
- (NSArray *)transferArrayForPictureBrowserWithOriginalArray:(NSArray *)ori
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int row = 0; row< ori.count; row++) {
        
        MWPhoto *photo = [MWPhoto photoWithURL:ori[row]];
        //        photo.caption = m.name;
        [temp addObject:photo];
    }
    
    return [temp mutableCopy];
}

#pragma mark --UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        [self openImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera andError:nil andImagePickerDelegate:self];
    }
    else if (buttonIndex == 1){
        
        [self openImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary andError:nil andImagePickerDelegate:self];
    }
}

#pragma Delegate method UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        //图片显示在界面上
        
        
        __weak typeof(self) weakSelf = self;
        [_marryPage upLoadImageWithImageData:UIImageJPEGRepresentation(image, .3) andBlock:^(BOOL isSuccess, NSError *error) {
            
            [weakSelf.view hideHud];
            
            if (isSuccess) {
                
                [weakSelf reloaMarryPagePics];
            }
            else{
                
                [weakSelf.view showTipAlertWithContent:error.domain];
            }
            
        } andProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            
            [ weakSelf.view showProgress:(CGFloat)totalBytesWritten/totalBytesExpectedToWrite status:@"正在上传..."];
        }];
    }
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < photos.count)
        return [photos objectAtIndex:index];
    return nil;
}

//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
//    if (index < _thumbs.count)
//        return [_thumbs objectAtIndex:index];
//    return nil;
//}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

//- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
//    return [[_selections objectAtIndex:index] boolValue];
//}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
//    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
//    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
//}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
