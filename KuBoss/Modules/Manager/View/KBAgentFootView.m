//
//  KBAgentFootView.m
//  KuBoss
//
//  Created by yuyang on 2018/5/13.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBAgentFootView.h"
@interface KBAgentFootView ()
@property (nonatomic,strong) UILabel *fLab;
@property (nonatomic,strong) UILabel *sLab;
@property (nonatomic,strong) UILabel *tLab;

@end
@implementation KBAgentFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
   // self.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    self.backgroundColor = [UIColor whiteColor];
    [self setup];
    return self;
}

- (void)setup
{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, 10)];
    bgView.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    [self addSubview:bgView];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(15, 20, 5, 13)];
    leftView.backgroundColor = kMainColor;
    [self addSubview:leftView];
    
    UILabel *totalLable = [[UILabel alloc]initWithFrame:CGRectMake(leftView.ct_right+6, 20 - 1, 200, 16)];
    totalLable.text  = @"低量化记录";
    totalLable.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:totalLable];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame =CGRectMake(self.ct_width-60-15, leftView.ct_top - 3, 60, 20);
    
    [btn setTitle:@"查看详情" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:kMainColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(lookDetail) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftView.ct_left, leftView.ct_bottom+12, self.ct_width-leftView.ct_left, 1)];
    lineView.backgroundColor = KBCOLOR_WITH_HEX(0xe2e1e2);
    [self addSubview:lineView];
    
    self.fLab = [[UILabel alloc]initWithFrame:CGRectMake(20, leftView.ct_bottom+25, self.ct_width-40, 20)];
    self.fLab.font = [UIFont systemFontOfSize:14];
    self.fLab.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:self.fLab];
    
    self.sLab = [[UILabel alloc]initWithFrame:CGRectMake(20, self.fLab.ct_bottom+3, self.ct_width-40, 20)];
    self.sLab.font = [UIFont systemFontOfSize:13];
    self.sLab.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:self.sLab];
    
    self.tLab = [[UILabel alloc]initWithFrame:CGRectMake(20, self.sLab.ct_bottom+3, self.ct_width-40, 20)];
    self.tLab.font = [UIFont systemFontOfSize:13];
    self.tLab.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:self.tLab];
    
    
}

- (void)lookDetail
{
    if (self.clickDetailBlock) {
        self.clickDetailBlock();
    }
}

- (void)setModel:(KBMidLQModel *)model
{

    self.fLab.attributedText = [self getAttributedString:@"近半年来的总低量化次数（" seconSting:model.zongshu];
    self.sLab.attributedText = [self getAttributedString:@"每周低量化：(" seconSting:model.zhoushu];
    self.tLab.attributedText = [self getAttributedString:@"每月低量化：(" seconSting:model.yueshu];
}

- (NSMutableAttributedString *)getAttributedString:(NSString *)firstString seconSting:(NSString *)secondString
{
     NSMutableAttributedString  *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@）",firstString,secondString]];
    
    NSRange firstrange = NSMakeRange(0, firstString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value: KBCOLOR_WITH_HEX(0x666666) range:firstrange];
    NSRange srange = NSMakeRange(firstString.length, secondString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:srange];
    
    return attributedString;
}


@end
