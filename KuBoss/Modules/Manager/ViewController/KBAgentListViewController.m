//
//  KBAgentListViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/5/17.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBAgentListViewController.h"
#import "KBAgentCell.h"
#import "MJRefresh.h"
@interface KBAgentListViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)NSMutableArray  *list;
@property (nonatomic,copy)NSString   *agentId;
@property (nonatomic,assign)NSInteger indexPage;
@property (nonatomic,assign)BOOL isClear;

@end

@implementation KBAgentListViewController

- (instancetype) initAgentId:(NSString *)agentId
{
    self = [super init];
    if (!self) return nil;
    self.agentId = agentId;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle: @"员工动态"];
    self.list = [[NSMutableArray alloc]init];
    [self.view addSubview:self.tbView];
    [self agentlist];
    self.indexPage = 1;
    self.isClear = NO;
    
    self.tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    //[self.tbView.mj_header beginRefreshing];
    
    
    // 上拉刷新
    self.tbView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

- (void)loadNewComment
{
    self.indexPage  = 0;
    self.isClear = YES;
    [self agentlist];
}

- (void)loadMoreComments
{
    self.isClear = NO;
    [self agentlist];
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
    return self.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KBBottomEDModel *model = self.list[indexPath.row];
    return ([model array].count+2)*20;;
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
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tbView.emptyDataSetSource = self;
        _tbView.emptyDataSetDelegate =self;
        _tbView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, 20)];
        
    }
    
    return _tbView;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return  [UIImage imageNamed:@"noaMessage"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"暂时没有新的消息";
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:14.0]
                   range:NSMakeRange(0, text.length)];
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:KBCOLOR_WITH_HEX(0x666666)
                   range:NSMakeRange(0, text.length)];
    
    return attStr;
}



- (void)agentlist
{

     @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance]  edWithType:1 agentid:[self.agentId integerValue] page:self.indexPage success:^(KBEDModel * model) {
         @KBStrongObj(self);
        if (self.isClear) {
            [self.list  removeAllObjects];
            [self.tbView.mj_header endRefreshing];
        }
        else
        {
            [self.tbView.mj_footer endRefreshing];
        }
        self.indexPage  = self.indexPage + 1;
        [self.list addObjectsFromArray:model.data.EmployeeDynamicslist];
        [self.tbView reloadData];
        [KBAlter hideLoadingForView:self.view];
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}

@end
