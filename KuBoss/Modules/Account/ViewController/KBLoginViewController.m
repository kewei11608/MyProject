//
//  KBLoginViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLoginViewController.h"
#import "KBHeader.h"
#import "KBInputView.h"
#import "KBApiLayer.h"
#import "KBGlobalControllerCenter.h"
#import "UIView+CustomCorners.h"
#import <JPUSHService.h>
#import <AFHTTPSessionManager.h>

@interface KBLoginViewController ()

@property (nonatomic,strong) KBInputView *accountInputView;
@property (nonatomic,strong) KBInputView *passwordInputView;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIView *bottomView2;

@end

@implementation KBLoginViewController

#pragma mark - life cycle 视图的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc
{
    
}

#pragma mark - private methods 私有方法

- (void)setupSubViews
{
    self.view.backgroundColor =  [UIColor whiteColor];
    
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-84)/2, 130, 84, 84)];
    logoView.image = [UIImage imageNamed:@"kuboss"];
    logoView.layer.masksToBounds = YES;
    logoView.layer.cornerRadius  = 10;
    [self.view addSubview:logoView];
    
    self.accountInputView = [[KBInputView alloc]initWithFrame:CGRectMake(44, logoView.ct_bottom+70, self.view.frame.size.width-88, 40) leftIcon:@"login_iphone" rightIcon:@"" text:@"请输入您的用户编码"];
    [self.view addSubview:self.accountInputView];
    
    self.passwordInputView = [[KBInputView alloc]initWithFrame:CGRectMake(44, self.accountInputView.ct_bottom+40, self.view.frame.size.width-88, 40) leftIcon:@"loginlock" rightIcon:@"closeair"   text:@"请输入您的密码"];
    self.passwordInputView.secureTextEntry = YES;
    [self.view addSubview:self.passwordInputView];
 
    if (((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"kUserpassword"]).length >0) {
         [self.passwordInputView setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"kUserpassword"]];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"kUsername"]) {
        [self.accountInputView setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"kUsername"]];
    }
   
   
    
    [self.view addSubview:self.loginBtn];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.loginBtn.ct_left, self.loginBtn.ct_bottom+16, self.loginBtn.ct_width, 17)];
    [self.view addSubview:bgView];
    bgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [bgView addGestureRecognizer:tap];
    
    
    UIView *bottomView1 = [[UIView alloc]initWithFrame:CGRectMake(15,0, 16, 16)];
    bottomView1.layer.cornerRadius  = 8 ;
    bottomView1.layer.masksToBounds = YES;
    bottomView1.layer.borderColor = kMainColor.CGColor;
    bottomView1.layer.borderWidth = 1;
    bottomView1.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:bottomView1];
    
    self.bottomView2 = [[UIView alloc]initWithFrame:CGRectMake(18,3, 10, 10)];
    self.bottomView2.layer.cornerRadius  = 5 ;
    self.bottomView2.layer.masksToBounds = YES;
    self.bottomView2.backgroundColor = kMainColor;
    [bgView addSubview:self.bottomView2];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"kUserRememberPassword"] != nil) {
        bool isRememberPwd = [[NSUserDefaults standardUserDefaults] boolForKey:@"kUserRememberPassword"];
        self.bottomView2.hidden = !isRememberPwd;
    }else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kUserRememberPassword"];
    }
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(bottomView1.ct_right+5, (bgView.ct_height-14)/2, self.passwordInputView.ct_width, 14)];
    lable.text = @"记住密码";
    lable.textColor = kMainColor;
    lable.font = [UIFont systemFontOfSize:13];
    [bgView addSubview:lable];
    
    
    
}

- (void)click
{
    self.bottomView2.hidden = !self.bottomView2.hidden;
    if (self.bottomView2.hidden == NO)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[self.passwordInputView inputText]forKey:@"kUserpassword"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kUserRememberPassword"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"kUserpassword"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kUserRememberPassword"];
    }
}

- (void)login
{
    
    
    
    if (self.accountInputView.inputText.length == 0) {
        [KBAlter show:@"请输入用户编码" superView:self.view];
        return;
    }
    if (self.passwordInputView.inputText.length == 0) {
        [KBAlter show:@"请输入密码" superView:self.view];
        return;
    }
    
    DLog(@"-=-=-  %@",self.accountInputView.inputText);
    
    [KBAlter showLoadingForView:self.view];
    @KBWeakObj(self);
   
    [[KBApiLayer sharedInstance] loginWithUserCode:self.accountInputView.inputText Password:self.passwordInputView.inputText success:^(KBUserInfoModel * info) {
        @KBStrongObj(self);
        if (info.code == 0) {
            [info sava];
            [JPUSHService setMobileNumber:[NSString stringWithFormat:@"+86%@", [KBUserInfoModel iphone]] completion:^(NSError *error) {
                
            }];
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"JPushRegistrationID"]) {
                // /stations
                
                NSDictionary *dParam = @{@"userid" : [KBUserInfoModel uid],
                                         @"RegisteredId" : [[NSUserDefaults standardUserDefaults] objectForKey:@"JPushRegistrationID"]
                                         };
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
                [policy setAllowInvalidCertificates:YES];
                [policy setValidatesDomainName:NO];
                manager.securityPolicy = policy;
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                manager.operationQueue.maxConcurrentOperationCount = 5;
                manager.requestSerializer.timeoutInterval = 30;
                [manager POST:[NSString stringWithFormat:@"%@%@/jpush/cr", httpApi, httpFilePath] parameters:dParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    NSLog(@"%@", dict);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                }];
                
                
                
            }
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[self.accountInputView inputText]forKey:@"kUsername"];
            [[NSUserDefaults standardUserDefaults] setObject:[self.passwordInputView inputText]forKey:@"kUserpassword"];
//            [KBAlter show:info.desc superView:self.view];
            [[KBApiLayer sharedInstance] loginShopSuccess:^(id model) {
                
            } fail:^(NSError *error) {
                
            }];
            [KBAlter hideLoadingForView:self.view];
            [self dismissViewControllerAnimated:NO completion:nil];
            
            [[KBGlobalControllerCenter sharedInstance].mmDrawerController closeDrawerAnimated:NO completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccess" object:nil];
        }
        else
        {
            [KBAlter hideLoadingForView:self.view];
            [KBAlter show:info.desc superView:self.view];
        }
   

    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
        [KBAlter show:@"请求失败！" superView:self.view];
    }];
    
    
}


#pragma mark - getters and setters 设置器和访问器

- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(42, self.passwordInputView.ct_bottom+40, self.view.frame.size.width-84, 40);
        [_loginBtn addGradientLayerFromColor:KBCOLOR_WITH_HEX(0x697EFF) toColor:KBCOLOR_WITH_HEX(0x776FFF)];
        _loginBtn.layer.cornerRadius = 20;
        _loginBtn.layer.masksToBounds = YES;
        [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loginBtn setTitleColor:[UIColor  whiteColor] forState:UIControlStateNormal];
    }
    return _loginBtn;
}


#pragma mark - CustomDelegate 自定义的代理


#pragma mark - public methods 公有方法


@end
