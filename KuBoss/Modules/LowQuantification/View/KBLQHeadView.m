//
//  KBLQHeadView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/11.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQHeadView.h"
#import "KBCustomCurveView.h"
@interface KBLQHeadView ()

@end
@implementation KBLQHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor = [UIColor whiteColor];
    [self setup];
    return self;
}

- (void)setup
{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(15, 16, 5, 13)];
    leftView.backgroundColor = kMainColor;
    [self addSubview:leftView];
    UILabel *followLable = [[UILabel alloc]initWithFrame:CGRectMake(leftView.ct_right+6, 15, 200, 16)];
    followLable.text  = @"预警分析";
    followLable.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:followLable];
    
    // 初始化，添加分段名，会自动布局
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"每周", @"每月"]];
    [self addSubview:segmentedControl];
    segmentedControl.frame = CGRectMake(15, followLable.ct_bottom+23, 100, 26);
    segmentedControl.tintColor = kMainColor;
    [segmentedControl addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventValueChanged];
    //    选中的颜色
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    //    未选中的颜色
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: kMainColor} forState:UIControlStateNormal];
    segmentedControl.selectedSegmentIndex = 0;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(self.ct_width-100, 14, 80, 14);
    [btn setTitle:@"更多预警记录" forState:UIControlStateNormal];
    [btn setTitleColor:kMainColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.ct_width- 180, 65, 150, 13)];
    timeLab.text = @"2017.12.23-2017.12.29";
    timeLab.font = [UIFont systemFontOfSize:12];
    timeLab.textColor = KBCOLOR_WITH_HEX(0x666666);
    timeLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:timeLab];

    UILabel *timelow = [[UILabel alloc]initWithFrame:CGRectMake(15, segmentedControl.ct_bottom+210, self.ct_width-30, 14)];
    timelow.text = @"低量化标准： 3房 1客 1带 1勘";
    timelow.font = [UIFont systemFontOfSize:13];
    timelow.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:timelow];
    
    
    UIView *proessBgView = [[UIView alloc]initWithFrame:CGRectMake(15, timelow.ct_bottom+15, self.ct_width-30, 10)];
    proessBgView.backgroundColor = KBCOLOR_WITH_HEX(0xD8D8D8);
    proessBgView.layer.masksToBounds = YES;
    proessBgView.layer.cornerRadius = 5;
    [self addSubview:proessBgView];
    
    UIView *proessForeView = [[UIView alloc]initWithFrame:CGRectMake(15, timelow.ct_bottom+15, (self.ct_width-30)*0.4, 10)];
    proessForeView.backgroundColor = kMainColor;
    proessForeView.layer.masksToBounds = YES;
    proessForeView.layer.cornerRadius = 5;
    [self addSubview:proessForeView];
    
    UILabel *foreLab = [[UILabel alloc]initWithFrame:CGRectMake(15, proessForeView.ct_bottom+16, 150, 13)];
    foreLab.text = @"当前周期尚未结束";
    foreLab.font = [UIFont systemFontOfSize:12];
    foreLab.textColor = KBCOLOR_WITH_HEX(0xFF3B30);
    [self addSubview:foreLab];
    
    UILabel *backLab = [[UILabel alloc]initWithFrame:CGRectMake(self.ct_width-150-15, proessForeView.ct_bottom+16, 150, 14)];
    backLab.text = @"完成率：80% 24人/51人";
    backLab.font = [UIFont systemFontOfSize:13];
    backLab.textAlignment = NSTextAlignmentRight;
    backLab.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:backLab];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    lineView.frame = CGRectMake(0, self.ct_bottom-58, self.ct_width, 10);
    [self addSubview:lineView];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(15, self.ct_bottom-28, 5, 13)];
    bottomView.backgroundColor = kMainColor;
    [self addSubview:bottomView];
    UILabel *bottomLable = [[UILabel alloc]initWithFrame:CGRectMake(bottomView.ct_right+6, bottomView.ct_top, 200, 16)];
    bottomLable.text  = @"低量化详情";
    bottomLable.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:bottomLable];
    
    KBCustomCurveView *cureView =  [[KBCustomCurveView alloc]initWithFrame:CGRectMake(0, segmentedControl.ct_bottom, self.ct_width, 200)];
    [self addSubview:cureView];
    
    
}

- (void)loadMore
{
    if (self.loadMoreBlock) {
        self.loadMoreBlock();
    }
}


-(void)selectedAction:(UISegmentedControl *)Seg{
    NSInteger index = Seg.selectedSegmentIndex;
    
}


@end
