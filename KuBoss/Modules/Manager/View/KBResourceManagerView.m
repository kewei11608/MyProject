//
//  KBResourceManagerView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBResourceManagerView.h"
#import "KBUpdateFootView.h"
#import "KBResourceManagerViewCell.h"
#import "KBShopFilterView.h"
@interface KBResourceManagerView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tbView;
@property (nonatomic,strong)KBUpdateFootView *footView;
@property (nonatomic,strong)KBShopFilterView * shopFilterView;
@property (nonatomic,strong)KBSymdxxzhModel * secondHandModel;
@property (nonatomic,strong)KBSymdxxzhModel * rentModel;
@property (nonatomic,strong)KBSymdxxzhModel * houseModel;
@property (nonatomic,assign)BOOL  isFirst;
@property (nonatomic,strong)UIImageView *img;
@property (nonatomic,strong)UILabel *totalLable;
@property (nonatomic,strong)NSString *shopName;

@end
@implementation KBResourceManagerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    [self setup];
    return self;
}

- (void)setup
{
     self.shopName = @"汇总数据";
    [self addSubview:self.headView];
    [self addSubview:self.tbView];
    
    [self addSubview:self.shopFilterView];
    
    self.shopFilterView.hidden = YES;
    @KBWeakObj(self);
    self.shopFilterView.filterShopBlock = ^(NSString *shopId,NSString *shopName) {
        @KBStrongObj(self);
        if (self.filterShopBlock) {
            self.filterShopBlock(shopId);
        }
        
        self.shopName = shopName;

        self.totalLable.attributedText = [self setTitleName:@"down_arrow_dark" title: self.shopName];
    };
    

}


- (void)setModel:(KBResourceManagerModel *)model
{
  
    [self.footView setTitle:model.data.gxrq];
    
    
    if (!self.isFirst) {
        KBShopListModel *firstModel =  [[KBShopListModel alloc]init];
        firstModel.officename =  @"汇总数据";
        firstModel.officeid = @"0";
        firstModel.isSame = YES;
        self.isFirst = YES;
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [array addObject:firstModel];
        [array addObjectsFromArray:model.data.ggmdim];
        [self.shopFilterView  setShopList:array];
    }
  
    [model.data.mdxxzh enumerateObjectsUsingBlock:^(KBSymdxxzhModel *listmodel, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([listmodel.tradetype integerValue] == 0) {
            self.secondHandModel = listmodel;
        }
        if ([listmodel.tradetype integerValue] == 1) {
            self.rentModel = listmodel;
        }
        
        if ([listmodel.tradetype integerValue] == 2) {
            self.houseModel = listmodel;
        }
        
    }];
    [self.tbView reloadData];
    
}

