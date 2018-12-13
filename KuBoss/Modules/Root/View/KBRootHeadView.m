//
//  KBRootHeadView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRootHeadView.h"
#import "KBBannerView.h"
#import "KBHeader.h"
#import "KBRootItemView.h"
#import "KBRootFollowView.h"
#import "KBRootColumnView.h"
#import "KBRootOscillogramView.h"
#import "UIView+CustomCorners.h"

@interface KBRootHeadView ()

@property (nonatomic,strong) KBBannerView *bannerView;
@property (nonatomic,strong) KBRootItemView *rootItemView;
@property (nonatomic,strong) KBRootFollowView *rootFollowView;
@property (nonatomic,strong) KBRootColumnView *rootColumnView;
@property (nonatomic,strong) KBRootOscillogramView *rootOscillogramView;

@end
@implementation KBRootHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    [self setup];
    return self;
}

- (void)setupArray:(NSArray *)array
{
    [self.bannerView setupArray:array];
}

- (void)setFollowArray:(NSArray *)array
{
    [self.rootFollowView setFollowArray:array];
}
- (void)setNumber:(NSInteger) number
{
    [self.rootItemView setNumber:number];
}

- (void)setup
{
    [self addSubview:self.bannerView];
    [self addSubview:self.rootItemView];
    
    @KBWeakObj(self);
    self.rootItemView.clickTabBlock = ^(NSInteger tag) {
        @KBStrongObj(self);
        if (self.clickTabBlock) {
            self.clickTabBlock(tag);
        }
    };
    
    [self addSubview:self.rootFollowView];
    
    self.rootFollowView.clickBlock = ^{
         @KBStrongObj(self);
        if (self.clickFollowBlock) {
            self.clickFollowBlock();
        }
    };
    
    [self addSubview:self.rootColumnView];
    [self addSubview:self.rootOscillogramView];
    
    UIView *bottomView = [[UIView  alloc]initWithFrame:CGRectMake(0, self.rootOscillogramView.ct_bottom+10, self.ct_width, 46)];
//    [self addSubview:bottomView];
    
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(15, 16, 5, 13)];
    leftView.backgroundColor = kMainColor;
    [bottomView addSubview:leftView];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UILabel *followLable = [[UILabel alloc]initWithFrame:CGRectMake(leftView.ct_right+6, 15, 200, 16)];
    followLable.text  = @"战报推送";
    followLable.font = [UIFont boldSystemFontOfSize:15];
    [bottomView addSubview:followLable];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(15, self.ct_height-1, self.ct_width-15, 1)];
    line.backgroundColor = KBCOLOR_WITH_HEX(0xE2E2E2);
//    [self addSubview:line];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(bottomView.ct_width-45, 13, 30, 19);
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [moreBtn addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:moreBtn];
    
    
    
    UIButton *rankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rankBtn.frame = CGRectMake(bottomView.ct_width-90, 13, 30, 19);
    [rankBtn setTitle:@"排行" forState:UIControlStateNormal];
    [rankBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    rankBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [rankBtn addTarget:self action:@selector(rank) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:rankBtn];
}

- (KBBannerView *)bannerView
{
    if (!_bannerView) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, 160)];
        bgView.backgroundColor = [UIColor  whiteColor];
        [self addSubview:bgView];
        _bannerView =  [[KBBannerView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, 160)];
//        _bannerView.layer.masksToBounds = YES;
//        _bannerView.layer.cornerRadius = 5;
//        UIView *leftVew = [[UIView alloc]initWithFrame:CGRectMake(0, 22, 8, 160-44)];
//        leftVew.backgroundColor = kMainColor;
//        [self addSubview:leftVew];
//
//        UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(self.ct_width-8, 22, 8, 160-44)];
//        rightView.backgroundColor = kMainColor;
//        [self addSubview:rightView];
        
//        [leftVew bezierPathWithRoundedVieCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
//        [rightView bezierPathWithRoundedVieCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
        

    }
    return _bannerView;
}

- (KBRootItemView *)rootItemView
{
    if (!_rootItemView) {
        _rootItemView = [[KBRootItemView alloc]initWithFrame:CGRectMake(0, self.bannerView.ct_bottom, self.ct_width, 115)];
    }
    return  _rootItemView;
}

- (KBRootFollowView *)rootFollowView
{
    if (!_rootFollowView) {
        _rootFollowView = [[KBRootFollowView alloc]initWithFrame:CGRectMake(0, self.rootItemView.ct_bottom+10, self.ct_width, 170)];
    }
    return  _rootFollowView;
}

- (KBRootColumnView *)rootColumnView
{
    if (!_rootColumnView) {
        _rootColumnView = [[KBRootColumnView alloc]initWithFrame:CGRectMake(0, self.rootFollowView.ct_bottom+10, self.ct_width, 320)];
    }
    return  _rootColumnView;
}

- (KBRootOscillogramView *)rootOscillogramView
{
    if (!_rootOscillogramView) {
        _rootOscillogramView = [[KBRootOscillogramView alloc]initWithFrame:CGRectMake(0, self.rootColumnView.ct_bottom+10, self.ct_width, 273)];
    }
    return  _rootOscillogramView;
}


- (void)more
{
    if (self.moreBlock) {
        self.moreBlock();
    }
}

- (void)rank
{
    if (self.rankBlock) {
        self.rankBlock();
    }
}

- (void)updateView
{
    [self.rootColumnView updateView];
    [self.rootOscillogramView updateView];
}


@end
