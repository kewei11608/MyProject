//
//  KBLQDetailCell.m
//  KuBoss
//
//  Created by yuyang on 2018/4/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQDetailCell.h"
#import "UIView+Shadow.h"

@interface KBLQDetailCell ()
@property (nonatomic,strong)UIView *shadowView;
@property (nonatomic,strong) UILabel  *fLab;
@property (nonatomic,strong) UILabel  *sLab;
@property (nonatomic,strong) UILabel  *tLab;

@property (nonatomic,strong) UILabel  *aLab;

@end

@implementation KBLQDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    self.shadowView  = [[UIView alloc]init];
    self.shadowView.backgroundColor = [UIColor whiteColor];
    [self.shadowView shadow];
    [self addSubview:self.shadowView];
    self.fLab = [[UILabel alloc]init];
    self.fLab.font = [UIFont systemFontOfSize:13];
    self.fLab.text = @"";
    self.fLab.textColor = KBCOLOR_WITH_HEX(0x999999);
    [self.shadowView addSubview:self.fLab];
    
    self.sLab = [[UILabel alloc]init];
    self.sLab.font = [UIFont systemFontOfSize:13];
    self.sLab.text = @"";
    self.sLab.textColor = KBCOLOR_WITH_HEX(0x999999);
    [self.shadowView addSubview:self.sLab];
    
    self.tLab = [[UILabel alloc]init];
    self.tLab.font = [UIFont systemFontOfSize:13];
    self.tLab.text = @"";
    self.tLab.textColor = KBCOLOR_WITH_HEX(0x999999);
    [self.shadowView addSubview:self.tLab];
    
    self.aLab = [[UILabel alloc]init];
    self.aLab.font = [UIFont systemFontOfSize:13];
    self.aLab.text = @"";
    self.aLab.textColor = KBCOLOR_WITH_HEX(0x999999);
    self.aLab.textAlignment = NSTextAlignmentRight;
    [self.shadowView addSubview:self.aLab];
    
    
}

- (void)layoutSubviews
{
    self.shadowView.frame = CGRectMake(15, 15, self.ct_width-30, 80);
    self.fLab.frame =CGRectMake(5,5,self.shadowView.ct_width-10,15);
    self.sLab.frame =CGRectMake(5,self.fLab.ct_bottom+12,self.shadowView.ct_width-10,15);
    self.tLab.frame = CGRectMake(5,self.sLab.ct_bottom+10,self.shadowView.ct_width-10,15);
    
    self.aLab.frame = CGRectMake(self.shadowView.ct_width -125, 5, 110, 15);
}


- (void)setModel:(KBLQDetailWeek *)model isWeek:(BOOL)isWeek
{
    self.fLab.text = model.timeslot;
    if (isWeek) {
        self.sLab.text = [NSString stringWithFormat:@"每周低量化标准：%ld房 %ld客 %ld带 %ld勘",model.availabilitynumber,model.touristnumber,model.takealookinumber,model.realservicenumber];
    } else {
        self.sLab.text = [NSString stringWithFormat:@"每月低量化标准：%ld房 %ld客 %ld带 %ld勘",model.availabilitynumber,model.touristnumber,model.takealookinumber,model.realservicenumber];
    }
    
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if (isWeek) {
        [array addObject:[KBAttributedStringModel initWithText:@"经纪人本周量化：" font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
    } else {
        [array addObject:[KBAttributedStringModel initWithText:@"经纪人本月量化：" font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
    }
    
    if (model.availabilityrnumber < model.availabilitynumber) {
        [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",model.availabilityrnumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0xF22424)]];
    }
    else
    {
         [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",model.availabilityrnumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
    }
    
     [array addObject:[KBAttributedStringModel initWithText:@"房 "font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
    
    if (model.touristrnumber < model.touristnumber) {
        [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",model.touristrnumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0xF22424)]];
    }
    else
    {
        [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",model.touristrnumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
    }
    
    [array addObject:[KBAttributedStringModel initWithText:@"客 "font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
    
    if (model.takealookirnumber < model.takealookinumber) {
        [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",model.takealookirnumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0xF22424)]];
    }
    else
    {
        [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",model.takealookirnumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
    }
    
    [array addObject:[KBAttributedStringModel initWithText:@"带  "font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
    
    if (model.realservicernumber < model.realservicenumber) {
        [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",model.realservicernumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0xF22424)]];
    }
    else
    {
        [array addObject:[KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%ld",model.realservicernumber]font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
    }
    
    [array addObject:[KBAttributedStringModel initWithText:@"勘  "font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x999999)]];
    
    self.tLab.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array];
    
//    self.tLab.text = [NSString stringWithFormat:@"经纪人本周量化：%ld房 %ld客 %ld带 %ld勘",model.availabilityrnumber,model.touristrnumber,model.        takealookirnumber,model.realservicernumber];
    NSString *str ;
    if (model.recordstatus == 0) {
         str = @"未提醒";
         self.aLab.textColor = KBCOLOR_WITH_HEX(0xF22424);
        
        
    }
    else if (model.recordstatus == 1) {
         str = @"经纪人已提醒";
         self.aLab.textColor = KBCOLOR_WITH_HEX(0x666666);
    }
    else if (model.recordstatus == 2) {
        str = @"经纪人已读";
        self.aLab.textColor = kMainColor;
    }
    
    NSMutableAttributedString  *m_attributedString = [[NSMutableAttributedString alloc]initWithString:str];

    NSTextAttachment*textAttachment = [[NSTextAttachment alloc] init];
        //给附件添加图片
    textAttachment.image= [UIImage imageNamed:@"right_arrow"];
        //调整一下图片的位置,如果你的图片偏上或者偏下,调整一下bounds的y值即可
    textAttachment.bounds=CGRectMake(2, -3,8, 15);
        //把附件转换成可变字符串,用于替换掉源字符串中的表情文字
    NSAttributedString*imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [m_attributedString appendAttributedString:imageStr];
    self.aLab.attributedText = m_attributedString;

}
@end
