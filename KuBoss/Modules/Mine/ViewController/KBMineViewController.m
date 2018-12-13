//
//  KBMineViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBMineViewController.h"
#import "KBHeader.h"
#import "KBMineHeadView.h"
#import "KBGlobalControllerCenter.h"
#import "UIView+CustomCorners.h"
#import "KBRootViewController.h"
@interface KBMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tbView;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) KBMineHeadView *headView;

@end

@implementation KBMineViewController

#pragma mark - life cycle 视图的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = @[@"设置",@"意见反馈",@"关于我们"];
    [self.view addSubview:self.tbView];
    [self.view addSubview:self.loginoutBtn];
    [self.navigationController.navigationBar
     setBackgroundImage:[UIImage imageNamed:@"pixel_blank"]
     forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar
     setShadowImage:[UIImage imageNamed:@"pixel_blank"]];
    self.navigationController.navigationBar.barStyle = UIBarMetricsDefault;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.headView updateUserName];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [KBGlobalControllerCenter sharedInstance].isClick  = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods 私有方法

#pragma mark - Delegate 代理


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeSetup]){
              [[KBGlobalControllerCenter sharedInstance] pushMineMode:KBNavgationModeSetting];
        }
    
    }
    else if (indexPath.row == 1) {
        [[KBGlobalControllerCenter sharedInstance] pushMineMode:KBNavgationModeFeedback];
    }
    else if (indexPath.row == 2) {
        [[KBGlobalControllerCenter sharedInstance] pushMineMode:KBNavgationModeAbout];
    }
}

#pragma mark - event response 所有触发的事件响应 按钮、通知、分段控件等


#pragma mark - getters and setters 设置器和访问器

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, -self.navigationController.navigationBar.ct_height, self.view.ct_width*0.8, self.view.ct_height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableFooterView = [UIView new];
        _tbView.tableHeaderView = self.headView;
        AdjustsScrollViewInsetNever(self, _tbView);

    }
    return _tbView;
}

- (KBMineHeadView *)headView
{
    if (!_headView) {
        _headView = [[KBMineHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 222)];
    }
    return _headView;
}


- (UIButton *)loginoutBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame  = CGRectMake(25, self.view.ct_height - 140 , 0.8 * self.view.ct_width-50, 40);
    //btn.backgroundColor = kMainColor;
    [btn addGradientLayerFromColor:KBCOLOR_WITH_HEX(0x697EFF) toColor:KBCOLOR_WITH_HEX(0x776FFF)];
    btn.layer.cornerRadius = 20;
    btn.layer.masksToBounds = YES;
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font  = [UIFont systemFontOfSize:16];
  
    
    return btn;
}



- (void)logout
{
    @KBWeakObj(self);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出登录" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @KBStrongObj(self);
        [KBAlter showLoadingForView:self.view];
        [KBUserInfoModel clear];
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"kUserRememberPassword"]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"kUserpassword"];
        }
        [[KBGlobalControllerCenter sharedInstance] showLoginView];
        [[KBApiLayer sharedInstance] loginOutSuccess:^(KBBaseModel * model) {
            [KBAlter hideLoadingForView:self.view];
        } fail:^(NSError *error) {
            [KBAlter hideLoadingForView:self.view];
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - public methods 公有方法





@end
