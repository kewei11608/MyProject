//
//  KBLQDetailViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQDetailViewController.h"
#import "KBLQAgentView.h"
#import "KBLQDetailHeadView.h"
#import "KBLQDetailCell.h"
#import "KBLQItemViewController.h"
@interface KBLQDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)KBLQAgentView *agentView;
@property (nonatomic,strong)KBLQDetailHeadView *detailView;

@property (nonatomic,strong)NSMutableArray *weekList;
@property (nonatomic,strong)NSMutableArray *monthList;
@property (nonatomic,assign)BOOL  isMonth;
@property (nonatomic,assign)NSInteger  agentId;
@property (nonatomic,strong)KBLQDetailModel *detailModel;

@end

@implementation KBLQDetailViewController

- (instancetype)initAgentId:(NSInteger) agentId
{
    self = [super init];
    if (!self) return nil;
    self.agentId = agentId;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.weekList = [[NSMutableArray alloc]init];
    self.monthList= [[NSMutableArray alloc]init];
    [self setCustomTitle:@"低量化预警详情"];
    self.view.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    [self.view addSubview:self.agentView];
    [self.view addSubview:self.tbView];
    @KBWeakObj(self);
    self.detailView.selectdBlock = ^(NSInteger index) {
        @KBStrongObj(self);
        if (index == 0) {
            self.isMonth = NO;
            [KBUserBehavior  behaviorEventId:KBClickLQWeeklyListEventId];
        }else{
            [KBUserBehavior  behaviorEventId:KBClickLQMonthlyListEventId];
            self.isMonth = YES;
        }
        
        [self.tbView reloadData];
    };
    
    self.agentView.tellBlock = ^{
         [KBUserBehavior  behaviorEventId:KBClickLQAgentPhoneEventId];
    };
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self api];
}

- (void)api
{
    [KBAlter showLoadingForView:self.view];
    @KBWeakObj(self);
    [[KBApiLayer sharedInstance] lqDetailTimetype:0 agentid:self.agentId success:^(KBLQDetailModel * model) {
        [KBAlter hideLoadingForView:self.view];
        @KBStrongObj(self);
        [self.weekList removeAllObjects];
        [self.monthList removeAllObjects];
        [self.agentView setModel:model];
        [self.detailView setModel:model];
        [self.weekList addObjectsFromArray:model.data.zdlhxqjh];
        [self.monthList addObjectsFromArray:model.data.ydlhxqjh];
        [self.tbView reloadData];
        self.detailModel = model;
        
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Delegate 代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    KBLQDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[KBLQDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KBLQDetailWeek *model;
    if (self.isMonth) {
        model=  self.monthList[indexPath.row];
    }
    else
        model=  self.weekList[indexPath.row];
    [cell setModel:model isWeek:!self.isMonth];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isMonth) {
        return self.monthList.count;
    }
    else
    return self.weekList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KBLQDetailWeek *model;
    KBLQItemViewController *vc;
    if (self.isMonth) {
        [KBUserBehavior behaviorEventId:KBClickWeeklyLQEventId];
        model=  self.monthList[indexPath.row];
        vc = [[KBLQItemViewController alloc]initBool:YES agentId:[model.agentid integerValue] lqid:model.lowquantificationrid];
    }
    else
    {
        [KBUserBehavior behaviorEventId:KBClickMonthlyLQEventId];
        model=  self.weekList[indexPath.row];
        vc = [[KBLQItemViewController alloc]initBool:NO agentId:[model.agentid integerValue] lqid:model.lowquantificationrid];
       
    }
    [vc setModel:self.detailModel];
    

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - event response 所有触发的事件响应 按钮、通知、分段控件等


#pragma mark - getters and setters 设置器和访问器

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.agentView.ct_bottom, self.view.ct_width, self.view.ct_height-self.agentView.ct_bottom-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, 10)];
        _tbView.tableHeaderView = self.detailView;
        _tbView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    
    return _tbView;
    
}

- (KBLQDetailHeadView *)detailView
{
    if (!_detailView) {
        _detailView = [[KBLQDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 90)];
    }
    return _detailView;
}

- (KBLQAgentView *)agentView
{
    if (!_agentView) {
        _agentView = [[KBLQAgentView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 100)];
    }
    return _agentView;
}



@end