- (NSMutableAttributedString *)getAttributedString:(NSString *)firstString seconSting:(NSString *)secondString thirdSting:(NSString *)thirdSting
{
    NSMutableAttributedString  *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@%@",firstString,secondString,thirdSting]];
    
    NSRange firstrange = NSMakeRange(0, firstString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value: KBCOLOR_WITH_HEX(0x666666) range:firstrange];
    NSRange srange = NSMakeRange(firstString.length, secondString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:srange];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:srange];
    
    
    return attributedString;
}
#pragma mark - Delegate 代理

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CELLID";
    
    KBResourceManagerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[KBResourceManagerViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            cell.leftImg.backgroundColor = KBCOLOR_WITH_HEX(0xD8D8D8);
            cell.lable.attributedText = [self getAttributedString:@"库存房源 " seconSting:self.secondHandModel.realtynumber thirdSting:[NSString stringWithFormat:@" 人均%@",self.secondHandModel.realtynumberavg]];
            cell.toalView.backgroundColor = KBCOLOR_WITH_HEX(0xD8D8D8);
            cell.currentView.backgroundColor = KBCOLOR_WITH_HEX(0x6B7BFF);
            if ([self.secondHandModel.realtynumber integerValue] == 0)
            {
                cell.currentView.frame = CGRectMake(15, 38, 0, 10);
            }
            else{
                cell.currentView.frame = CGRectMake(15, 38, (cell.ct_width-30)*(([self.secondHandModel.bambooflagnumber doubleValue]/[self.secondHandModel.realtynumber doubleValue]) > 1 ? 1 : ([self.secondHandModel.bambooflagnumber doubleValue]/[self.secondHandModel.realtynumber doubleValue])), 10);
            }
            cell.bottopmLeftImg.backgroundColor =  KBCOLOR_WITH_HEX(0x6B7BFF);;
            cell.bottomTitle.text = [NSString stringWithFormat:@"笋盘%@",self.secondHandModel.bambooflagnumber];
       
            
        }
        if (indexPath.row == 1)
        {
            cell.leftImg.backgroundColor = KBCOLOR_WITH_HEX(0xD8D8D8);
            cell.lable.attributedText = [self getAttributedString:@"库存客源 " seconSting:self.secondHandModel.customernumber thirdSting:[NSString stringWithFormat:@" 人均%@",self.secondHandModel.customernumberavg]];
            cell.toalView.backgroundColor = KBCOLOR_WITH_HEX(0xD8D8D8);
            cell.currentView.backgroundColor = KBCOLOR_WITH_HEX(0x9877FF);

            cell.currentView.frame = CGRectMake(15, 38, (cell.ct_width-30)* ([self.secondHandModel.showpercentage floatValue]*0.01 > 1 ? 1 : [self.secondHandModel.showpercentage floatValue]*0.01), 10);
            
            cell.bottopmLeftImg.backgroundColor = KBCOLOR_WITH_HEX(0x9877FF);
            cell.bottomTitle.text = [NSString stringWithFormat:@"近30日内有带看%.1f%%",[self.secondHandModel.showpercentage floatValue]];
            
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            cell.leftImg.backgroundColor = KBCOLOR_WITH_HEX(0xD8D8D8);
            cell.lable.attributedText = [self getAttributedString:@"库存房源 " seconSting:self.rentModel.realtynumber thirdSting:[NSString stringWithFormat:@" 人均%@",self.rentModel.realtynumberavg]];
            cell.toalView.backgroundColor = KBCOLOR_WITH_HEX(0xFCC342);
            cell.currentView.backgroundColor = KBCOLOR_WITH_HEX(0x6B7BFF);
            if ([self.rentModel.realtynumber integerValue] == 0)
            {
                cell.currentView.frame = CGRectMake(15, 38, 0, 10);
            }
            else{
                cell.currentView.frame = CGRectMake(15, 38, (cell.ct_width-30)* (([self.rentModel.leasehold doubleValue]/[self.rentModel.realtynumber doubleValue]) > 1 ? 1 : ([self.rentModel.leasehold doubleValue]/[self.rentModel.realtynumber doubleValue])), 10);
            }
            cell.bottopmLeftImg.backgroundColor =  KBCOLOR_WITH_HEX(0x6B7BFF);;
            cell.bottomTitle.text = [NSString stringWithFormat:@"租赁房源%@",self.rentModel.leasehold];
            
            cell.bottopmLeftImg1.backgroundColor =  KBCOLOR_WITH_HEX(0xFCC342);;
            cell.bottomTitle1.text = [NSString stringWithFormat:@"租售房源%@",self.rentModel.rentalhousing];
            
            
        }
        if (indexPath.row == 1)
        {
            cell.leftImg.backgroundColor = KBCOLOR_WITH_HEX(0xD8D8D8);
            cell.lable.attributedText = [self getAttributedString:@"库存客源 " seconSting:self.rentModel.customernumber thirdSting:[NSString stringWithFormat:@" 人均%@",self.rentModel.customernumberavg]];
            cell.toalView.backgroundColor = KBCOLOR_WITH_HEX(0xD8D8D8);
            cell.currentView.backgroundColor = KBCOLOR_WITH_HEX(0x61A0FD);
            
            cell.currentView.frame = CGRectMake(15, 38, (cell.ct_width-30)* (([self.rentModel.showpercentage floatValue]*0.01) > 1 ? 1 : ([self.rentModel.showpercentage floatValue]*0.01)), 10);
            
            cell.bottopmLeftImg.backgroundColor = KBCOLOR_WITH_HEX(0x61A0FD);
            cell.bottomTitle.text = [NSString stringWithFormat:@"近30日内有带看%.1f%%",[self.rentModel.showpercentage floatValue]];
            
        }
    }
    
     else if (indexPath.section == 2)
     {
         cell.leftImg.backgroundColor = KBCOLOR_WITH_HEX(0xD8D8D8);
         cell.lable.attributedText = [self getAttributedString:@"新房报备 " seconSting:self.houseModel.reportnumber thirdSting:[NSString stringWithFormat:@" 人均%@",self.houseModel.reportnumberavg]];
         cell.toalView.backgroundColor = KBCOLOR_WITH_HEX(0xD8D8D8);
         cell.currentView.backgroundColor = KBCOLOR_WITH_HEX(0x8F9BFF);
         cell.bottopmLeftImg.backgroundColor =  KBCOLOR_WITH_HEX(0x8F9BFF);;
         cell.bottomTitle.text =[NSString stringWithFormat:@"近30日内有带看%.1f%%",[self.houseModel.showpercentage floatValue]];
         cell.currentView.frame = CGRectMake(15, 38, (cell.ct_width-30)* (([self.houseModel.showpercentage floatValue]*0.01) > 1 ? 1 : ([self.houseModel.showpercentage floatValue]*0.01)), 10);

     }
    
    if (indexPath.row == 1 ) {
        cell.lineView.hidden = YES;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 2;
    }
    if (section == 2) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 )
    {
        return 100;
    }
    
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        return 120;
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        return 92;
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        return 105;
    }
    return 71;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, 55)];
    bgView.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);;
    
    UIView *forebgView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, self.ct_width, 45)];
    forebgView.backgroundColor = [UIColor whiteColor];
    
    [bgView addSubview:forebgView];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(15, 16, 5, 13)];
    leftView.backgroundColor = kMainColor;
    [forebgView addSubview:leftView];
    
    UILabel *totalLable = [[UILabel alloc]initWithFrame:CGRectMake(leftView.ct_right+6, 12, 200, 18)];
    totalLable.font = [UIFont boldSystemFontOfSize:15];
    [forebgView addSubview:totalLable];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 54, self.ct_width-15, 1)];
    [bgView addSubview:lineView];
    lineView.backgroundColor = KBCOLOR_WITH_HEX(0xe2e2e2);
    
    
    if (section == 0)
    {
        totalLable.text  = @"二手房";
    }
    else if (section == 1)
    {
        totalLable.text  = @"租赁";
    }
    else if  (section == 2)
    {
        totalLable.text  = @"新房";
    }
    
    
    
    return bgView;
}



