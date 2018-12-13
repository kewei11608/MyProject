//
//  KBManagerAgentHeadView.m
//  KuBoss
//
//  Created by sunruixue on 2018/4/21.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBManagerAgentHeadView.h"
#import "KBRBAgentView.h"
#import "KBSeletedControl.h"
#import "UIView+Shadow.h"
//#import "PNChart/PNChart.h"
#import "KBFilterDateView.h"
#import "KBWebView.h"

#define kViewTag  300

@interface KBManagerAgentHeadView ()
@property (nonatomic,strong)KBRBAgentView *agentView;
//@property (nonatomic,strong)PNRadarChart *radarChart;
@property (nonatomic,strong)KBFilterDateView *filterView;
@property (nonatomic,strong) KBWebView  *webView;
@property (nonatomic,strong) NSString *exhibitiontype;
@property (nonatomic,strong) NSString *webUrl;
@property (nonatomic,strong)UIButton *dateBtn ;

@end
@implementation KBManagerAgentHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (!self) return nil;
    self.exhibitiontype = @"0";
    [self  setup];
    return self;
}

- (void)setup
{
    
    if ([KBUserDefaultLayer getFilterHouseType]) {
        NSString *str =  [KBUserDefaultLayer getFilterHouseType];
        if ([str integerValue] == 102) {
            self.isNew = YES;
        }
        else{
            self.isNew = NO;
        }
    } ;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.agentView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.agentView.ct_bottom, self.ct_width, 10)];
    lineView.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    [self addSubview:lineView];
    
    KBSeletedControl *seletedControl = [[KBSeletedControl alloc] initWithFrame:CGRectMake(0, self.agentView.ct_bottom+10, self.ct_width, 50) titleArray:@[@"二手房",@"租赁",@"新房"]];
    
    seletedControl.backgroundColor = [UIColor whiteColor];
    [self addSubview:seletedControl];
    
   
    @KBWeakObj(self);
    seletedControl.selectedIndexBlock = ^(UIButton *btn) {
        @KBStrongObj(self);
        NSLog(@"btn.tag == %ld",btn.tag);
        if (self.filterHousingBlock) {
            self.filterHousingBlock(btn.tag -100);
        }
    };
    
    self.dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     self.dateBtn.frame = CGRectMake(self.ct_width -self.ct_width/2 , self.agentView.ct_bottom+10, self.ct_width/2, 50);
     self.dateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string:[self getInitData]] forState:UIControlStateNormal];
    [self.dateBtn addTarget:self action:@selector(seletedAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.dateBtn];
    
  
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(15, seletedControl.ct_bottom+10, self.ct_width-30,267)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    bgView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    bgView.layer.shadowRadius = 2;//阴影半径，默认3
    [self addSubview:bgView];
    
    
    
   
    
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(15, 16, 5, 13)];
    leftView.backgroundColor = kMainColor;
    [bgView addSubview:leftView];
    
    UILabel *totalLable = [[UILabel alloc]initWithFrame:CGRectMake(leftView.ct_right+6, 15, 200, 16)];
    totalLable.text  = @"员工能力";
    totalLable.font = [UIFont boldSystemFontOfSize:15];
    [bgView addSubview:totalLable];
    
    self.webView = [[KBWebView alloc]initWithFrame:CGRectMake(0,totalLable.ct_bottom+10, bgView.ct_width, 210)];
    [bgView addSubview:self.webView];
    
    
    // 初始化，添加分段名，会自动布局
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"门店", @"地区"]];
    [bgView addSubview:segmentedControl];
    segmentedControl.frame = CGRectMake(bgView.ct_width - 110, 10, 100, 26);
    segmentedControl.tintColor = kMainColor;
    [segmentedControl addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventValueChanged];
    //    选中的颜色
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    //    未选中的颜色
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: kMainColor} forState:UIControlStateNormal];
    segmentedControl.selectedSegmentIndex = 0;
    
    

    
    
    
    NSArray *shopTitleArr = @[@"新增房源",@"新增客源带看",@"签约边数",@"新增客源",@"新增实勘作业量",@"签约业绩"];
    NSArray *shopTitleVauleArr = @[@"0",@"0",@"0",@"0",@"0",@"0万"];
    
    for (int i = 0; i<6; i++) {
        
        UILabel *lableTitle = [[UILabel alloc]initWithFrame:CGRectMake((i%3)*self.ct_width/3, bgView.ct_bottom+25+(i/3)*75, self.ct_width/3, 15)];
        lableTitle.font = [UIFont systemFontOfSize:15];
        lableTitle.textColor = KBCOLOR_WITH_HEX(0x666666);
        lableTitle.textAlignment = NSTextAlignmentCenter;
        lableTitle.text = shopTitleArr[i];
        lableTitle.tag  = 1000+i;
        [self addSubview:lableTitle];
        
        UILabel *lableValue = [[UILabel alloc]initWithFrame:CGRectMake(lableTitle.ct_left, lableTitle.ct_bottom+8, self.ct_width/3, 15)];
        lableValue.font = [UIFont systemFontOfSize:15];
        lableValue.textColor = KBCOLOR_WITH_HEX(0x333333);
        lableValue.textAlignment = NSTextAlignmentCenter;
        lableValue.text = shopTitleVauleArr[i];
        lableValue.tag = kViewTag+i;
        [self addSubview:lableValue];
        
    }
    
    
    UIView *lineVi2 = [[UIView alloc]initWithFrame:CGRectMake(15,bgView.ct_bottom+15+65, self.ct_width-30, 1)];
    lineVi2.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    [self addSubview:lineVi2];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, bgView.ct_bottom+160, self.ct_width, 10)];
    lineView1.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    [self addSubview:lineView1];
    
    UIView *leftView1 = [[UIView alloc]initWithFrame:CGRectMake(15, lineView1.ct_bottom+10, 5, 13)];
    leftView1.backgroundColor = kMainColor;
    [self addSubview:leftView1];
    
    UILabel *totalLable1 = [[UILabel alloc]initWithFrame:CGRectMake(leftView1.ct_right+6, leftView1.ct_top, 200, 16)];
    totalLable1.text  = @"员工动态";
    totalLable1.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:totalLable1];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(leftView1.ct_left, totalLable1.ct_bottom+10, self.ct_width-leftView1.ct_left, 1)];
    line.backgroundColor = KBCOLOR_WITH_HEX(0xe2e1e2);
    [self addSubview:line];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(leftView1.ct_left, line.ct_bottom+6, self.ct_width, 20)];
    lable.text = @"无员工动态";
    lable.textColor = KBCOLOR_WITH_HEX(0x333333);
    lable.font = [UIFont systemFontOfSize:14];
    [self addSubview:lable];
    self.noDataLabel = lable;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    btn.frame = CGRectMake(self.ct_width-55, totalLable1.ct_top, 40, 20);
    [btn setTitleColor:kMainColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    [self addSubview:self.filterView];
    self.filterView.hidden = YES;
    self.filterView.filterDateBlock = ^(KBDateMode mode, NSInteger type, NSString *data) {
        @KBStrongObj(self);
        NSString *tilteString = [NSString stringWithFormat:@"%@ %@",data,[self getDateModeString:mode]];
        [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string:tilteString] forState:UIControlStateNormal];
        if (self.filterVDateViewBlock) {
            self.filterVDateViewBlock(mode, type, data);
        }
    };
    
    self.filterView.hideSelfBlock = ^{
        @KBStrongObj(self);
        [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string: [self getInitData]] forState:UIControlStateNormal];
    };
    
    
    
}



