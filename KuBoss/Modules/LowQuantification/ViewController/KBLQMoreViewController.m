//
//  KBLQMoreViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQMoreViewController.h"
#import "KBLQMoreHeadView.h"
#import "KBLQMoreCell.h"
#import "KBLQDetailViewController.h"

@interface KBLQMoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)NSMutableArray *list;

@end

@implementation KBLQMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.list = [[NSMutableArray alloc]init];
    [self setCustomTitle:@"低量化预警记录"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tbView];
    [self api];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [KBUserBehavior  behaviorEventId:KBEnterLQRecordPageEventId];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)api
{
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance] lqRecordListSuccess:^(KBLQRecordModel *model) {
        [KBAlter hideLoadingForView:self.view];
        [self.list removeAllObjects];
        [self.list addObjectsFromArray:model.data.symddlhxxtj];
        [self.tbView reloadData];
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}

#pragma mark - Delegate 代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    KBLQMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[KBLQMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    KBLQRecordShop *shop =  [self.list objectAtIndex:indexPath.section];
    KBLQRecordAgent *agent = [shop.jjrlist objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:agent];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    KBLQRecordShop *shop =  [self.list objectAtIndex:section];
    if (shop.isOpen) {
        return shop.jjrlist.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    KBLQMoreHeadView *titleView = [[KBLQMoreHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 50)];
    KBLQRecordShop *shop =  [self.list objectAtIndex:section];
    titleView.tag = section;
    [titleView setTitle: [self getAttributedString:[NSString stringWithFormat:@"%@(",shop.officename] seconSting:[NSString stringWithFormat:@"%lu",(unsigned long)shop.jjrlist.count]]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHead:)];
    tap.numberOfTapsRequired =1;
    tap.numberOfTouchesRequired =1;
    titleView.userInteractionEnabled = YES;
    [titleView addGestureRecognizer:tap];
    
    if (shop.isOpen) {
        titleView.img.frame = CGRectMake(titleView.ct_width-35, (titleView.ct_height-10)/2, 18, 10);
        titleView.img.image = [UIImage imageNamed:@"down_arrow"];
    }
    else{
        titleView.img.frame = CGRectMake(titleView.ct_width-35, (titleView.ct_height-20)/2, 10, 18);
        titleView.img.image = [UIImage imageNamed:@"right_arrow"];
    }
    
    return titleView;
}
- (NSMutableAttributedString *)getAttributedString:(NSString *)firstString seconSting:(NSString *)secondString
{
    NSMutableAttributedString  *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@）",firstString,secondString]];
    
    NSRange firstrange = NSMakeRange(0, firstString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value: KBCOLOR_WITH_HEX(0x666666) range:firstrange];
    NSRange srange = NSMakeRange(firstString.length, secondString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:srange];
    
    return attributedString;
}


- (void)clickHead:(UITapGestureRecognizer* )tap
{
    KBLQRecordShop *shop =  [self.list objectAtIndex:tap.view.tag];
    shop.isOpen = !shop.isOpen;
    [self.tbView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [KBUserBehavior  behaviorEventId:KBClickLQAgentDetialEventId];
    KBLQRecordShop *shop =  [self.list objectAtIndex:indexPath.section];
    KBLQRecordAgent *agent = [shop.jjrlist objectAtIndex:indexPath.row];
    KBLQDetailViewController *vc = [[KBLQDetailViewController alloc]initAgentId:agent.agentid];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - event response 所有触发的事件响应 按钮、通知、分段控件等
- (void)onClickRightMenu
{
    [self.navigationController pushViewController:[NSClassFromString(@"KBLQSettingViewController") new] animated:YES];
}


#pragma mark - getters and setters 设置器和访问器

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableFooterView = [UIView new];
        _tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    
    return _tbView;
    
}

//- (KBLQHeadView *)headView
//{
//    if (!_headView) {
//        _headView = [[KBLQHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 440)];
//    }
//    return _headView;
//}



@end
