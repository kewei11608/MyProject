//
//  KBLQSettingViewCell.m
//  KuBoss
//
//  Created by yuyang on 2018/6/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQSettingViewCell.h"
@interface KBLQSettingViewCell ()
@property (nonatomic,strong)UIView *bottomBackView;


@end
@implementation KBLQSettingViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return self;
    [self setup];
    return self;
}

- (void)setup
{
    self.bottomBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, 60)];
    self.bottomBackView.backgroundColor = [UIColor whiteColor];
    [self.bottomBackView shadow];
    [self addSubview:self.bottomBackView];
    
    self.bottomLeftLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 17, self.ct_width-30, 15)];
    self.bottomLeftLable.textColor = KBCOLOR_WITH_HEX(0x333333);
    self.bottomLeftLable.font = [UIFont systemFontOfSize:14];
    self.bottomLeftLable.text = @"自动提醒经纪人";
    [self.bottomBackView addSubview:self.bottomLeftLable];
    
    self.switchView = [[UISwitch alloc]initWithFrame:CGRectMake(self.bottomBackView.ct_width - 15 -40, 13.0f, 40, 22)];
    self.switchView.on = YES;//设置初始为ON的一边
    [self.switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    [self.bottomBackView addSubview: self.switchView];
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (self.enableBlock) {
        self.enableBlock(isButtonOn);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bottomBackView.frame = CGRectMake(0, 5, self.ct_width, 60);
    self.bottomLeftLable.frame = CGRectMake(15, 20, self.ct_width-30, 15);
    self.switchView.frame = CGRectMake(self.bottomBackView.ct_width - 15 -40, 13.0f, 40, 22);
}


@end
