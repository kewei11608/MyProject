//
//  KBRootColumnView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/4.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRootColumnView.h"
#import "KBWebView.h"

@interface KBRootColumnView ()
@property (nonatomic,strong)UISegmentedControl *segmentedControl;
@property (nonatomic,strong)KBWebView *columView;


@end
@implementation KBRootColumnView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)  return nil;
    self.backgroundColor = [UIColor whiteColor];
    [self setup];
    return self;
}


- (void) setup
{
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(15, 16, 5, 13)];
    leftView.backgroundColor = kMainColor;
    [self addSubview:leftView];
    
    UILabel *followLable = [[UILabel alloc]initWithFrame:CGRectMake(leftView.ct_right+6, 15, 200, 16)];
    followLable.text  = @"带看分析";
    followLable.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:followLable];
    

    
    // 初始化，添加分段名，会自动布局
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"昨日", @"一周"]];
    [self addSubview:self.segmentedControl];
    self.segmentedControl.frame = CGRectMake(15, followLable.ct_bottom+23, 100, 26);
    self.segmentedControl.tintColor = kMainColor;
    [self.segmentedControl addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventValueChanged];
    //    选中的颜色
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    //    未选中的颜色
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: kMainColor} forState:UIControlStateNormal];
    self.segmentedControl.selectedSegmentIndex = 0;
    
    self.columView = [[KBWebView alloc]initWithFrame:CGRectMake(15, self.segmentedControl.ct_bottom+20, self.ct_width-30, 200)];
    [self addSubview:self.columView];
  
    

    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(15, leftView.ct_bottom+15, self.ct_width-15, 1)];
    line.backgroundColor = KBCOLOR_WITH_HEX(0xE2E2E2);
    [self addSubview:line];
    [self bringSubviewToFront:line];
    
    UILabel *followLable1 = [[UILabel alloc]initWithFrame:CGRectMake(self.ct_width-200-15, line.ct_bottom+18, 200, 16)];
    followLable1.text  = @"经纪人带看量分布";
    followLable1.textColor = KBCOLOR_WITH_HEX(0X999999);
    followLable1.font = [UIFont systemFontOfSize:12];
    followLable1.textAlignment = NSTextAlignmentRight;
    [self addSubview:followLable1];
    
    
}

-(void)selectedAction:(UISegmentedControl *)Seg{
    NSInteger index = Seg.selectedSegmentIndex;
    [self.columView loadRequestUrl:[NSString stringWithFormat:@"%@%@/chart_Index_bar?type=%ld&userid=%@",httpApi,httpFilePath,index+1,KBUserInfoModel.encodeUid]];
    
}

- (void)updateView
{
    self.segmentedControl.selectedSegmentIndex = 0;
      [self.columView loadRequestUrl:[NSString stringWithFormat:@"%@%@/chart_Index_bar?type=%d&userid=%@",httpApi,httpFilePath,1,KBUserInfoModel.encodeUid]];
}



@end
