//
//  HouseDetailView.m
//  KuBoss
//
//  Created by yuyang on 2018/6/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "HouseDetailView.h"
#import "UIView+Shadow.h"

@implementation HouseDetailView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.clickView shadow];
    self.avatarImg.layer.cornerRadius = 25;
    self.avatarImg.layer.masksToBounds = YES;
    
    [self addSubview:self.doneView];
    self.doneView.hidden = YES;
    [self.doneView setAutoLayoutLeftToViewLeft:self  constant:0];
    [self.doneView setAutoLayoutRightToViewRight:self  constant:0];
    [self.doneView setAutoLayoutTopToViewBottom:self.explainLable constant:0];
    [self.doneView setAutoLayoutBottomToViewBottom:self constant:0];
    self.refuseBtn.backgroundColor = KBCOLOR_WITH_HEX(0xEFEFEF);
    self.agreeBtn.backgroundColor = kMainColor;
    
    self.testLable.attributedText = [self getArrow:@"查看详情"];
    
}
- (IBAction)tel:(id)sender {
    if (self.phone.length >0)
    {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self addSubview:callWebview];
    }
    else {
        [KBAlter show:@"暂无电话，请稍后再试" superView:[UIApplication sharedApplication].keyWindow];
    }
}

- (IBAction)clickBgView:(id)sender {
    if (self.roomDetailBlock) {
        self.roomDetailBlock();
    }
}

- (IBAction)refuseAction:(id)sender {
    if (self.refuseBlock) {
        self.refuseBlock();
    }
}

- (IBAction)agreeAction:(id)sender {
    if (self.agreeBlock) {
        self.agreeBlock();
    }
}

- (HouseDoneView *)doneView {
    if (!_doneView) {
        _doneView = [HouseDoneView loadViewFrom:@"HouseDoneView"];
    }
    return _doneView;
}

@end
