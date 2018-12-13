//
//  KBStationMessageCell.m
//  KuBoss
//
//  Created by yuyang on 2018/4/8.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBStationMessageCell.h"
#import "UIImageView+WebCache.h"
@interface KBStationMessageCell ()
@property (nonatomic,strong) UIImageView *iconImg;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *contentLable;
@property (nonatomic,strong) UILabel *timeLable;
@property (nonatomic,strong) UILabel *lookLable;
@property (nonatomic,strong) UIView *lineView;


@end
@implementation KBStationMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    self.iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 100, 75)];
    self.iconImg.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:self.iconImg];
    
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImg.ct_right+10, 15, self.ct_width-(self.iconImg.ct_right+55), 16)];
    self.titleLable.text = @"";
    self.titleLable.font = [UIFont systemFontOfSize:15];
    self.titleLable.textColor = KBCOLOR_WITH_HEX(0x333333);
    [self addSubview:self.titleLable];
    
    self.contentLable = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImg.ct_right+10, self.titleLable.ct_bottom+3, self.ct_width-(self.iconImg.ct_right+55), 26)];
    self.contentLable.text = @"";
    self.contentLable.numberOfLines = 2;
    self.contentLable.font = [UIFont systemFontOfSize:12];
    self.contentLable.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:self.contentLable];
    
    
    self.timeLable = [[UILabel alloc]initWithFrame:CGRectMake(self.iconImg.ct_right+10, self.contentLable.ct_bottom+3, self.ct_width-(self.contentLable.ct_right+55), 16)];
    self.timeLable.text = @"";
    self.timeLable.font = [UIFont systemFontOfSize:12];
    self.timeLable.textColor = KBCOLOR_WITH_HEX(0x999999);
    [self addSubview:self.timeLable];
    
    self.lookLable = [[UILabel alloc]init];
    self.lookLable.text = @"查看详情";
    self.lookLable.font = [UIFont systemFontOfSize:12];
    self.lookLable.textAlignment = NSTextAlignmentRight;
    self.lookLable.textColor = kMainColor;
    [self addSubview:self.lookLable];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = KBCOLOR_WITH_HEX(0xE2E2E2);
    [self addSubview:self.lineView];
    
    
}

- (void)layoutSubviews
{
    self.iconImg.frame=CGRectMake(15, 15, 100, 75);
    self.titleLable.frame=CGRectMake(self.iconImg.ct_right+10, 15, self.ct_width-(self.iconImg.ct_right+55), 16);
    self.contentLable.frame=CGRectMake(self.iconImg.ct_right+10, self.titleLable.ct_bottom+3, self.ct_width-(self.iconImg.ct_right+55), 30);
    self.timeLable.frame=CGRectMake(self.iconImg.ct_right+10, self.contentLable.ct_bottom+3, self.ct_width-(self.iconImg.ct_right+55), 16);
    
    self.lookLable.frame = CGRectMake(self.ct_width-115,self.ct_height-15-13, 100, 13);
    self.lineView.frame = CGRectMake(15, self.ct_height-1, self.ct_width-15, 1);
}

- (void)setModel:(KBStationItem *)item
{
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:item.articehdUrl] placeholderImage:[UIImage imageNamed:@"banner_default"]];
    self.titleLable.text = item.stationTitle;
    self.contentLable.text = item.stationDescription;
    self.timeLable.text = item.cmReleaseDate;
    
    
}

@end
