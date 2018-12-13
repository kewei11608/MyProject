//
//  KBTaskAcounttFreezeRecordViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBTaskAcounttFreezeRecordViewController.h"
#import "AccountRecodCell.h"
#import "AcountHeadView.h"
#import "UIImageView+WebCache.h"
#import "KBTaskFreezeDetailVC.h"
#import "KBTaskHouseDetailViewController.h"

@interface KBTaskAcounttFreezeRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tbView;
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) KBAccountFreezeRecordListModel * recordModel;
@property (nonatomic,assign) BOOL   isRecord;
@property (nonatomic,strong) KBAccountFreezeRecordListModel * recordListModel;
@end

@implementation KBTaskAcounttFreezeRecordViewController
- (instancetype)initRecord:(BOOL )isRecord
{
    self = [super init];
    if (!self) return nil;
    self.isRecord = isRecord;
    return self;
}
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
    if (self.isRecord) {
        [[KBApiLayer sharedInstance] taskAccountFreezelistRecordSuccess:^(KBAccountFreezeRecordListModel * model) {
            @KBStrongObj(self);
            [KBAlter hideLoadingForView:self.view];
            self.recordModel = model;
            if (model.data.monthData.count != 0) {
                 [self.list addObject:model.data.monthData];
            }
            
            if (model.data.oldData.count != 0) {
                  [self.list addObject:model.data.oldData];
            }
            self.recordListModel = model;
            [self.tbView reloadData];
        } fail:^(NSError *error) {
            [KBAlter hideLoadingForView:self.view];
        }];
    }
    else
    {
        [[KBApiLayer sharedInstance] taskHouseListRecordSuccess:^(KBAccountFreezeRecordListModel * model) {
            @KBStrongObj(self);
            [KBAlter hideLoadingForView:self.view];
            self.recordModel = model;
            if (model.data.nearlyamonth.count != 0) {
                [self.list addObject:model.data.nearlyamonth];
            }
            if (model.data.earlier.count != 0) {
                [self.list addObject:model.data.earlier];
            }
            [self.tbView reloadData];
        } fail:^(NSError *error) {
            [KBAlter hideLoadingForView:self.view];
        }];
    }
  
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
    
    if (self.isRecord) {
        if (self.list.count == 2) {
            if (section == 0 &&self.recordListModel.data.monthData.count!=0) {
                headView.titleLable.attributedText = [self getAttributedString:@"近一个月（" seconSting:[NSString stringWithFormat:@"%ld", self.recordModel.data.monthDataSize]];
            }
            else if(section == 1)
            {
                headView.titleLable.attributedText = [self getAttributedString:@"更早以前（" seconSting:[NSString stringWithFormat:@"%ld", self.recordModel.data.oldDataSize]];
            }
        }
        else  if (self.list.count == 1)
        {
            if (self.recordListModel.data.monthData.count!=0) {
                 headView.titleLable.attributedText = [self getAttributedString:@"近一个月（" seconSting:[NSString stringWithFormat:@"%ld", self.recordModel.data.monthDataSize]];
            }
            if (self.recordListModel.data.oldData.count!=0) {
                   headView.titleLable.attributedText = [self getAttributedString:@"更早以前（" seconSting:[NSString stringWithFormat:@"%ld", self.recordModel.data.oldDataSize]];
            }
            
        }
       
    }
    else
    {
        if (self.list.count == 2) {
            if (section == 0 &&self.recordModel.data.nearlyamonth.count!=0) {
                headView.titleLable.attributedText = [self getAttributedString:@"近一个月（" seconSting:[NSString stringWithFormat:@"%ld", self.recordModel.data.monthDataSize]];
            }
            else if(section == 1&&self.recordModel.data.earlier.count!=0)
            {
                headView.titleLable.attributedText = [self getAttributedString:@"更早以前（" seconSting:[NSString stringWithFormat:@"%ld", self.recordModel.data.oldDataSize]];
            }
        }
        if (self.recordModel.data.nearlyamonth.count!=0) {
            headView.titleLable.attributedText = [self getAttributedString:@"近一个月（" seconSting:[NSString stringWithFormat:@"%ld", self.recordModel.data.nearlyamonthnumber]];
        }
        if (self.recordModel.data.earlier.count!=0) {
            headView.titleLable.attributedText = [self getAttributedString:@"更早以前（" seconSting:[NSString stringWithFormat:@"%ld", self.recordModel.data.earliernumber]];
        }
        
      
    }
    
  
    if (!self.isRecord) {
        headView.subLable.text  = @"非流通房源转流通申请";
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
    cell.freezeLable.textColor =  KBCOLOR_WITH_HEX(0x666666);
    NSString *string = [NSString stringWithFormat:@"发起时间：%@",model.launchtime];
    cell.startLable.text = [string substringWithRange:NSMakeRange(0, 21)];
    NSString *str =  [model.audittime substringWithRange:NSMakeRange(0, 10)];
    if ([model.approvalstatus integerValue] == 0)
    {
         cell.freezeLable.attributedText = [self getAttributedString:@"待审批" firsColor:[UIColor darkGrayColor] seconSting:str] ;
    }
    else if ([model.approvalstatus integerValue] == 1) {
        
        cell.freezeLable.attributedText = [self getAttributedString:@"审批通过" firsColor:KBCOLOR_WITH_HEX(0x0AB768) seconSting:str] ;
        
    }
    else if ([model.approvalstatus integerValue] == 2){
        cell.freezeLable.attributedText = [self getAttributedString:@"申请拒绝" firsColor:KBCOLOR_WITH_HEX(0xF22424) seconSting:str] ;
       
    }
    else if ([model.approvalstatus integerValue] == 3) {
        cell.freezeLable.attributedText = [self getAttributedString:@"离职处理" firsColor:KBCOLOR_WITH_HEX(0xF22424) seconSting:str] ;
        
    }
    else if ([model.approvalstatus integerValue] == 4){
         cell.freezeLable.attributedText = [self getAttributedString:@"解除冻结" firsColor:KBCOLOR_WITH_HEX(0x0AB768) seconSting:str] ;
    }
    

    
   
   
    return cell;
    
}

- (NSMutableAttributedString *)getAttributedString:(NSString *)firstString firsColor:(UIColor *) color  seconSting:(NSString *)secondString
{
    NSMutableAttributedString  *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  %@",firstString,secondString]];
    
    NSRange firstrange = NSMakeRange(0, firstString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value: color
                             range:firstrange];
    
    [attributedString addAttribute:NSFontAttributeName
                             value: [UIFont systemFontOfSize:14]
                             range:firstrange];
    
    NSRange srange = NSMakeRange(firstString.length+2, secondString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value: KBCOLOR_WITH_HEX(0x666666)
                             range:srange];
    
    [attributedString addAttribute:NSFontAttributeName
                             value: [UIFont systemFontOfSize:13]
                             range:srange];
    
    return attributedString;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [self.list objectAtIndex:indexPath.section];
    KBAccountFreezeRecordItem *model = [array objectAtIndex:indexPath.row];
    
    if (self.isRecord) {
        KBTaskFreezeDetailVC *vc = [[KBTaskFreezeDetailVC alloc]initAccountId:model.approvaid handle:NO];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        KBTaskHouseDetailViewController *vc = [[KBTaskHouseDetailViewController alloc]initApprovaid:model.approvaid record:NO];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
  
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
