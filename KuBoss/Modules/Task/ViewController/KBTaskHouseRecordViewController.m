//
//  KBTaskHouseRecordViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/5/30.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBTaskHouseRecordViewController.h"
#import "AccountRecodCell.h"
#import "AcountHeadView.h"
#import "UIImageView+WebCache.h"
@interface KBTaskHouseRecordViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tbView;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) KBAccountFreezeRecordListModel * recordModel;
@end

@implementation KBTaskHouseRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.list = [[NSMutableArray alloc]init];
    [self setCustomTitle:@"处理记录"];
    [self.view addSubview:self.tbView];
    
    
    [self.tbView registerNib:[UINib nibWithNibName:@"AccountRecodCell" bundle:nil] forCellReuseIdentifier:@"AccountRecodCell"];
    
    [self api];
}

- (void)api
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    [[KBApiLayer sharedInstance] taskHouseListRecordSuccess:^(KBAccountFreezeRecordListModel * model) {
        [KBAlter hideLoadingForView:self.view];
        @KBStrongObj(self);
        self.recordModel = model;
        [self.list addObject:model.data.monthData];
        [self.list addObject:model.data.oldData];
        [self.tbView reloadData];
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.list objectAtIndex:section];
    return array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.list.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    AcountHeadView *headView = [AcountHeadView loadViewFrom:@"AcountHeadView"];
    if (section == 0) {
        headView.titleLable.attributedText = [self getAttributedString:@"近一个月（" seconSting:[NSString stringWithFormat:@"%ld", self.recordModel.data.monthDataSize]];
    }
    else if(section == 1)
    {
        headView.titleLable.attributedText = [self getAttributedString:@"更早以前（" seconSting:[NSString stringWithFormat:@"%ld", self.recordModel.data.oldDataSize]];
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"AccountRecodCell";
    AccountRecodCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AccountRecodCell" owner:self options:nil] lastObject];
    }
    NSArray *array = [self.list objectAtIndex:indexPath.section];
    KBAccountFreezeRecordItem *model = [array objectAtIndex:indexPath.row];
    [cell.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.agenthead] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
    cell.nameLable.text = model.agentname;
    NSString *string = [NSString stringWithFormat:@"发起时间：%@",model.launchtime];
    cell.startLable.text = [string substringWithRange:NSMakeRange(0, 16)];
    
    if ([model.approvalstatus integerValue] == 1) {
        cell.freezeLable.text = @"接触冻结";
        cell.freezeLable.textColor = KBCOLOR_WITH_HEX(0x0AB768);
    }
    else{
        cell.freezeLable.text = @"离职处理";
        cell.freezeLable.textColor = KBCOLOR_WITH_HEX(0xF22424);
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [self.list objectAtIndex:indexPath.section];
    KBAccountFreezeRecordItem *model = [array objectAtIndex:indexPath.row];
    
//    KBTaskFreezeDetailVC *vc = [[KBTaskFreezeDetailVC alloc]initAccountId:[model.accountid integerValue] handle:NO];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.tableFooterView = [UIView new];
        _tbView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    
    return _tbView;
}




- (NSMutableAttributedString *)getAttributedString:(NSString *)firstString seconSting:(NSString *)secondString
{
    NSMutableAttributedString  *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@）",firstString,secondString]];
    
    NSRange firstrange = NSMakeRange(0, firstString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value: KBCOLOR_WITH_HEX(0x333333) range:firstrange];
    NSRange srange = NSMakeRange(firstString.length, secondString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:srange];
    
    return attributedString;
}

@end
