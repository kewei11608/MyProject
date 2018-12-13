//
//  KBRootOscillogramView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/4.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRootOscillogramView.h"
#import "KBWebView.h"
@interface KBRootOscillogramView ()
@property (nonatomic,strong)UISegmentedControl *segmentedControl;
@property (nonatomic,strong)KBWebView *curveView;

@end
@implementation KBRootOscillogramView

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
    // 初始化，添加分段名，会自动布局
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"日走势", @"周走势"]];
    [self addSubview:self.segmentedControl];
    self.segmentedControl.frame = CGRectMake(15, 20, 100, 26);
    self.segmentedControl.tintColor = kMainColor;
    [self.segmentedControl addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventValueChanged];
    //    选中的颜色
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    //    未选中的颜色
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: kMainColor} forState:UIControlStateNormal];
    self.segmentedControl.selectedSegmentIndex = 0;
    
    self.curveView = [[KBWebView alloc]initWithFrame:CGRectMake(15, self.segmentedControl.ct_bottom+20, self.ct_width-30, 200)];
    [self addSubview:self.curveView];
   
    
    UILabel *followLable1 = [[UILabel alloc]initWithFrame:CGRectMake(self.ct_width-200-15, 24, 200, 16)];
    followLable1.text  = @"经纪人带看量走势";
    followLable1.textColor = KBCOLOR_WITH_HEX(0X999999);
    followLable1.font = [UIFont systemFontOfSize:12];
    followLable1.textAlignment = NSTextAlignmentRight;
    [self addSubview:followLable1];
}

-(void)selectedAction:(UISegmentedControl *)Seg{
    NSInteger index = Seg.selectedSegmentIndex;
     [self.curveView loadRequestUrl:[NSString stringWithFormat:@"%@%@/chart_Index_line?type=%ld&userid=%@",httpApi,httpFilePath,index+1,KBUserInfoModel.encodeUid]];
}
- (void)updateView
{
    self.segmentedControl.selectedSegmentIndex = 0;
     [self.curveView loadRequestUrl:[NSString stringWithFormat:@"%@%@/chart_Index_line?type=%d&userid=%@",httpApi,httpFilePath,1,KBUserInfoModel.encodeUid]];
}

@end
