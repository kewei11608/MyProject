//
//  KBTaskAcounttFreezeViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBTaskAcounttFreezeViewController.h"
#import "AcounttFreezeView.h"
#import "KBTaskFreezeDetailVC.h"
#import "KBTaskAcounttFreezeRecordViewController.h"

@interface KBTaskAcounttFreezeViewController ()
@property (nonatomic,strong)AcounttFreezeView *mainView;

@end

@implementation KBTaskAcounttFreezeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomTitle:@"账号冻结处理"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 1)];
    [self.view addSubview:view];
    [self.view addSubview:self.mainView];
    [self.mainView setAutoLayoutLeftToViewLeft:self.view constant:0];
    [self.mainView setAutoLayoutRightToViewRight:self.view constant:0];
    [self.mainView setAutoLayoutTopToViewBottom:view constant:0];
    [self.mainView setAutoLayoutBottomToViewBottom:self.view constant:0];
    [self api];
    
    
    
    
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame =CGRectMake(0,0, 22, 22);
    [rightBut setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(onClickRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *rightButItem = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightButItem;
    @KBWeakObj(self);
    self.mainView.detailBlock = ^(NSString * accountid) {
        @KBStrongObj(self);
        KBTaskFreezeDetailVC *vc = [[KBTaskFreezeDetailVC alloc]initAccountId:accountid handle:YES];
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    self.mainView.goToLowBlock = ^{
        @KBStrongObj(self);
        [self.navigationController pushViewController:[NSClassFromString(@"KBLowQuantificationViewController") new] animated:YES];

    };
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [KBUserBehavior behaviorEventId:KEnterFreezeDetailEventId];
}

- (void)onClickRightMenu
{
    KBTaskAcounttFreezeRecordViewController *vc = [[KBTaskAcounttFreezeRecordViewController alloc] initRecord:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)api
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance] taskAccountFreezelistSuccess:^(KBAccountFreezeListModel * model) {
        @KBStrongObj(self);
        [KBAlter hideLoadingForView:self.view];
        [self.mainView setModel:model];
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}

- (AcounttFreezeView *)mainView {
    if (!_mainView) {
        _mainView = [AcounttFreezeView loadViewFrom:@"AcounttFreezeView"];
    }
    return _mainView;
}

@end
