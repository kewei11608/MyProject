//
//  KBRBAgentView.m
//  KuBoss
//
//  Created by yuyang on 2018/5/13.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRBAgentView.h"
#import "UIImageView+WebCache.h"
@interface KBRBAgentView ()
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel  *fLab;
@property (nonatomic,strong) UILabel  *sLab;
@property (nonatomic,copy) NSString  *iphone;

@end
@implementation KBRBAgentView

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
    self.fLab.text = @"孙佳新 ";
    self.fLab.textColor = KBCOLOR_WITH_HEX(0x333333);
    [self addSubview:self.fLab];
    
    self.sLab = [[UILabel alloc]init];
    self.sLab.font = [UIFont systemFontOfSize:14];
    self.sLab.text = @"朝阳大悦城一店";
    self.sLab.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:self.sLab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(self.ct_width-22-24, 0, 22, 22);
    [btn setImage:[UIImage imageNamed:@"iphone"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tell) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    btn.ct_centerY = self.ct_centerY;
    
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
- (void)setName:(NSString *)name shop:(NSString *)shop iphone:(NSString *)phone avatarUrl:(NSString *)avatarUrl
{
    self.fLab.text = name;
    self.sLab.text = shop;
    self.iphone = phone;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
}

- (void)layoutSubviews
{
    self.imgView.frame = CGRectMake(15, 20, 50, 50);
    self.fLab.frame = CGRectMake(self.imgView.ct_right+8, 25, self.ct_width-(self.imgView.ct_right+30), 15);
    self.sLab.frame = CGRectMake(self.imgView.ct_right+8,  self.fLab.ct_bottom+ 5, self.ct_width-(self.imgView.ct_right+30), 15);

    
}

@end
