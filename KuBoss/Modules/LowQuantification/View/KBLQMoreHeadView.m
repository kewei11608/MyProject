//
//  KBLQMoreHeadView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQMoreHeadView.h"

@interface KBLQMoreHeadView ()
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIView *lineView;


@end
@implementation KBLQMoreHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleLable];
    [self  setup];
    return self;
}

- (void)setup
{
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, self.ct_width-30, 15)];
    self.titleLable.font = [UIFont systemFontOfSize:14];
    self.titleLable.textColor = KBCOLOR_WITH_HEX(0x333333);
    self.titleLable.text  = @"";
    [self addSubview:self.titleLable];
    
    self.img = [[UIImageView alloc]init];
    self.img.frame = CGRectMake(self.ct_width-35, (self.ct_height-20)/2, 10, 18);
    [self addSubview:self.img];
    self.img.image = [UIImage imageNamed:@"right_arrow"];
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(15, self.ct_height-1, self.ct_width, 1)];
    self.lineView.backgroundColor =  KBCOLOR_WITH_HEX(0xE2E2E2);
    [self addSubview:self.lineView];
}

- (void)setTitle:(NSMutableAttributedString *)title
{
    self.titleLable.attributedText = title;
}
@end
