//
//  KBManagerAgentViewController.m
//  KuBoss
//
//  Created by sunruixue on 2018/4/21.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBManagerAgentViewController.h"
#import "KBManagerAgentHeadView.h"
#import "KBManagerAgentCell.h"
#import "KBFilterDateView.h"
#import "KBAgentCell.h"
#import "KBAgentListViewController.h"
#import "KBAgentFootView.h"
#import "KBLQMoreViewController.h"


@interface KBManagerAgentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)KBManagerAgentHeadView *headView;
@property (nonatomic,strong)NSMutableArray  *list;
@property (nonatomic,copy)NSString   *agentId;
@property (nonatomic,strong) KBAgentFootView  *footView;

@property (nonatomic,assign) NSInteger  timetype;
@property (nonatomic,assign) NSInteger  daterange;
@property (nonatomic,assign) NSInteger  housingtype;

@property (nonatomic,strong)KBAgenListModel *agentModel;

@end

@implementation KBManagerAgentViewController

- (instancetype) initAgentModel:(KBAgenListModel *)agentModel
{
    self = [super init];
    if (!self) return nil;
    self.agentId = agentModel.agentid;
    self.agentModel = agentModel;
    self.timetype = 1;
    self.daterange = 1;
    self.housingtype =0;
    if ([KBUserDefaultLayer getLeftFilterDate])
    {
        self.timetype = [[KBUserDefaultLayer getLeftFilterDate] integerValue]+1;
    };
    
    
    if ([KBUserDefaultLayer getTypeFilterDate]) {
        self.daterange =  [[KBUserDefaultLayer getTypeFilterDate] integerValue];
    };
    
    if ([KBUserDefaultLayer getFilterHouseType]) {
        self.housingtype = [[KBUserDefaultLayer getFilterHouseType] integerValue] - 100;
    }
    
  
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.list = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomTitle: @"经纪人详情"];
    [self.view addSubview:self.tbView];
    [self agentId:[self.agentId integerValue] timetype:self.timetype daterange:self.daterange housingtype:self.housingtype];
    [self agentlist];
    [self laAgent];
     @KBWeakObj(self);
    self.headView.agentMoreBlock = ^{
        @KBStrongObj(self);
        if (self.list.count == 0){
            [KBAlter  show:@"暂无员工动态" superView:self.view];
            return ;
        }
        [KBUserBehavior  behaviorEventId:KBClickEmployeeDynamicsEventId];
        KBAgentListViewController *vc = [[KBAgentListViewController alloc]initAgentId:self.agentId];
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.headView.filterHousingBlock = ^(NSInteger housingType) {
         @KBStrongObj(self);
        self.housingtype = housingType;
        if (housingType == 2) {
            self.headView.isNew = YES;
        }
        else{
            self.headView.isNew = NO;
        }
     
        [self agentId:[self.agentId integerValue] timetype:self.timetype daterange:self.daterange housingtype:self.housingtype];
    };
    
    self.headView.filterVDateViewBlock = ^(KBDateMode mode, NSInteger type, NSString *data) {
         @KBStrongObj(self);
        if (KBDateModeDay == mode)
        {
            [KBUserBehavior  behaviorEventId:KBAgentYesterdaysDataEventId];
        }
        else if (KBDateModeWeek == mode)
        {
            [KBUserBehavior  behaviorEventId:KBAgentWeeklyDataEventId];
        }
        else if (KBDateModeMonth == mode)
        {
            [KBUserBehavior  behaviorEventId:KBAgentMonthlyDataEventId];
        }
        self.daterange = type;
        self.timetype = mode;
        [self agentId:[self.agentId integerValue] timetype:self.timetype daterange:self.daterange housingtype:self.housingtype];
    };
    
    self.headView.tellBlock = ^{
         [KBUserBehavior  behaviorEventId:KBClickAgentPhoneEventId];
    };
     [self filteData];
    [self.headView setAgentModel:self.agentModel];
    
    self.footView.clickDetailBlock = ^{
        @KBStrongObj(self);
        KBLQMoreViewController *vc = [[KBLQMoreViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [KBUserBehavior  behaviorEventId:KBEnterAgentDetailEventId];
}

- (void)filteData
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance]   filterDateSuccess:^(KBFilterDateModel * filterModel) {
        @KBStrongObj(self);
        [KBAlter hideLoadingForView:self.view];
        [self.headView setFilterDataModel:filterModel];
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
    
    KBAgentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[KBAgentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KBBottomEDModel *model = self.list[indexPath.row];
    [cell setModel:model];
    cell.isLast = indexPath.row == self.list.count - 1;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.headView.noDataLabel.hidden = self.list.count;
    return self.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KBBottomEDModel *model = self.list[indexPath.row];
    return ([model array].count+2)*20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableHeaderView = self.headView;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.tableFooterView = self.footView;
        
    }
    
    return _tbView;
}

- (KBManagerAgentHeadView*)headView
{
    if (!_headView) {
        _headView = [[KBManagerAgentHeadView alloc]initWithFrame:CGRectMake(0, 0,self.view.ct_width, 640)];
        _headView.clipsToBounds = YES;
    }
    return _headView;
}

- (KBAgentFootView *)footView
{
    if (!_footView) {
        _footView = [[KBAgentFootView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 140)];
    }
    return _footView;
}

- (void)agentId:(NSInteger )agentId timetype:(NSInteger)timetype daterange:(NSInteger)daterange housingtype:(NSInteger)housingtype
{
  
    [self.headView loadWebViewradarChatTimeType:[NSString stringWithFormat:@"%ld",timetype]
                                      daterange:[NSString stringWithFormat:@"%ld",daterange]
                                    housingtype:[NSString stringWithFormat:@"%ld",housingtype]
                                        agentId:self.agentId];
    @KBWeakObj(self);
    [[KBApiLayer sharedInstance] shopAgentid:agentId
                 timetype:timetype
                daterange:daterange
              housingtype:housingtype
                  success:^(KBShopAgentModel * model) {
                       @KBStrongObj(self);
                      NSArray *  array = model.data.zrzsj;
                      if (array.count>0) {
                        KBBottomShopAgentModel *shopAgentModel = array.firstObject;
                          [self.headView setModel:shopAgentModel];
                      }
                  } fail:^(NSError *error) {
                      
                  }];
    
}

- (void)agentlist
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance] edWithType:0 agentid: [self.agentId integerValue] page:0 success:^(KBEDModel * model) {
         @KBStrongObj(self);
        [KBAlter hideLoadingForView:self.view];
        [self.list removeAllObjects];
        [self.list addObjectsFromArray:model.data.EmployeeDynamicslist];
        [self.tbView reloadData];
        
        if (self.list.count == 0)
        {
            self.headView.frame = CGRectMake(0, 0,self.view.ct_width, 700);
            self.tbView.tableHeaderView = self.headView;
        }
        else
        {
            self.headView.frame = CGRectMake(0, 0,self.view.ct_width, 640);
            self.tbView.tableHeaderView = self.headView;
        }
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}

- (void)laAgent
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance]  lqAgentid:self.agentId success:^(KBLQModel * model) {
        @KBStrongObj(self);
        [self.footView setModel:model.data];
         [KBAlter hideLoadingForView:self.view];
    } fail:^(NSError *error) {
         [KBAlter hideLoadingForView:self.view];
    }];
}

@end
