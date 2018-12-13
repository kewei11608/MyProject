//
//  KBRootViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRootViewController.h"
#import "KBGlobalControllerCenter.h"
#import "KBRootHeadView.h"
#import "KBWarMessageCell.h"
#import "KBApiLayer.h"
#import "KBFollowViewController.h"
#import "KBTaskMainViewController.h"
#import "WZLBadgeImport.h"
#import "KBTaskNumberRequest.h"
#import "KBCheckVersionRequest.h"
#import "KBTaskNumberModel.h"
#import "UIView+WZLBadge.h"
#import "HousingListController.h"
#import "TabBarController.h"

@interface KBRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)KBRootHeadView *headView;

@property (nonatomic,strong)NSMutableArray *war;
@property (nonatomic,strong)NSMutableArray *followList;
@property (nonatomic,strong)UIBarButtonItem  *rightButItem;



@end

@implementation KBRootViewController
static KBRootViewController * instance = nil;
+ (instancetype)sharedInstaced
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[KBRootViewController alloc]init];
    });
    return instance;
}

#pragma mark - life cycle 视图的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self checkVersion];
    
    self.war = [[NSMutableArray alloc]init];
    self.followList = [[NSMutableArray alloc]init];
    [self setupSubViews];
    [KBGlobalControllerCenter sharedInstance].rootNav = self.navigationController;
    [[KBGlobalControllerCenter sharedInstance] showStartView];
    [[KBGlobalControllerCenter sharedInstance] showLoginView];
    
   
    
    @KBWeakObj(self);
    self.headView.moreBlock = ^{
        @KBStrongObj(self);
        [KBUserBehavior behaviorEventId:KBWarEventId];
        [self.navigationController pushViewController:[NSClassFromString(@"KBWarMoreViewController") new] animated:YES];
    };
    
    self.headView.rankBlock = ^{
        @KBStrongObj(self);
        [KBUserBehavior behaviorEventId:KBRankEventId];
        [self.navigationController pushViewController:[NSClassFromString(@"KBRankViewController") new] animated:YES];
    };
    
    self.headView.clickTabBlock = ^(NSInteger tag) {
        @KBStrongObj(self);
        if (tag == 0) {
            if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeBusinessData]) {
                 [self.navigationController pushViewController:[NSClassFromString(@"KBManagerViewController") new] animated:YES];
            }
       
        }
        else if (tag == 1) {
            if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeLowQuantificationWarning])
            {
                  [self.navigationController pushViewController:[NSClassFromString(@"KBLowQuantificationViewController") new] animated:YES];
            }
        }
        
        else if (tag == 2) {
            if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeTaskApproval]){
                [KBUserBehavior behaviorEventId:KBEnterTaskPageEventId];
                [self.navigationController pushViewController:[NSClassFromString(@"KBTaskMainViewController") new] animated:YES];
            }
           
        }else if (tag==3){
            
            TabBarController * fvc = [[TabBarController alloc]init];
            [self.navigationController pushViewController:fvc animated:YES];
            
        }
        
  
    };
    self.headView.clickFollowBlock = ^{
         @KBStrongObj(self);
        KBFollowViewController * fvc = [[KBFollowViewController alloc]initFollowedArray:self.followList];
        [self.navigationController pushViewController:fvc animated:YES];
    };
    
    if ([KBUserInfoModel isLogin]) {
        [self requestInfo];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestInfo) name:@"kLoginSuccess"  object:nil];
    // Do any additional setup after loading the view.
}


- (void)requestInfo
{
    @KBWeakObj(self);
    [[KBApiLayer sharedInstance] loginShopSuccess:^(id model) {
        @KBStrongObj(self);
        [self  banner];
        [self warList];
        
        
    } fail:^(NSError *error) {
        
    }];
    [self.headView updateView];
    [self follow];
    [self getMessageNoReadNumber];
    [self getTaskNoReadNumber];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    
}


//- (void)getTaskNoReadNumber
//{
//
//    [[KBApiLayer sharedInstance] taskNoReadNoSuccess:^(KBBaseModel * model) {
//        if (model.data&&[model.data isKindOfClass:[NSNumber class]]) {
//           [self.headView setNumber:[model.data integerValue]];
//        }
//    } fail:^(NSError *error) {
//
//    }];
//}

- (void)getMessageNoReadNumber
{
    __block NSInteger  noReadNumer = 0;

    [[KBApiLayer sharedInstance]  messageAreaCode:1 success:^(KBMessgeUnreadModel * model) {
        [model.data enumerateObjectsUsingBlock:^(KBMessgeUnreadData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                noReadNumer = noReadNumer + obj.count;
        }];
        [self handleTotal:noReadNumer];
    } fail:^(NSError *error) {

    }];

}