- (UITableView *)tbView
{
    if (!_tbView) {
        _tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, self.ct_width, self.ct_height - 45) style:UITableViewStylePlain];
        _tbView.delegate = self;
        _tbView.dataSource = self;
       // _tbView.tableHeaderView = [self headView];
        _tbView.tableFooterView = self.footView;
        
    }
    
    return _tbView;
}


- (NSMutableAttributedString *)setTitleName:(NSString *)imageName title:(NSString* )title
{
    NSMutableAttributedString  *m_attributedString = [[NSMutableAttributedString alloc]initWithString:title];
    NSTextAttachment*textAttachment = [[NSTextAttachment alloc] init];
    //给附件添加图片
    textAttachment.image= [UIImage imageNamed:imageName];
    //调整一下图片的位置,如果你的图片偏上或者偏下,调整一下bounds的y值即可
    textAttachment.bounds=CGRectMake(0, -4, textAttachment.image.size.width, textAttachment.image.size.height);
    //把附件转换成可变字符串,用于替换掉源字符串中的表情文字
    NSAttributedString*imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [m_attributedString appendAttributedString:imageStr];
    
    return m_attributedString;
}

- (UIView *)headView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, 45)];
    view.backgroundColor = [UIColor whiteColor];
    
    self.totalLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, 200, 16)];
    self.totalLable.font = [UIFont boldSystemFontOfSize:15];
    self.totalLable.text  = @"汇总数据";
    [view addSubview:self.totalLable];
    self.totalLable.attributedText = [self setTitleName:@"down_arrow_dark" title: self.shopName];
    
//    self.img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"down_arrow_dark"]];
//    self.img.frame  = CGRectMake(80, 16, 12, 12);
//    [view addSubview:self.img];
    
    self.totalLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.totalLable addGestureRecognizer:tap];
    
    return view;
}

- (KBUpdateFootView *)footView
{
    if (!_footView) {
        _footView = [[KBUpdateFootView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, 33)];
    }
    return _footView;
}

- (KBShopFilterView *)shopFilterView
{
    if (!_shopFilterView) {
        _shopFilterView = [[KBShopFilterView alloc]initWithFrame:CGRectMake(0, 45, self.ct_width, self.ct_height-45)];
    }
    return _shopFilterView;
}


- (void)click
{

    self.totalLable.attributedText = [self setTitleName:@"down_arrow_light" title: self.shopName];
    self.shopFilterView.hidden = NO;

}

@end
