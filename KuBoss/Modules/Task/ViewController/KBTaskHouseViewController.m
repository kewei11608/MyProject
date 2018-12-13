//
//  KBTaskHouseViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/5/23.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBTaskHouseViewController.h"
#import "AcounttFreezeView.h"
#import "KBTaskHouseDetailViewController.h"
#import "KBTaskAcounttFreezeRecordViewController.h"
@interface KBTaskHouseViewController ()
@property (nonatomic,strong)AcounttFreezeView *mainView;
@end

@implementation KBTaskHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomTitle:@"房源流通"];
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
        [KBUserBehavior behaviorEventId:KBClickHousingItemEventId];
        KBTaskHouseDetailViewController *vc = [[KBTaskHouseDetailViewController alloc]initApprovaid:accountid record:YES];
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
    [KBUserBehavior behaviorEventId:KBEnterHousingCirculationEventId];
}

- (void)onClickRightMenu
{
    [KBUserBehavior behaviorEventId:KBClickHousingCirculationRecordEventId];
    KBTaskAcounttFreezeRecordViewController *vc = [[KBTaskAcounttFreezeRecordViewController alloc] initRecord:NO];
   [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)api
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance] taskHouseListSuccess:^(KBAccountFreezeListModel * model) {
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
        _mainView.isHouse = YES;
    }
    return _mainView;
}

@end
