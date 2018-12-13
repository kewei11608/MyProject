//
//  KBModifyIphoneViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBModifyIphoneViewController.h"
#import "KBModifyView.h"
#import "UIViewController+BackButtonHandler.h"



@interface KBModifyIphoneViewController ()<ModifyViewActionDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)KBModifyView *modifyView;
@property (nonatomic,copy) NSString *password;

@end

@implementation KBModifyIphoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setCustomTitle:@"修改手机号"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.modifyView = [[KBModifyView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.ct_bottom, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_bottom)];
    self.modifyView.modifyViewType =  KBModifyViewTypeIphone;
    self.modifyView.delegate = self;
    [self.view addSubview:self.modifyView];
    
}

- (BOOL)navigationShouldPopOnBackButton
{
   
    UIAlertView *alter =  [[UIAlertView alloc] initWithTitle:nil message:@"您确定放弃本次修改吗?"
                                   delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil] ;
        
    [alter show];
    return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)callIphoneState:(KBModifyIphoneState)iphoneState passwordInput:(NSString *)password
{
   @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance]  validatePassword:password success:^(KBBaseModel * model) {
         @KBStrongObj(self);
        [KBAlter  hideLoadingForView:self.view];
        if (model.code == 0)
        {
           self.password = password;
          [self.modifyView  setIphoneState:iphoneState];
        }
        else
        {
            [KBAlter  show:model.desc superView:self.view];
        }
    } fail:^(NSError *error) {
         [KBAlter  show:@"服务器异常" superView:self.view];
         [KBAlter  hideLoadingForView:self.view];
    }];
}

- (void)callIphoneState:(KBModifyIphoneState)iphoneState iphoneInput:(NSString *)iphone code:(NSString *)code
{
    @KBWeakObj(self);
     [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance]  modifyPhone:iphone code:code password:self.password success:^(KBBaseModel * model) {
        @KBStrongObj(self);
        [KBAlter  hideLoadingForView:self.view];
        if (model.code == 0)
        {
            [self.modifyView setIphoneState:iphoneState];
        }
        else{
             [KBAlter  show:model.desc superView:self.view];
        }
        
    } fail:^(NSError *error) {
             [KBAlter  show:@"服务器异常" superView:self.view];
    }];
    
}

- (void)callAlterMessage:(NSString *)message
{
    [KBAlter  show:message superView:self.view];
}

- (void)callSmsCodeIphoneInput:(NSString *)iphone
{
    @KBWeakObj(self);
      [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance]  sendSmsCodeWithPhone:iphone success:^(KBBaseModel * model) {
         @KBStrongObj(self);
          [KBAlter  hideLoadingForView:self.view];
        if (model.code == 0)
        {
             [KBAlter  show:model.desc superView:self.view];
        }
        else{
            [KBAlter  show:model.desc superView:self.view];
        }
    } fail:^(NSError *error) {
            [KBAlter  show:@"服务器异常" superView:self.view];
            [KBAlter  hideLoadingForView:self.view];
    } ];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
