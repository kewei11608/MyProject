//
//  KBMineHeadView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBMineHeadView.h"
#import "KBHeader.h"
#import <UIImageView+WebCache.h>

@interface KBMineHeadView ()
@property (nonatomic,strong) UIImageView *avatarImg;
@property (nonatomic,strong) UILabel *nameLable;

@end
@implementation KBMineHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, self.ct_height)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)KBCOLOR_WITH_HEX(0xA4B2FF).CGColor, (__bridge id)KBCOLOR_WITH_HEX(0x7A6EFF).CGColor];
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, self.ct_width, self.ct_height);
    [bgView.layer addSublayer:gradientLayer];
    [self addSubview:bgView];
    
    self.avatarImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 76, 76)];
    self.avatarImg.layer.cornerRadius = 38;
    self.avatarImg.layer.masksToBounds = YES;
    self.avatarImg.image = [UIImage imageNamed:@"defaultUserImg"];
    [self addSubview:self.avatarImg];
    self.avatarImg.center = CGPointMake((0.8*self.ct_width)/2, self.ct_height/2);
    
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.avatarImg.ct_bottom+15, 0.8*self.ct_width, 22)];
    self.nameLable.text  =  [KBUserInfoModel userName];
    self.nameLable.textColor = [UIColor whiteColor];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    self.nameLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.nameLable];
    
}

- (void)updateUserName
{
     self.nameLable.text  =  [KBUserInfoModel userName];
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:[KBUserInfoModel userhead]] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
}



@end
