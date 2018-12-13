//
//  KBSystemMessageViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBSystemMessageViewController.h"
#import "KBCommonMessageCell.h"
#import "KBDetailMessageViewController.h"
#import "MJRefresh.h"

@interface KBSystemMessageViewController ()
<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)NSMutableArray *list;
@property (nonatomic,assign)NSInteger indexPage;
@property (nonatomic,assign)BOOL isClear;
@property (nonatomic,assign)NSInteger pageCount;
@end

@implementation KBSystemMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"系统公告"];
      self.view.backgroundColor = [UIColor whiteColor];
    self.list = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tbView];
    [self api];
    
    self.indexPage = 1;
    self.pageCount = 10000 ;
    self.isClear = NO;
    // Do any additional setup after loading the view.
    self.tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    //[self.tbView.mj_header beginRefreshing];
    
    
    // 上拉刷新
//    self.tbView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    [footer endRefreshingWithNoMoreData];
    [footer setTitle:@"-  我是有底线的  -" forState:MJRefreshStateNoMoreData];
    footer.backgroundColor = KBCOLOR_WITH_HEX(0xf4f4f4);
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    footer.mj_h = 30;
    footer.arrowView.alpha = 0;
    self.tbView.mj_footer = footer;
    // Do any additional setup after loading the view.
}

- (void)loadNewComment
{
    self.indexPage  = 1;
    self.isClear = YES;
    self.tbView.tableFooterView = [UIView new];
    self.pageCount = 10000;
    [self api];
}

- (void)loadMoreComments
{
//    if (self.indexPage >= self.pageCount) {
//        return;
//    }
    self.isClear = NO;
    [self api];
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
- (void)api
{
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance] messageAnnouncementAreaCode:[KBUserInfoModel areaCode] pageIndex:self.indexPage pageSize:kPageSize success:^(KBAnnouncementModel  *model) {
        if (self.isClear) {
            [self.list  removeAllObjects];
            [self.tbView.mj_header endRefreshing];
        }
        else
        {
            [self.tbView.mj_footer endRefreshing];
        }
        if (model.data.count < kPageSize) {
            [self.tbView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.list addObjectsFromArray:model.data];
        [self.tbView reloadData];
        self.pageCount = model.pageCount;
        if (self.indexPage<model.pageCount) {
            self.indexPage  = self.indexPage + 1;
           
        }
        else{
//            if (self.list.count!=0) {
//                self.tbView.tableFooterView = [self bottomView];
//            }
        }
  
        [KBAlter hideLoadingForView:self.view];

        
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
    
    KBCommonMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[KBCommonMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setAnnouncementItem:[self.list objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KBAnnouncementItem *item = [self.list objectAtIndex:indexPath.row];
    KBDetailMessageViewController *messageView = [[KBDetailMessageViewController alloc] initMessageId:[NSString stringWithFormat:@"%ld",item.announcementId] type:@"2"];
     [self.navigationController pushViewController:messageView animated:YES];
}

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableFooterView = [UIView new];
        _tbView.emptyDataSetSource = self;
        _tbView.emptyDataSetDelegate =self;
        _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

#pragma mark - DZNEmptyDataSetDelegate
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -100;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // button clicked...
    
   // [self.tbView.mj_header beginRefreshing];
    
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    self.tbView.contentOffset = CGPointZero;
}



@end
