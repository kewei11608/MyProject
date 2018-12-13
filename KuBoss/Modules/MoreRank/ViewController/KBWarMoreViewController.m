//
//  KBWarMoreViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBWarMoreViewController.h"
#import "KBWarMessageCell.h"
#import "MJRefresh.h"

@interface KBWarMoreViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)NSMutableArray *war;
@property (nonatomic,assign)NSInteger indexPage;
@property (nonatomic,assign)BOOL isClear;
@end

@implementation KBWarMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle: @"更多战报"];
    self.war = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tbView];
    [self warList];
    self.indexPage = 1;
    self.isClear = NO;
   
     self.tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    //[self.tbView.mj_header beginRefreshing];
    
    
    // 上拉刷新
    self.tbView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    // Do any additional setup after loading the view.
}

- (void)loadNewComment
{
    self.indexPage  = 0;
    self.isClear = YES;
    [self warList];
}

- (void)loadMoreComments
{
    self.isClear = NO;
    [self warList];
}

- (void)warList
{
     @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance]  warReportPage:self.indexPage size:kPageSize success:^(KBWarReportModel *warModel) {
         @KBStrongObj(self);
        if (self.isClear) {
            [self.war removeAllObjects];
            [self.tbView.mj_header endRefreshing];
        }
        else
        {
            [self.tbView.mj_footer endRefreshing];
        }

        [self.war addObjectsFromArray:warModel.data];
        [self.tbView reloadData];
        if (self.war.count < self.indexPage * kPageSize) {
            [self.tbView.mj_footer endRefreshingWithNoMoreData];
        }
         self.indexPage  = self.indexPage + 1;
        [KBAlter hideLoadingForView:self.view];
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
    
}

#pragma mark - Delegate 代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    KBWarMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[KBWarMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    [cell setModel:[self.war objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.war.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

#pragma mark - getters and setters 设置器和访问器

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSelectionStyleDefault;
        _tbView.tableFooterView = [UIView new];
    }
    
    return _tbView;
    
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
