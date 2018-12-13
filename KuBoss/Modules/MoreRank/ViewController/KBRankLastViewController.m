//
//  KBRankLastViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/6/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRankLastViewController.h"
#import "KBRankHeadView.h"
#import "KBRankListTopCell.h"
#import "KBRankDetailViewController.h"

@interface KBRankLastViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)NSMutableArray *totalArray;
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,copy) NSString *month;
@property (nonatomic,copy) NSString *upmonth;
@property (nonatomic,copy) NSString *upupmonth;
@property (nonatomic,copy) NSString * currentMonth;
@end

@implementation KBRankLastViewController

- (instancetype)initTotal:(NSInteger) index month:(NSString *)date
{
    self = [super init];
    if (!self) return nil;
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    self.currentMonth =  [formatter stringFromDate:currentDate];
    self.currentMonth = date;
    self.index = index;

    self.month =  [self getMonth:-1];
    self.upmonth = [self getMonth:-2];
    self.upupmonth = [self getMonth:-3];
    
    
    return self;
}

- (NSString *)getMonth:(NSInteger )index{

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy年MM月";
    NSLog(@"%@",self.currentMonth);
    NSDate *currentDate = [fmt dateFromString:self.currentMonth];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setMonth:index];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    return [formatter stringFromDate:newdate];
}

- (NSString *)getHeaderMonth:(NSInteger )index{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy年MM月";
    NSLog(@"%@",self.currentMonth);
    NSDate *currentDate = [fmt dateFromString:self.currentMonth];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setMonth:index];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    return [formatter stringFromDate:newdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.totalArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tbView];
    // Do any additional setup after loading the view.
    [self rank1];
    
    if (self.index == 0) {
        [self setCustomTitle:@"历史成交业绩榜"];
    }
    else if (self.index == 1)
    {
        [self setCustomTitle:@"历史成交边数榜"];
    }
    else if (self.index == 2)
    {
        [self setCustomTitle:@"历史新房成交榜"];
    }
    
   
}

- (void)rank1
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    NSInteger type = -1;
    if (self.index == 1) {
        type = 0;
    } else if (self.index == 2) {
        type = 2;
    }
    [[KBApiLayer sharedInstance]  rankTradeType:type page:1 size:5   month:self.month success:^(KBRankModel *model) {
        @KBStrongObj(self);
        [model.data enumerateObjectsUsingBlock:^(KBMidRankModel *midModel, NSUInteger idx, BOOL * _Nonnull stop) {
            midModel.index = idx + 1;
        }];
        [self.totalArray addObject:model.data];
        [self rank2];
    } fail:^(NSError *error) {
        
    }];
}

- (void)rank2
{
    NSInteger type = -1;
    if (self.index == 1) {
        type = 0;
    } else if (self.index == 2) {
        type = 2;
    }
    @KBWeakObj(self);
    [[KBApiLayer sharedInstance]  rankTradeType:type page:1 size:5   month:self.upmonth success:^(KBRankModel *model) {
        @KBStrongObj(self);
        [model.data enumerateObjectsUsingBlock:^(KBMidRankModel *midModel, NSUInteger idx, BOOL * _Nonnull stop) {
            midModel.index = idx + 1;
        }];
        [self.totalArray addObject:model.data];
        [self rank3];
    } fail:^(NSError *error) {
        
    }];
}

- (void)rank3
{
    NSInteger type = -1;
    if (self.index == 1) {
        type = 0;
    } else if (self.index == 2) {
        type = 2;
    }
    @KBWeakObj(self);
    [[KBApiLayer sharedInstance]  rankTradeType:type page:1 size:5   month:self.upupmonth  success:^(KBRankModel *model) {
        @KBStrongObj(self);
        [model.data enumerateObjectsUsingBlock:^(KBMidRankModel *midModel, NSUInteger idx, BOOL * _Nonnull stop) {
            midModel.index = idx + 1;
        }];
        [self.totalArray addObject:model.data];
        [self.tbView reloadData];
        [KBAlter hideLoadingForView:self.view];
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}


- (NSString *)getMonthFirstDay:(NSInteger) index
{
  
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:index];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&firstDay interval:nil forDate:[NSDate date]];
    
    NSDateComponents *lastDateComponents = [calendar components:NSMonthCalendarUnit | NSYearCalendarUnit |NSDayCalendarUnit fromDate:firstDay];
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+dayNumberOfMonth-1];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:firstDay];
    
}

- (NSString *)getMonthLastDay:(NSInteger) index
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:index];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&firstDay interval:nil forDate:[NSDate date]];
    
    NSDateComponents *lastDateComponents = [calendar components:NSMonthCalendarUnit | NSYearCalendarUnit |NSDayCalendarUnit fromDate:firstDay];
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+dayNumberOfMonth-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:lastDay];
    
}

#pragma mark - Delegate 代理


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    KBRankHeadView *rankHeadView = [[KBRankHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 45)];
    @KBWeakObj(self);
    rankHeadView.rankBlock = ^{
        @KBStrongObj(self);
        if ([[self.totalArray objectAtIndex:section] count] == 0) {
            return;
        }
        
        KBRankDetailViewController *vc = [[KBRankDetailViewController alloc]initTotal:self.index startDate:[rankHeadView.rightLable.text stringByReplacingOccurrencesOfString:@"." withString:@"-"] endDate:[self getMonthLastDay:-section]];
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    if (section == 0) {
        rankHeadView.rightLable.attributedText = [self getArrow:[self getHeaderMonth:-1]];
    }
    else if (section == 1)
    {
      
         rankHeadView.rightLable.attributedText = [self getArrow:[self  getHeaderMonth:-2]];
    }
    else if (section == 2)
    {

         rankHeadView.rightLable.attributedText = [self getArrow:[self  getHeaderMonth:-3]];
    }
    
    if (self.index == 0) {
        rankHeadView.leftLable.text = @"成交业绩榜";
    }
    else if (self.index == 1)
    {
        rankHeadView.leftLable.text = @"成交边数榜";
    }
    else if (self.index == 2)
    {
        rankHeadView.leftLable.text =  @"新房成交榜";
    }
    
    return rankHeadView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    KBRankListTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[KBRankListTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    if (self.index == 0) {
         cell.rankListCellMode = RankListCellModeTop;
    }else{
        cell.rankListCellMode = RankListCellModeNoneTop;
    }
    [cell setModel:[((NSArray *)[self.totalArray objectAtIndex:indexPath.section]) objectAtIndex:indexPath.row]];
    
    if (indexPath.row == ((NSArray *)[self.totalArray objectAtIndex:indexPath.section]).count -1 ) {
        cell.lineView.hidden  = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((NSArray *)[self.totalArray objectAtIndex:section]).count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.totalArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView  *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, 40)];
    view.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    
    if ([[self.totalArray objectAtIndex:section] count] == 0) {
        NSString *title = @"该周期暂无数据";
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor darkGrayColor];
        [view addSubview:label];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.totalArray.count -1 ) {
        if ([[self.totalArray objectAtIndex:section] count] == 0) {
            return 50;
        }
        return 0;
    }
    if ([[self.totalArray objectAtIndex:section] count] == 0) {
        return 50;
    }
    return 10;
}

#pragma mark - getters and setters 设置器和访问器

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    
    return _tbView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
