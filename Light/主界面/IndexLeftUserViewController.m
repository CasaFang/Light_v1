//
//  IndexUserViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/2.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "IndexLeftUserViewController.h"
#import "LightMyShareManager.h"
#import "LightUser.h"
#import "AppDelegate.h"
#import <PKRevealController.h>
#import "IndexLeftUserContentView.h"
#import "LightUser.h"
#import "LightUser+Change.h"
#import "PickerView.h"
#import "UIView+Hud.h"
#import "NSString+Date.h"
#import "EditSignatureViewController.h"
#import "EditNickNameViewController.h"
#import "AddrSelectTableViewController.h"

@interface IndexLeftUserViewController ()<IndexLeftUserContentViewDelegate,PickerViewDelegate,UIActionSheetDelegate,AddrSelectTableViewControllerDelegate>
{

    PickerView *pickerView;
    
    IndexLeftUserContentView *contentView;
    
    NSInteger currentSelectedIndex;
}

@property (strong , nonatomic) LightUser *user;
@end

@implementation IndexLeftUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LightUser *user = [LightMyShareManager shareUser].owner;
    self.title = user.name;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backToMain:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self buildUI];
    
    _user = [LightMyShareManager shareUser].owner;
    
    [self requestUserInfo];
    
    pickerView = [PickerView initFromNib];
    pickerView.delegate = self;
    
    CGRect  pickerFrame = pickerView.frame;
    pickerFrame.origin.y = WINSIZE.height;
    pickerView.frame = pickerFrame;
    
    [self.view addSubview:pickerView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserName:) name:LightUserChangeNickNameSuccessNoti object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSignture:) name:LightUserChangeSigntureSuccessNoti object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestUserInfo{

    [_user getUserInfoWithBlock:^(BOOL isSuccess, NSError *error) {
        
        if (isSuccess) {
            
            [contentView displayWithUser:_user];
        }
        else{
        
            [self.view showTipAlertWithContent:error.domain];
        }
    }];
}


#pragma mark --actions

#pragma mark -- actions
- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
     container.backgroundColor = [UIColor whiteColor];
    
    
    contentView = [IndexLeftUserContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    contentView.delegate = self;
    
    [container addSubview:contentView];
    container.contentSize = CGSizeMake(0, contentView.frame.size.height);
}

- (void)backToMain:(id)sender
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate resetRevealController];
}

