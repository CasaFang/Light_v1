//
//  PhoneEditViewController.m
//  Light
//
//  Created by 郑来贤 on 15/8/5.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import "PhoneEditViewController.h"
#import "PhoneEditContentView.h"
#import "PhoneValidateViewController.h"
#import "UIView+Hud.h"
#import "NSString+Extention.h"
#import "LightUser+Register.h"
#import "LightMyShareManager.h"
#import "LightUser+Change.h"

@interface PhoneEditViewController ()<UIAlertViewDelegate>
{
    PhoneEditContentView *contentView;
}

@end

@implementation PhoneEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改手机号";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"regiser_back"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"继续" style:UIBarButtonItemStylePlain target:self action:@selector(next:)];;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self buildUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)back:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)next:(UIButton *)btn{
    
    NSString *phone = contentView.phoneTextField.text;
    
    if (phone == nil||phone.trimWhiteSpace.length == 0 ) {
        
        [self.view showTipAlertWithContent:@"请填写手机号"];
        return;
        
    }
    if (!phone.isPhoneFormat) {
        
        [self.view showTipAlertWithContent:@"请填写正确的手机号码"];
        return;
    }
    
    NSString *content = [NSString stringWithFormat:@"我们将发送验证码到这个号码 +86%@",phone];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认手机号" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好", nil];
    alert.tag = 200;
    [alert show];
    
}


- (void)buildUI{
    
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height- (64))];
    [self.view addSubview:container];
    container.backgroundColor = [UIColor whiteColor];
    container.alwaysBounceVertical = YES;
    
    
    contentView = [PhoneEditContentView initFromNib];
    CGRect f = contentView.frame;
    f.size.width = WINSIZE.width;
    contentView.frame = f;
    
    [container addSubview:contentView];
    container.contentSize = contentView.frame.size;
}

#pragma mark --UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 200) {
        if (buttonIndex == 1) {
            
            
            [self.view endEditing:YES];
            
            [self.view showHudWithText:@"正在请求手机验证码..."];
            __weak typeof(self)  weakSelf = self;
            
             LightUser *user = [LightMyShareManager shareUser].owner;
            
            [user changeWithPhoneCode:contentView.phoneTextField.text andCompeletedBlock:^(BOOL isSuccess, NSError *error) {
                
                [weakSelf.view hideHud];
                
                if (isSuccess) {
                    
                    NSLog(@"go to PhoneValidate");
                    PhoneValidateViewController *c = [PhoneValidateViewController new];
                    c.phone=contentView.phoneTextField.text;
                    [self.navigationController pushViewController:c animated:YES];

                }
                else
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:error.domain delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
                    [alert show];
                }
                
            }];

        }
    }
}

@end
