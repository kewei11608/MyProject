//
//  KBResourceManagerViewCell.m
//  KuBoss
//
//  Created by yuyang on 2018/4/8.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBResourceManagerViewCell.h"
@interface KBResourceManagerViewCell ()




@end
@implementation KBResourceManagerViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self)  return nil;
    [self setup];
    return self;
}

- (void)setup
{
    self.leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 18, 8, 8)];
    self.leftImg.backgroundColor = KBCOLOR_WITH_HEX(0xD8D8D8);
    [self addSubview:self.leftImg];
    
    self.lable = [[UILabel alloc]initWithFrame:CGRectMake(self.leftImg.ct_right+7, 13, 300, 14)];
    self.lable.text = @"库存房源 60 人均21";
    self.lable.textColor = KBCOLOR_WITH_HEX(0x666666);
    self.lable.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.lable];
    
    
    self.toalView = [[UIView alloc]initWithFrame:CGRectMake(15, self.leftImg.ct_bottom+12, self.ct_width-30, 10)];
    self.toalView.backgroundColor = KBCOLOR_WITH_HEX(0xD8D8D8);
    self.toalView.layer.masksToBounds = YES;
    self.toalView.layer.cornerRadius =  5;
    [self addSubview:self.toalView];
    
    self.currentView = [[UIView alloc]initWithFrame:CGRectMake(15, self.leftImg.ct_bottom+12, (self.ct_width-30)*0.4, 10)];
    self.currentView.backgroundColor = KBCOLOR_WITH_HEX(0x6B7BFF);
    self.currentView.layer.masksToBounds = YES;
    self.currentView.layer.cornerRadius =  5;
    [self addSubview:self.currentView];
    
    self.bottopmLeftImg = [[UIView  alloc]initWithFrame:CGRectMake(15, self.currentView.ct_bottom+20, 8, 8)];
    self.bottopmLeftImg.backgroundColor = KBCOLOR_WITH_HEX(0x6B7BFF);
    [self addSubview:self.bottopmLeftImg];
    
    self.bottomTitle = [[UILabel alloc]init];
    self.bottomTitle.text = @"近30日内有带看45%";
    self.bottomTitle.font = [UIFont systemFontOfSize:13];
    self.bottomTitle.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:self.bottomTitle];
    
    
    self.bottopmLeftImg1 = [[UIView  alloc]initWithFrame:CGRectMake(15, self.currentView.ct_bottom+20, 8, 8)];
    self.bottopmLeftImg1.backgroundColor =[UIColor clearColor];
    [self addSubview:self.bottopmLeftImg1];
    
    self.bottomTitle1 = [[UILabel alloc]init];
    self.bottomTitle1.text = @"";
    self.bottomTitle1.font = [UIFont systemFontOfSize:13];
    self.bottomTitle1.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:self.bottomTitle1];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 54, self.ct_width-15, 1)];
    [self addSubview: self.lineView];
     self.lineView.backgroundColor = KBCOLOR_WITH_HEX(0xe2e2e2);
    
}

- (void)layoutSubviews
{
    self.toalView.frame =CGRectMake(15, 38, self.ct_width-30, 10);
    //self.currentView.frame = CGRectMake(15, 38, (self.ct_width-30)*0.4, 10);
    self.bottopmLeftImg.frame = CGRectMake(15, self.currentView.ct_bottom+20, 8, 8);
    self.bottomTitle.frame = CGRectMake(self.bottopmLeftImg.ct_right+7, self.currentView.ct_bottom+16, 200, 14);
    
    self.bottopmLeftImg1.frame = CGRectMake(15, self.bottopmLeftImg.ct_bottom+15, 8, 8);
    self.bottomTitle1.frame = CGRectMake(self.bottopmLeftImg.ct_right+7, self.bottomTitle.ct_bottom+10, 200, 14);
    self.lineView.frame = CGRectMake(15, self.ct_height-1, self.ct_width-15, 1);
}

@end
