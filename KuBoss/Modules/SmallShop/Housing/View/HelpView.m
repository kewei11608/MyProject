//
//  HelpView.m
//  KuBoss
//
//  Created by lidan on 2018/11/23.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import "HelpView.h"
#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif
@interface HelpView ()<UIGestureRecognizerDelegate>
{
    UIView        *_whiteview;
}


@property (nonatomic, copy) void(^action)(NSInteger index);

@end


@implementation HelpView
- (instancetype)initWithdata:(NSDictionary *)dic action:(void(^)(NSInteger index))action{
    
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.alpha = 0;
        self.action = action;
        _whiteview=[[UIView alloc]initWithFrame:CGRectMake(25, 85, MSW-50, 400)];
        _whiteview.backgroundColor=[UIColor whiteColor];
        [self addSubview:_whiteview];
        
        UILabel*  _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(25,20, _whiteview.width - 20, 35)];
        _titleLab.textColor = blackTextColor;
        _titleLab.font = [UIFont systemFontOfSize:24];
//        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text=@"帮助";
        [_whiteview addSubview:_titleLab];
   
        UILabel*lbline1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 69,_whiteview.width, 1)];
        lbline1.backgroundColor =LineColor;
        [_whiteview addSubview:lbline1];
        
        
        
        
        
        UILabel*  _desLab = [[UILabel alloc] initWithFrame:CGRectMake(10, lbline1.bottom+20, _whiteview.width - 20, 200)];
        _desLab.textColor = blackTextColor;
        _desLab.font = [UIFont systemFontOfSize:16];
        _desLab.numberOfLines=0;
        _desLab.text=@"微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，微店中的房源来源是哪里，";
        [_whiteview addSubview:_desLab];
        
        UILabel*lbline=[[UILabel alloc]initWithFrame:CGRectMake(0, _desLab.bottom+10, _whiteview.width, 1)];
        lbline.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_whiteview addSubview:lbline];
        
        UIButton *  _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.frame = CGRectMake(0,lbline.bottom, _whiteview.width, 40);
        //        _bottomBtn.backgroundColor = blackTextColor;
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_bottomBtn setTitleColor:blackTextColor forState:UIControlStateNormal];
        [_bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(clicksure) forControlEvents:UIControlEventTouchUpInside];
        [_whiteview addSubview:_bottomBtn];
        
        _whiteview.layer.masksToBounds = YES;
        _whiteview.layer.cornerRadius = 5;
        _whiteview.frame=CGRectMake(25, 85, MSW-50, _bottomBtn.bottom);
    }
    return self;
    
}

+ (void)showWithdata:(NSDictionary *)dic action:(void(^)(NSInteger index))action{
    
    HelpView *view = [[HelpView alloc] initWithdata:dic action:action];
    [view show];
    
}







-(void)clicksure{
    [self hide];
    
    if (_action) {
        _action(0);
    }
}


- (void)tap {
    [self hide];
}
#pragma mark - show or hide
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    // 向右下transform

    _whiteview.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        _whiteview.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}
- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        _whiteview.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        [_whiteview removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
