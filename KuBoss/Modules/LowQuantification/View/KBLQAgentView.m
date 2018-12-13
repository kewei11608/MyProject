//
//  KBLQAgentView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQAgentView.h"
#import "UIImageView+WebCache.h"
@interface KBLQAgentView ()
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel  *fLab;
//@property (nonatomic,strong) UILabel  *sLab;
//@property (nonatomic,strong) UILabel  *tLab;
@property (nonatomic,copy) NSString  *iphone;
@end
@implementation KBLQAgentView

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
    self.imgView = [[UIImageView alloc]init];
    self.imgView.layer.cornerRadius = 25;
    self.imgView.layer.masksToBounds = YES;
    [self addSubview:self.imgView];
    
    self.fLab = [[UILabel alloc]init];
    self.fLab.font = [UIFont systemFontOfSize:15];
    self.fLab.text = @"";
    self.fLab.textColor = [UIColor blackColor];
    [self addSubview:self.fLab];
    
    self.sLab = [[UILabel alloc]init];
    self.sLab.font = [UIFont systemFontOfSize:13];
    self.sLab.text = @"";
    self.sLab.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:self.sLab];
    
    self.tLab = [[UILabel alloc]init];
    self.tLab.font = [UIFont systemFontOfSize:13];
    self.tLab.text = @"";
    self.tLab.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:self.tLab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(self.ct_width-22-24, 44, 22, 22);
    [btn setImage:[UIImage imageNamed:@"iphone"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tell) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)tell
{
    if (self.iphone.length >0)
    {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.iphone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self addSubview:callWebview];
    }
    else
    {
        [KBAlter show:@"暂无电话，请稍后再试" superView:[UIApplication sharedApplication].keyWindow];
    }
    if (self.tellBlock) {
        self.tellBlock();
    }
}

- (void)layoutSubviews
{
    self.imgView.frame = CGRectMake(15, 20, 50, 50);
    self.fLab.frame = CGRectMake(self.imgView.ct_right+8, 15, self.ct_width-(self.imgView.ct_right+30), 15);
    self.sLab.frame = CGRectMake(self.imgView.ct_right+8,  self.fLab.ct_bottom+ 10, self.ct_width-(self.imgView.ct_right+30), 15);
    self.tLab.frame = CGRectMake(self.imgView.ct_right+8,  self.sLab.ct_bottom+ 10, self.ct_width-(self.imgView.ct_right+30), 15);
    
}

- (void)setModel:(KBLQDetailModel *)model
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.data.agenthead] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
    self.iphone = model.data.agentphone;
    
//    self.fLab.attributedText = [self getAttributedString:[NSString stringWithFormat:@"%@ 近半年总低量化次数:",model.data.agentname] seconSting:[NSString stringWithFormat:@"%ld",model.data.sflx]];
    
    self.fLab.text = [NSString stringWithFormat:@"%@ （近半年总低量化次数：%ld）",model.data.agentname,model.data.zongshu];
    //
    self.sLab.attributedText = [self getAttributedString:@"每周低量化: " seconSting:[NSString stringWithFormat:@"%ld",model.data.zhoushu]]  ;
    if (model.data.sflx <= 1) {
          self.tLab.attributedText = [self getAttributedString:@"每月低量化: " seconSting:[NSString stringWithFormat:@"%ld  ",model.data.yueshu]]  ;
    }
    else{
        self.tLab.attributedText = [self getAttributedString:@"每月低量化: " seconSting:[NSString stringWithFormat:@"%ld  已连续%ld月低量化",model.data.yueshu,model.data.sflx]]  ;
    }
  
}


- (NSMutableAttributedString *)getAttributedString:(NSString *)firstString seconSting:(NSString *)secondString
{
    NSMutableAttributedString  *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",firstString,secondString]];
    
    NSRange firstrange = NSMakeRange(0, firstString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value: KBCOLOR_WITH_HEX(0x666666) range:firstrange];
    NSRange srange = NSMakeRange(firstString.length, secondString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:srange];
    
    return attributedString;
}

- (void)setItemModel:(KBLQItemModel *)model
{
    KBLQItemSub  *submodel = model.data.grdlhsj.firstObject;
    if (submodel) {
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:submodel.agenthead] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
        self.fLab.text = [NSString stringWithFormat:@"%@ （近半年总低量化次数：%ld）",submodel.agentname,model.data.bjdlhzsl];
//    self.sLab.text = [NSString stringWithFormat:@"每周低量化：%ld",model.data.zhoushu];
//    self.tLab.text = [NSString stringWithFormat:@"每月低量化：%ld",model.data.yueshu];
        
//        self.fLab.attributedText = [self getAttributedString:[NSString stringWithFormat:@"%@ 近半年总低量化次数:",model.data.agentname] seconSting:[NSString stringWithFormat:@"%ld",model.data.sflx]];
//        //
//        self.sLab.attributedText = [self getAttributedString:@"每周低量化:" seconSting:[NSString stringWithFormat:@"%ld",model.data.zhoushu]]  ;
//        self.tLab.attributedText = [self getAttributedString:@"每月低量化:" seconSting:[NSString stringWithFormat:@"%ld  已连续%ld月低量化",model.data.yueshu,model.data.sflx]]  ;
    self.iphone = submodel.agentphone;
    }
}




@end
