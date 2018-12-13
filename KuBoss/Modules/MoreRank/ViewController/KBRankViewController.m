//
//  KBRankViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRankViewController.h"
#import "KBRankHeadView.h"
#import "KBRankListTopCell.h"
#import "KBRankDetailViewController.h"
#import "KBAttributedStringTool.h"


@interface KBRankViewController ()
<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    dispatch_group_t downloadGroup;
}
@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)NSMutableArray *totalArray;
@property (nonatomic,copy) NSString *month;
@property (nonatomic,strong)KBRankModel *firstModel;
@property (nonatomic,strong)KBRankModel *secondModel;
@property (nonatomic,strong)KBRankModel *threeModel;

@end

@implementation KBRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"排行榜"];
    self.month= [self getMonth:-1 format:@"yyyy-MM"];
    self.totalArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tbView];
    // Do any additional setup after loading the view.
    [KBAlter showLoadingForView:self.view];
    downloadGroup = dispatch_group_create();
    [self rank1];
    [self rank2];
    [self rank3];
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        [self.totalArray addObject:self.firstModel.data];
        [self.totalArray addObject:self.secondModel.data];
        [self.totalArray addObject:self.threeModel.data];
        [self.tbView reloadData];
        [KBAlter hideLoadingForView:self.view];
        
        if (self.firstModel.data.count == 0&&self.secondModel.data.count == 0&&self.threeModel.data.count == 0) {
//            self.tbView.frame = CGRectMake(0, -20, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height);
            self.tbView.frame = CGRectMake(0, -20, self.view.ct_width, self.view.ct_height);
        }
        else{
//            self.tbView.frame = CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height);
            self.tbView.frame = CGRectMake(0, 0, self.view.ct_width, self.view.ct_height);
        }
    });
    
}

- (void)rank1
{
    @KBWeakObj(self);
     dispatch_group_enter(downloadGroup);
    [[KBApiLayer sharedInstance]  rankTradeType:-1 page:1 size:5  month: self.month  success:^(KBRankModel *model) {
        @KBStrongObj(self);
        [model.data enumerateObjectsUsingBlock:^(KBMidRankModel *midModel, NSUInteger idx, BOOL * _Nonnull stop) {
            midModel.index = idx + 1;
        }];
        self.firstModel = model;
        dispatch_group_leave(downloadGroup);
        //[self.totalArray addObject:model.data];
        //[self rank2];
    } fail:^(NSError *error) {
        
    }];
}

- (void)rank2
{
     @KBWeakObj(self);
     dispatch_group_enter(downloadGroup);
    [[KBApiLayer sharedInstance]  rankTradeType:0 page:1 size:5  month: self.month  success:^(KBRankModel *model) {
         @KBStrongObj(self);
        [model.data enumerateObjectsUsingBlock:^(KBMidRankModel *midModel, NSUInteger idx, BOOL * _Nonnull stop) {
            midModel.index = idx + 1;
        }];
        self.secondModel = model;
       // [self.totalArray addObject:model.data];
        // [self rank3];
         dispatch_group_leave(downloadGroup);
    } fail:^(NSError *error) {
        
    }];
}

- (void)rank3
{
    @KBWeakObj(self);
    dispatch_group_enter(downloadGroup);
    [[KBApiLayer sharedInstance]  rankTradeType:2 page:1 size:5  month:self.month success:^(KBRankModel *model) {
         @KBStrongObj(self);
        [model.data enumerateObjectsUsingBlock:^(KBMidRankModel *midModel, NSUInteger idx, BOOL * _Nonnull stop) {
            midModel.index = idx + 1;
        }];
        //[self.totalArray addObject:model.data];
        self.threeModel = model;
         dispatch_group_leave(downloadGroup);
       // [self.tbView reloadData];
    
    } fail:^(NSError *error) {
     
    }];
}



#pragma mark - Delegate 代理


- (NSMutableAttributedString *)getArrow:(NSString *)text
{
    NSMutableAttributedString  *m_attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@   ",text]];
    
    [m_attributedString addAttribute:NSForegroundColorAttributeName
                               value:KBCOLOR_WITH_HEX(0X666666)
                               range:NSMakeRange(0, text.length)];//设
    NSTextAttachment*textAttachment = [[NSTextAttachment alloc] init];
    //给附件添加图片
    textAttachment.image= [UIImage imageNamed:@"right_arrow"];
    //调整一下图片的位置,如果你的图片偏上或者偏下,调整一下bounds的y值即可
    textAttachment.bounds=CGRectMake(0, -3,8, 15);
    //把附件转换成可变字符串,用于替换掉源字符串中的表情文字
    NSAttributedString*imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [m_attributedString appendAttributedString:imageStr];
    return  m_attributedString;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    KBRankHeadView *rankHeadView = [[KBRankHeadView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 45)];
    @KBWeakObj(self);
    rankHeadView.rankBlock = ^{
        @KBStrongObj(self);
            KBRankDetailViewController *vc = [[KBRankDetailViewController alloc]initTotal:section startDate:nil endDate:nil];
            [self.navigationController pushViewController:vc animated:YES];
        
    };

   
    
    if (section == 0) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [array addObject:[KBAttributedStringModel initWithText:@"成交业绩榜 " font:[UIFont systemFontOfSize:14] color:KBCOLOR_WITH_HEX(0x333333)]];
//        [array addObject:[KBAttributedStringModel initWithText:@"总业绩看这里 " font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x666666)]];
        
        rankHeadView.leftLable.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array];
        
         rankHeadView.rightLable.attributedText = [self getArrow:@"总业绩看这里"];
    }
    else if (section == 1)
    {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [array addObject:[KBAttributedStringModel initWithText:@"成交边数榜 " font:[UIFont systemFontOfSize:14] color:KBCOLOR_WITH_HEX(0x333333)]];
       // [array addObject:[KBAttributedStringModel initWithText:@"二手房看这里 " font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x666666)]];
        
         rankHeadView.rightLable.attributedText = [self getArrow:@"二手房看这里"];
        
        rankHeadView.leftLable.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array];
    }
    else if (section == 2)
    {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [array addObject:[KBAttributedStringModel initWithText:@"新房成交榜 " font:[UIFont systemFontOfSize:14] color:KBCOLOR_WITH_HEX(0x333333)]];
//        [array addObject:[KBAttributedStringModel initWithText:@"新房成交看这里 " font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x666666)]];
        
        rankHeadView.rightLable.attributedText = [self getArrow:@"新房成交看这里"];
        
        rankHeadView.leftLable.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array];
    }
    
    return rankHeadView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView  *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, 10)];
    view.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    KBRankListTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[KBRankListTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0)
    {
        cell.rankListCellMode = RankListCellModeTop;
    }
    else
    {
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.totalArray.count -1 ) {
        return 0;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.firstModel.data.count == 0&&self.secondModel.data.count == 0&&self.threeModel.data.count == 0) {
        return 0;
    }
    return 45;
}

#pragma mark - getters and setters 设置器和访问器

- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
        _tbView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tbView.emptyDataSetSource = self;
        _tbView.emptyDataSetDelegate =self;
    }
    
    return _tbView;
    
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return  [UIImage imageNamed:@"norank"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"成交业绩榜、成交边数榜、新房成交榜本月暂无数据,敬请期待";
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:14.0]
                   range:NSMakeRange(0, text.length)];
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:KBCOLOR_WITH_HEX(0x666666)
                   range:NSMakeRange(0, text.length)];
    
    return attStr;
}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
