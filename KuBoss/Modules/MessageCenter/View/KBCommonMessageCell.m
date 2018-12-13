//
//  KBCommonMessageCell.m
//  KuBoss
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBCommonMessageCell.h"
@interface KBCommonMessageCell ()
@property (nonatomic,strong) UILabel *timeLable;
@property (nonatomic,strong) UIView *shadowView;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *fLable;
@property (nonatomic,strong) UILabel *sLable;

@property (nonatomic,strong) UILabel *dLable;


@property (nonatomic,assign) BOOL  isBuiness;

@end
@implementation KBCommonMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    self.timeLable  = [[UILabel alloc]init];
    self.timeLable.text  =@"2017.09.24 13:14";
    self.timeLable.font  = [UIFont systemFontOfSize:12];
    self.timeLable.textColor = KBCOLOR_WITH_HEX(0x999999);
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.timeLable];
    
    self.shadowView = [[UIView alloc]init];
    self.shadowView.backgroundColor = [UIColor whiteColor];
    [self.shadowView shadow];
    [self addSubview:self.shadowView];
    
    self.titleLable  = [[UILabel alloc]init];
    self.titleLable.text  =@"";
    self.titleLable.font  = [UIFont systemFontOfSize:15];
    self.titleLable.textColor = KBCOLOR_WITH_HEX(0x333333);
    [self.shadowView addSubview:self.titleLable];
    
    self.dLable  = [[UILabel alloc]init];
    self.dLable.attributedText = [self getArrow:@"查看详情"];
    self.dLable.font  = [UIFont systemFontOfSize:12];
    self.dLable.textColor = kMainColor;
    self.dLable.textAlignment = NSTextAlignmentRight;
    [self.shadowView addSubview:self.dLable];
    
    
    self.fLable  = [[UILabel alloc]init];
    self.fLable.text  =@"";
    self.fLable.font  = [UIFont systemFontOfSize:12];
    self.fLable.textColor = KBCOLOR_WITH_HEX(0x666666);
    self.fLable.numberOfLines = 2;
    [self.shadowView addSubview:self.fLable];
    
    self.sLable  = [[UILabel alloc]init];
    self.sLable.text  =@"";
    self.sLable.font  = [UIFont systemFontOfSize:12];
    self.sLable.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self.shadowView addSubview:self.sLable];
    
    
}

- (void)layoutSubviews
{
    self.timeLable.frame  = CGRectMake(0, 0, self.ct_width, 36);
    self.shadowView.frame = CGRectMake(15, self.timeLable.ct_bottom, self.ct_width-30, 82);
    self.titleLable.frame = CGRectMake(14, 9, self.shadowView.ct_width-80, 16);
    self.fLable.frame = CGRectMake(14, self.timeLable.ct_bottom+5, self.shadowView.ct_width-30, 30);
    self.sLable.frame = CGRectMake(14, self.fLable.ct_bottom+5, self.shadowView.ct_width-30, 13);
    self.dLable.frame = CGRectMake(self.shadowView.ct_width-110, 15, 100, 13);
    if (self.isBuiness) {
          self.titleLable.frame = CGRectMake(14, 15, self.shadowView.ct_width-80, 16);
    }
    
    
}

- (void)setAnnouncementItem:(KBAnnouncementItem *)item
{
    self.timeLable.text = item.publishTime;
    self.titleLable.text = item.announcementTitle;
    self.fLable.text =  item.announcementContent;
    
}

- (void)setModulesItem:(KBMessageMoudulesItem *)item
{
    self.isBuiness = YES;
    self.timeLable.text = item.createtime;
    if (self.timeLable.text.length > 16) {
        self.timeLable.text = [self.timeLable.text substringToIndex:16];
    }
    self.titleLable.text = item.title;
    self.fLable.text = item.content;
  
}

@end
