//
//  KBTitleView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/11.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQTitleView.h"
#import "KBLQCell.h"

@interface KBLQTitleView ()
@property (nonatomic,strong) UILabel *lable;
@end
@implementation KBLQTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    self.lable = [[UILabel alloc]initWithFrame:CGRectMake(15, 11, self.ct_width-30, 15)];
    self.lable.font = [UIFont systemFontOfSize:14];
    self.lable.textColor = KBCOLOR_WITH_HEX(0x333333);
    self.lable.text = @"";
    [self addSubview:self.lable];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)click
{
  
}

@end
