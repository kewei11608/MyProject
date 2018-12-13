//
//  AcounttFreezeView.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "AcounttFreezeView.h"
#import "AcounttFreezeCell.h"
#import "UIImageView+WebCache.h"
#import <MJRefresh.h>

@interface AcounttFreezeView ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (strong, nonatomic) NSMutableArray *list;
@property (strong,nonatomic) UIView *bottomView;

@end
@implementation AcounttFreezeView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.list = [[NSMutableArray alloc]init];
    [self.tbView registerNib:[UINib nibWithNibName:@"AcounttFreezeCell" bundle:nil] forCellReuseIdentifier:@"AcounttFreezeCell"];
    self.tbView.tableFooterView = [UIView new];
//    self.tbView.tableFooterView = [self bottomView];
    self.tbView.emptyDataSetSource  = self;
    self.tbView.emptyDataSetDelegate = self;
//    self.bottomView.hidden = YES;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
    }];
    [footer endRefreshingWithNoMoreData];
    [footer setTitle:@"————  门店管理，在于每一天的积累  ————" forState:MJRefreshStateNoMoreData];
//    footer.backgroundColor = KBCOLOR_WITH_HEX(0xf4f4f4);
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"————  门店管理，在于每一天的积累  ————"];
    [string addAttribute:NSForegroundColorAttributeName value:KBCOLOR_WITH_HEX(0xe2e2e2) range:NSMakeRange(0, string.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, string.length)];
    
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(6, 13)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(6, 13)];

    footer.stateLabel.attributedText = string;
    footer.mj_h = 40;
    self.tbView.mj_footer = footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"AcounttFreezeCell";
    AcounttFreezeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AcounttFreezeCell" owner:self options:nil] lastObject];
    }
    KBAccountFreezeModel *model = [self.list objectAtIndex:indexPath.row];
    [cell.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.agenthead] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
    cell.nameLable.text = model.agentname;
    NSString *string ;
    if (!self.isHouse) {
        string = [NSString stringWithFormat:@"发起时间：%@",model.frozentime];
    }
    else{
        string = [NSString stringWithFormat:@"发起时间：%@",model.launchtime];
    }
    if (string.length > 21) {
        string = [string substringWithRange:NSMakeRange(0,21)];
    }
    
    cell.timeLable.text = string;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KBAccountFreezeModel *model = [self.list objectAtIndex:indexPath.row];
    if (self.detailBlock) {
        if (!self.isHouse) {
            self.detailBlock(model.accountid);
        }
        else{
            self.detailBlock(model.approvaid);
        }
       
    }
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kDeviceWidth, 30)];
        _bottomView.backgroundColor = KBCOLOR_WITH_HEX(0xf4f4f4);
        UILabel *lable = [[UILabel  alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, 30)];
        lable.textColor = KBCOLOR_WITH_HEX(0x666666);
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = @"-  我是有底线的  -";
        lable.font = [UIFont systemFontOfSize:12];
        [_bottomView addSubview:lable];
    }
    
    
    return _bottomView;
}

- (void)setModel:(KBAccountFreezeListModel *)model
{
    [self.list removeAllObjects];
    if (!self.isHouse) {
        [self.list addObjectsFromArray:model.data.freezeList];
        self.titleLable.attributedText = [self getAttributedString:@"待审批（" seconSting:[NSString stringWithFormat:@"%ld",(long)model.data.freezeCount]];
        KBAccountFreezeModel *mod =model.data.freezeList.firstObject;
        self.subLable.text = mod.approveType;
    }
    else
    {
        [self.list addObjectsFromArray:model.data.arrays];
        self.titleLable.attributedText = [self getAttributedString:@"待审批（" seconSting:[NSString stringWithFormat:@"%ld",(long)model.data.unapprovednumber]];
        self.subLable.text = @"非流通房源转流通申请";
    }
        if (self.list.count == 0) {
            self.subTitle.hidden = YES;
            self.subLable.hidden = YES;
            self.line.hidden = YES;
            self.titleLable.hidden = YES;
//            self.bottomView.hidden = YES;
        }
        else{
            self.subTitle.hidden = NO;
            self.subLable.hidden = NO;
            self.line.hidden = NO;
            self.titleLable.hidden = NO;
//            self.bottomView.hidden = NO;
            
        }
    self.tbView.hidden = NO;
    
    [self.tbView reloadData];
    
 
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

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -75;
}


- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"noResult"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text =@"\n您暂时没有需要审批的任务，天下太平~";
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    // 设置所有字体大小为 #15
    [attStr addAttribute:NSFontAttributeName
                   value:[UIFont systemFontOfSize:14.0]
                   range:NSMakeRange(0, text.length)];
    // 设置所有字体颜色为浅灰色
    [attStr addAttribute:NSForegroundColorAttributeName
                   value:KBCOLOR_WITH_HEX(0x666666)
                   range:NSMakeRange(0, text.length)];
     [attStr appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];

    return attStr;
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
//    if (self.isHouse) {
//        return nil;
//    }
     return  [self convertViewToImage:[self clickBtn]];
}


-(UIImage *)convertViewToImage:(UIView *)view{
    CGSize size = view.bounds.size;
    //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIButton *)clickBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 150, 40);
    btn.backgroundColor = kMainColor;
    [btn setTitle:@"去看看低量化预警" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    return btn;
}

#pragma mark - DZNEmptyDataSetDelegate

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // button clicked...
    if (self.goToLowBlock) {
        self.goToLowBlock();
    }
   
    
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    self.tbView.contentOffset = CGPointZero;
}




@end