- (void)more
{
    if (self.agentMoreBlock) {
        self.agentMoreBlock();
    }
}

- (void)seletedAction
{
    if (!self.filterView.hidden) {
        [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_dark" string: [self getInitData]] forState:UIControlStateNormal];
        
    }
    else{
        [self.dateBtn setAttributedTitle:[self setTitleName:@"down_arrow_light" string: [self getInitData]] forState:UIControlStateNormal];
        
    }
     self.filterView.hidden = !self.filterView.hidden;
}


- (KBRBAgentView *)agentView
{
    if (!_agentView) {
        _agentView = [[KBRBAgentView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, 80)];
        @KBWeakObj(self);
        _agentView.tellBlock = ^{
            @KBStrongObj(self);
            if (self.tellBlock) {
                self.tellBlock();
            }
        };
    }
    return _agentView;
}

-(void)selectedAction:(UISegmentedControl *)Seg{
    NSInteger index = Seg.selectedSegmentIndex;
    self.exhibitiontype =  [NSString stringWithFormat:@"%ld",index];
    [self.webView loadRequestUrl:[self totalWebView]];
    
}

- (void)setModel:(KBBottomShopAgentModel *)model
{
    //NSArray *shopTitleArr = @[@"新增房源",@"新增带看",@"签约单数",@"新增客源",@"新增实勘",@"签约业绩"];
    [self.agentView setName:model.agentname shop:model.officename iphone:model.agentphone avatarUrl:model.akealooksdata];
    
    if (self.isNew) {
        for ( int i = 0; i<6; i++) {
            UILabel *lableValue  = [self viewWithTag:i+1000];
            if (lableValue) {
                switch (i) {
                    case 0:
                        lableValue.text =@"经纪人报备";
                        break;
                    case 1:
                        lableValue.text = @"案场确客";
                        break;
                    case 2:
                        lableValue.text =  @"成交单数";
                        break;
                    case 3:
                        lableValue.text = @"经纪人带看";
                        break;
                    case 4:
                        lableValue.text = @"认购新房";
                        break;
                    case 5:
                        lableValue.text = @"成交业绩";
                        break;
                        
                    default:
                        break;
                }
            }
        }
        for ( int i = 0; i<6; i++) {
            UILabel *lableValue  = [self viewWithTag:i+kViewTag];
            if (lableValue) {
                switch (i) {
                    case 0:
                        lableValue.text = model.addreportnumber;
                        break;
                    case 1:
                        lableValue.text = model.addaccurateguestnumber;
                        break;
                    case 2:
                        lableValue.text = [NSString stringWithFormat:@"%.f", [model.agencysidesnumber doubleValue]];
                        break;
                    case 3:
                        lableValue.text = model.addtakealookinumber;
                        break;
                    case 4:
                        lableValue.text = model.addsubscribenumber;
                        break;
                    case 5:
                        lableValue.text = [NSString stringWithFormat:@"%.2f 万", [model.agencyperformance doubleValue]];
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
    else
    {
   
        for ( int i = 0; i<6; i++) {
            UILabel *lableValue  = [self viewWithTag:i+1000];
            if (lableValue) {
                switch (i) {
                    case 0:
                        lableValue.text =@"新增房源";
                        break;
                    case 1:
                        lableValue.text = @"新增客源带看";
                        break;
                    case 2:
                        lableValue.text =  @"签约边数";
                        break;
                    case 3:
                        lableValue.text = @"新增客源";
                        break;
                    case 4:
                        lableValue.text = @"新增实勘作业量";
                        break;
                    case 5:
                        lableValue.text = @"签约业绩";
                        break;
                        
                    default:
                        break;
                }
            }
        }
        for ( int i = 0; i<6; i++) {
            UILabel *lableValue  = [self viewWithTag:i+kViewTag];
            if (lableValue) {
                switch (i) {
                    case 0:
                        lableValue.text = model.addavailabilitynumber;
                        break;
                    case 1:
                        lableValue.text = model.addtakealookinumber;
                        break;
                    case 2:
                        lableValue.text = [NSString stringWithFormat:@"%.1f", [model.agencysidesnumber doubleValue]];
                        break;
                    case 3:
                        lableValue.text = model.addtouristnumber;
                        break;
                    case 4:
                        lableValue.text = model.addrealservicenumber;
                        break;
                    case 5:
                        lableValue.text = [NSString stringWithFormat:@"%.2f 万",[model.agencyperformance doubleValue]];
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }

    
}

- (void)setAgentModel:(KBAgenListModel *)agentModel
{
    [self.agentView setName:agentModel.agentname shop:nil iphone:agentModel.agentphone avatarUrl:agentModel.akealooksdata];
}

- (KBFilterDateView *)filterView
{
    if (!_filterView) {
        
        _filterView = [[KBFilterDateView alloc]initWithFrame:CGRectMake(0, self.agentView.ct_bottom+60, self.ct_width, kDeviceHeight-60)];
    }
    return _filterView;
}

- (void)setFilterDataModel:(KBFilterDateModel *) filterDateModel
{
    [self.filterView setFilterDataModel:filterDateModel];
}

- (void)loadWebViewradarChatTimeType:(NSString *)timeType
                           daterange:(NSString *)daterange
                         housingtype:(NSString *)housingtype
                             agentId:(NSString *)agentId
{
    self.webUrl = [NSString stringWithFormat:@"%@%@/radar_chart?userid=%@&agentid=%@&timetype=%@&daterange=%@&housingtype=%@",httpApi,httpFilePath,[KBUserInfoModel encodeUid],agentId,timeType,daterange,housingtype];
    
    [self.webView loadRequestUrl:[self totalWebView]];
}

- (NSString *)totalWebView
{
    return  [NSString stringWithFormat:@"%@&exhibitiontype=%@", self.webUrl,self.exhibitiontype];
}




@end
