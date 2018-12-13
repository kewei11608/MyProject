//
//  KBLQCell.m
//  KuBoss
//
//  Created by yuyang on 2018/4/11.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQCell.h"

@interface KBLQCell ()
@property (nonatomic,strong)UILabel *lable;

@end
@implementation KBLQCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    self.lable = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, self.ct_width-30, 15)];
    self.lable.text  = @"张小龙 1房 0客 1带 1勘";
    self.lable.textColor = KBCOLOR_WITH_HEX(0x333333);
    self.lable.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.lable];
}

- (void)layoutSubviews
{
    self.lable.frame  = CGRectMake(15, 12, self.ct_width-30, 15);
}


@end
