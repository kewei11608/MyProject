//
//  KBLQDetailHeadView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQDetailHeadView.h"
@interface KBLQDetailHeadView ()
@property (nonatomic,strong)UILabel *titleLable;

@end
@implementation KBLQDetailHeadView

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
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, 10)];
    lineView.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    [self addSubview:lineView];
    
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, self.ct_width-30, 16)];
    self.titleLable.font = [UIFont boldSystemFontOfSize:15];
    self.titleLable.textColor = [UIColor blackColor];
    self.titleLable.text = @"";
    [self addSubview:self.titleLable];
    
    // 初始化，添加分段名，会自动布局
   
    
}

-(void)selectedAction:(UISegmentedControl *)Seg{
    NSInteger index = Seg.selectedSegmentIndex;
    if (self.selectdBlock) {
        self.selectdBlock(index);
    }
    
}

- (void)setModel:(KBLQDetailModel *)model
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UISegmentedControl class]]) {
            [view removeFromSuperview];
        }
    }
    NSString *firstString = @"总低量化次数";
    NSString *secondString = [NSString stringWithFormat:@"（%ld）",model.data.zongshu];
    NSMutableAttributedString  *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",firstString,secondString]];
    
    NSRange firstrange = NSMakeRange(0, firstString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value: KBCOLOR_WITH_HEX(0x666666) range:firstrange];
    NSRange srange = NSMakeRange(firstString.length, secondString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:srange];
    self.titleLable.attributedText = attributedString;
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[[NSString stringWithFormat:@"每周低量化(%ld)",model.data.zhoushu], [NSString stringWithFormat:@"每月低量化(%ld)",model.data.yueshu]]];
    [self addSubview:segmentedControl];
    segmentedControl.frame = CGRectMake(50, self.titleLable.ct_bottom+15, self.ct_width-100, 26);
    segmentedControl.tintColor = kMainColor;
    [segmentedControl addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventValueChanged];
    //    选中的颜色
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    //    未选中的颜色
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: kMainColor} forState:UIControlStateNormal];
    segmentedControl.selectedSegmentIndex = 0;
}

@end