#pragma mark -- delegate
- (void)userContentView:(IndexLeftUserContentView *)v didSelectedSection:(NSInteger)section
{
    currentSelectedIndex = section;
    switch (section) {
        case 0:
        {
            // 修改昵称
            EditNickNameViewController *c = [EditNickNameViewController new];
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 1:
        {
           // 修改生日
            [self showPickerView];
            
            NSString *birthdayStr = [NSString stringWithFormat:@"%ld",(long)_user.birthday];
            
            if (birthdayStr.length > 0&&birthdayStr.integerValue != 0) {
                
                [pickerView setCurrentDate: [birthdayStr stringToDateWithFormat:@"YYYYMMdd"]];
            }
            
            
        }
            break;
        case 2:
        {
            EditSignatureViewController *c = [EditSignatureViewController new];
            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 3:
        {
            
            // 修改生理性别
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择性别" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"女",@"男",@"其他",@"取消", nil];
            [actionSheet showInView:self.view];
           
        }
            break;
        case 4:
        {
            // 修改社会性别
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择性别" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"女",@"男",@"其他",@"取消", nil];
            [actionSheet showInView:self.view];
        }
            break;
        case 5:
        {
            AddrSelectTableViewController *c = [AddrSelectTableViewController new];
            c.delegate = self;
            [self.navigationController pushViewController:c  animated:YES];
        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:
        {
            
        }
            break;
        case 8:
        {
            
        }
            break;
        case 9:
        {
            
        }
            break;
        case 10:
        {
            
        }
            break;
        case 11:
        {
            
        }
            break;
        case 12:
        {
            
        }
            break;
        case 13:
        {
            
        }
            break;
        
        case 14:
        {
            
        }
            break;
        case 15:
        {
            
        }
            break;
            
    }
}

- (void)showPickerView{

    __block CGRect  pickerFrame = pickerView.frame;
    
    [UIView animateWithDuration:1 animations:^{
        pickerFrame.origin.y = WINSIZE.height - pickerFrame.size.height-64;
        pickerView.frame = pickerFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidePickerView{

    __block CGRect  pickerFrame = pickerView.frame;
    
    [UIView animateWithDuration:1 animations:^{
        pickerFrame.origin.y = WINSIZE.height;
        pickerView.frame = pickerFrame;
    } completion:^(BOOL finished) {
        
    }];

}

#pragma mark --- notis
- (void)changeUserName:(NSNotification *)noti{

    _user.name = noti.object;
    [contentView displayWithUser:_user];
}

- (void)changeSignture:(NSNotification *)noti{
    
    _user.sigNature = noti.object;
    [contentView displayWithUser:_user];
}




#pragma mark -- picker delegate
- (void)picker:(PickerView *)view didSelectedValue:(NSString *)value{

    
    switch (currentSelectedIndex) {
        case 0:
        {
            // 修改位置
            
            [self.view showHudWithText:@"请稍等..."];
            
            [_user changeArea:value  andBlock:^(BOOL isSuccess, NSError *error) {
                
                [self.view hideHud];
                
                if (isSuccess) {
                    
                    _user.area = value;
                    [contentView displayWithUser:_user];
                    
                }
                else{
                
                    [self.view showTipAlertWithContent:error.domain];
                }
                
            }];
            
        }
            break;
        case 1:
        {
            // 修改生日
            
            [self.view showHudWithText:@"请稍等..."];
            
            [_user changeBirthday:value.integerValue andBlock:^(BOOL isSuccess, NSError *error) {
                
                [self.view hideHud];
                
                if (isSuccess) {
                    
                    _user.birthday = value.integerValue;
                    [contentView displayWithUser:_user];
                    
                }
                else{
                    
                    [self.view showTipAlertWithContent:error.domain];
                }
                
            }];

           
        }
            break;
        case 2:
        {
            // 修改生理性别
           
           
        }
            break;
        case 3:
        {
            // 修改社会性别
            
           
        }
            break;
    }

    [self hidePickerView];
}
- (void)pickerDidCancle:(PickerView *)view{
    
    [self hidePickerView];
}


#pragma mark --UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 3) {
        
    }
    else{
    
        if (currentSelectedIndex == 3) {
            

            if (_user.physiology_gender == buttonIndex) {
                
                return;
            }
            
            [self.view showHudWithText:@"请稍等..."];
            
            [_user changePhysiology_gender:buttonIndex andBlock:^(BOOL isSuccess, NSError *error) {
                
                [self.view hideHud];
                
                if (isSuccess) {
                    
                    _user.physiology_gender = buttonIndex;
                    [contentView displayWithUser:_user];
                    
                }
                else{
                    
                    [self.view showTipAlertWithContent:error.domain];
                }
                
            }];

        }
        else if (currentSelectedIndex == 4){
        
            if (_user.society_gender == buttonIndex) {
                
                return;
            }
            
            [self.view showHudWithText:@"请稍等..."];
            
            [_user changeSociety_gender:buttonIndex andBlock:^(BOOL isSuccess, NSError *error) {
                
                [self.view hideHud];
                
                if (isSuccess) {
                    
                    _user.society_gender = buttonIndex;
                    
                    [contentView displayWithUser:_user];
                    
                }
                else{
                    
                    [self.view showTipAlertWithContent:error.domain];
                }
                
            }];

        }
    }
}


#pragma mark -- AddrSelectTableViewControllerDelegate

- (void)addrSelectTableViewControllerDidSelectedAddr:(NSString *)addressStrValue
{
    [self.navigationController popViewControllerAnimated:YES];

    [[LightMyShareManager shareUser].owner changeArea:addressStrValue andBlock:^(BOOL isSuccess, NSError *error) {
       
        if (isSuccess) {
            _user.area = addressStrValue;
            
            [contentView displayWithUser:_user];
        }
        else{
        
            [self.view showTipAlertWithContent:error.domain];
        }
    }];
}

@end
