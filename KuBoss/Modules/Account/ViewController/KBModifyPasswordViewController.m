//
//  KBModifyPasswordViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBModifyPasswordViewController.h"
#import "KBModifyView.h"
#import "UIViewController+BackButtonHandler.h"
@interface KBModifyPasswordViewController ()<ModifyViewActionDelegate>
@property (nonatomic,strong)  KBModifyView *modifyView;
@end

@implementation KBModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"修改密码"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.modifyView = [[KBModifyView alloc]initWithFrame:CGRectMake(0, self.navigationController.navigationBar.ct_bottom, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_bottom)];
    self.modifyView.modifyViewType = KBModifyViewTypePassword;
    self.modifyView.delegate = self;
    [self.view addSubview:self.modifyView];
}

- (void)callPasswordState:(KBModifyPasswordState)passwordState oldPassword:(NSString *)oldPassword password:(NSString *)password
{
    [KBAlter showLoadingForView:self.view];
     @KBWeakObj(self);
    [[KBApiLayer sharedInstance]  modifyOldPassword:oldPassword newPassword:password success:^(KBBaseModel * model) {
         @KBStrongObj(self);
         [KBAlter  hideLoadingForView:self.view];
        if (model.code == 0)
        {
            [self.modifyView  setPasswordState:passwordState];
        }
        else
        {
            [KBAlter  show:model.desc superView:self.view];
        }
    } fail:^(NSError *error) {
         [KBAlter  hideLoadingForView:self.view];
         [KBAlter  show:@"服务器异常" superView:self.view];
    }];
    
}

-(BOOL)navigationShouldPopOnBackButton
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

- (void)callAlterMessage:(NSString *)message
{
    [KBAlter  show:message superView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
