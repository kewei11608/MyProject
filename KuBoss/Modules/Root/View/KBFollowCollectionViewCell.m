//
//  KBFollowCollectionViewCell.m
//  KuBoss
//
//  Created by yuyang on 2018/4/4.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBFollowCollectionViewCell.h"
@interface KBFollowCollectionViewCell ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *subTitleLable;

@end
@implementation KBFollowCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.ct_width, self.ct_height)];
    self.imageView.image = [UIImage imageNamed:@"Rectangle"];
    [self addSubview:self.imageView];
    
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 18, self.ct_width, 21)];
    self.titleLable.text = @"355个";
    self.titleLable.font = [UIFont boldSystemFontOfSize:20];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.textColor = [UIColor whiteColor];
    [self  addSubview:self.titleLable];
    
    self.subTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(15, self.titleLable.ct_bottom+10, self.ct_width-26, 30)];
    self.subTitleLable.numberOfLines = 2;
    self.subTitleLable.text = @"近一月新增二手房房源";
    self.subTitleLable.font = [UIFont systemFontOfSize:12];
    self.subTitleLable.textAlignment = NSTextAlignmentLeft;
    self.subTitleLable.textColor = [UIColor whiteColor];
    [self  addSubview:self.subTitleLable];
    NSString *str = @"本月新增租赁";
    CGFloat width = [str boundingRectWithSize:CGSizeMake(200, 30) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size.width + 1;
    self.subTitleLable.lineBreakMode = NSLineBreakByCharWrapping;
    [self.subTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLable.mas_bottom).offset(10);
        make.centerX.equalTo(self);
        make.width.equalTo(@(width));
    }];
    
}

- (void)setIsFollowed:(BOOL)isFollowed
{
    _isFollowed = isFollowed;
    if (isFollowed)
    {
        self.imageView.image = [UIImage imageNamed:@"Rectangle"];
        self.subTitleLable.textColor = [UIColor whiteColor];
        self.titleLable.textColor = [UIColor whiteColor];
    }
    else
    {
        self.imageView.image = [UIImage imageNamed:@"RectangleWhite"];
        self.titleLable.textColor = [UIColor blackColor];
        self.subTitleLable.textColor = [UIColor blackColor];
    }
}

- (void)setModel:(KBBottomIndicatorConcernModel *)model
{
    self.titleLable.text = [NSString stringWithFormat:@"%@%@", model.targetdata, model.targetnameunit];
    self.subTitleLable.text = model.targetname;
}

- (void)home
{
    self.imageView.image = [UIImage imageNamed:@"homeFollow"];
    self.titleLable.textColor = kMainColor;
    self.subTitleLable.textColor = kMainColor;
}

@end