- (void)handleTotal:(NSInteger)total
{
    __block NSInteger  noReadNumer = total;
    [[KBApiLayer sharedInstance]  messageModuleSuccess:^(KBBaseModel * model) {
        if (model.data) {
            noReadNumer  = noReadNumer + [model.data integerValue];
            if (noReadNumer==0) {
                [_rightButItem clearBadge];
            }
            else{
                [_rightButItem showBadgeWithStyle:WBadgeStyleNumber value:noReadNumer animationType:WBadgeAnimTypeNone];
            }
        }
     
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)checkVersion {
    @KBWeakObj(self);
    [[KBApiLayer sharedInstance] checkVersionSuccess:^(id model) {
        @KBStrongObj(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"版本更新" message:@"检测到新版本，请前往更新" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
            exit(0);
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)follow
{
    @KBWeakObj(self);
    [[KBApiLayer sharedInstance]  followWithType:KBFollowWithTypDefalut  success:^(KBIndicatorConcernModel * model) {
        @KBStrongObj(self);
        [self.followList removeAllObjects];
        [self.followList  addObjectsFromArray:model.data.targetlist];
        [self.headView setFollowArray:model.data.targetlist];
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)warList
{
    @KBWeakObj(self);
    [[KBApiLayer sharedInstance]  warReportPage:1 size:5 success:^(KBWarReportModel *warModel) {
         @KBStrongObj(self);
        [self.war removeAllObjects];
        [self.war addObjectsFromArray:warModel.data];
        [self.tbView reloadData];
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)banner
{
    @KBWeakObj(self);
    [[KBApiLayer sharedInstance]  bannerSuccess:^(KBBanerModel *model) {
         @KBStrongObj(self);
        [self.headView setupArray:model.data.targetlist];
    } fail:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //刷新权限
    if ([KBUserInfoModel isLogin]) {
        [[KBApiLayer sharedInstance] loginShopSuccess:^(id model) {
            [KBRootViewController sharedInstaced].permissionModel = model;
            
        } fail:^(NSError *error) {
            
        }];
        [self follow];
        [self getMessageNoReadNumber];
        [self getTaskNoReadNumber];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods 私有方法

- (void)setupSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomTitle: @"酷BOSS"];
    UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBut.frame =CGRectMake(0,0, 23, 23);
    [leftBut setImage:[UIImage imageNamed:@"person"] forState:UIControlStateNormal];
    [leftBut addTarget:self action:@selector(onClickLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *leftButItem = [[UIBarButtonItem alloc]initWithCustomView:leftBut];
    self.navigationItem.leftBarButtonItem = leftButItem;
    
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame =CGRectMake(0,0, 22, 22);
    [rightBut setImage:[UIImage imageNamed:@"messgae"] forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(onClickRightMenu) forControlEvents:UIControlEventTouchUpInside];
    _rightButItem = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = _rightButItem;
    
    
    [self.view addSubview:self.tbView];
}

#pragma mark - Delegate 代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    KBWarMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[KBWarMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:[self.war objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
//    return self.war.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

#pragma mark - event response 所有触发的事件响应 按钮、通知、分段控件等

- (void)onClickLeftMenu
{
    NSLog(@"点击左侧");
    if (![KBGlobalControllerCenter sharedInstance].isClick) {
        [[KBGlobalControllerCenter sharedInstance].mmDrawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        [KBGlobalControllerCenter sharedInstance].isClick  = YES;
    }
    else{
        [[KBGlobalControllerCenter sharedInstance].mmDrawerController closeDrawerAnimated:YES completion:nil];
        [KBGlobalControllerCenter sharedInstance].isClick  = NO;
    }

  
}

- (void)onClickRightMenu
{
    if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeMessage]){
            [self.navigationController pushViewController:[NSClassFromString(@"KBMessageViewController") new] animated:YES];
    }
    
//        [self.navigationController pushViewController:[NSClassFromString(@"HousingListController") new] animated:YES];

//
    


}

#pragma mark - getters and setters 设置器和访问器

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableHeaderView = self.headView;
        _tbView.tableFooterView = [self bottomView];
        _tbView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    
    return _tbView;
    
}

- (void)getTaskNoReadNumber{
    
    
    KBTaskNumberRequest *request = [[KBTaskNumberRequest alloc] initWithUserid:[KBUserInfoModel uid]];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBTaskNumberModel *model = [KBTaskNumberModel yy_modelWithDictionary:dict];

        [self.headView setNumber:[model.data.approvalstatus integerValue]];
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (UIView *)bottomView
{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 46)];
    bottomView.backgroundColor = KBCOLOR_WITH_HEX(0xf4f4f4);
    UILabel *lable = [[UILabel  alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 46)];
    lable.textColor = KBCOLOR_WITH_HEX(0x666666);
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"-  我是有底线的  -";
    lable.font = [UIFont systemFontOfSize:12];
    [bottomView addSubview:lable];
    
    return bottomView;
}


- (KBRootHeadView *)headView
{
    if (!_headView) {
        _headView = [[KBRootHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1124 - 48)];
    }
    return _headView;
}


#pragma mark - public methods 公有方法

- (BOOL)isHavaPermission:(NSString *)permissionCode
{
    if (![KBRootViewController sharedInstaced].permissionModel) {
//        [KBAlter show:@"请检查权限" superView:[UIApplication sharedApplication].keyWindow];
        [KBAlter show:@"暂无权限" superView:[UIApplication sharedApplication].keyWindow];
        return NO;
    }
     __block BOOL isFind = NO;
    __block KBPermission *model = nil;
    [self.permissionModel.data.auth enumerateObjectsUsingBlock:^(KBPermission * permission, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([permissionCode isEqualToString:permission.code]) {
            if (permission.isGranted) {
                isFind = YES;
                model = permission;
                *stop = YES;
            }
        
        }
        
    }];
    
    if ([KBRootViewController sharedInstaced].permissionModel.data.auth.count == 0) {
    
        return YES;
    }
    else
    {
        if (!isFind) {
//            [KBAlter show:[NSString stringWithFormat:@"请检查%@权限",model.name] superView: [UIApplication sharedApplication].keyWindow];
            [KBAlter show:[NSString stringWithFormat:@"暂无权限"] superView: [UIApplication sharedApplication].keyWindow];
            return NO;
        }
        
    }
   
    return YES;
}

@end
