//
//  KBUpdateFootView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBUpdateFootView.h"

@interface KBUpdateFootView ()
@property (nonatomic,strong)UILabel *lable;

@end
@implementation KBUpdateFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor = KBCOLOR_WITH_HEX(0xF2F2F2);
    [self setup];
    return self;
}

- (void)setup
{
    self.lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, 40)];
    self.lable.text = @"";
    self.lable.textColor = KBCOLOR_WITH_HEX(0x999999);
    self.lable.textAlignment = NSTextAlignmentCenter;
    self.lable.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.lable];
    
}

- (void)setTitle:(NSString *)title
{
    self.lable.text = [NSString stringWithFormat:@"以上数据更新时间：%@",title];  
}

@end
