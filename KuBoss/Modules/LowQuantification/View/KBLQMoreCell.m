//
//  KBLQMoreCell.m
//  KuBoss
//
//  Created by yuyang on 2018/4/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLQMoreCell.h"
#import "UIImageView+WebCache.h"
@interface KBLQMoreCell ()
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel  *fLab;
@property (nonatomic,strong) UILabel  *sLab;
@property (nonatomic,strong) UILabel  *tLab;
@property (nonatomic,strong) UIView  *lineView;

@end
@implementation KBLQMoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    self.backgroundColor =  KBCOLOR_WITH_HEX(0xFBFBFB);
    [self setup];
    return self;
}

- (void)setup
{
    self.imgView = [[UIImageView alloc]init];
    self.imgView.layer.cornerRadius = 25;
    self.imgView.layer.masksToBounds = YES;
    [self addSubview:self.imgView];
    
    self.fLab = [[UILabel alloc]init];
    self.fLab.font = [UIFont systemFontOfSize:14];
    self.fLab.text = @"";
    self.fLab.textColor = KBCOLOR_WITH_HEX(0x333333);
    [self addSubview:self.fLab];
    
    self.sLab = [[UILabel alloc]init];
    self.sLab.font = [UIFont systemFontOfSize:13];
    self.sLab.text = @"";
    self.sLab.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:self.sLab];
    
    self.tLab = [[UILabel alloc]init];
    self.tLab.font = [UIFont systemFontOfSize:13];
    self.tLab.text = @"";
    self.tLab.textColor = KBCOLOR_WITH_HEX(0x666666);
    [self addSubview:self.tLab];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor =  KBCOLOR_WITH_HEX(0xE2E2E2);
    [self addSubview:self.lineView];
    
}

- (void)layoutSubviews
{
    self.imgView.frame = CGRectMake(15, 20, 50, 50);
    self.fLab.frame = CGRectMake(self.imgView.ct_right+8, 15, self.ct_width-(self.imgView.ct_right+30), 15);
    self.sLab.frame = CGRectMake(self.imgView.ct_right+8,  self.fLab.ct_bottom+ 10, self.ct_width-(self.imgView.ct_right+30), 15);
    self.tLab.frame = CGRectMake(self.imgView.ct_right+8,  self.sLab.ct_bottom+ 10, self.ct_width-(self.imgView.ct_right+30), 15);
    self.lineView.frame =CGRectMake(65, self.ct_height-1, self.ct_width-65, 1);
    
    
}

- (void)setModel:(KBLQRecordAgent *)recordAgent
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:recordAgent.jjtx] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
    self.fLab.attributedText = [self getAttributedString:[NSString stringWithFormat:@"%@ ",recordAgent.jjmc] seconSting:@"近半年总低量化次数:" threeString:[NSString stringWithFormat:@"%ld",recordAgent.sysl]];

     self.sLab.attributedText = [self getAttributedString:@"每周低量化:" seconSting:[NSString stringWithFormat:@"%ld",recordAgent.zsl]]  ;
    if (recordAgent.sflx == 0 || recordAgent.sflx == 1) {
         self.tLab.attributedText = [self getAttributedString:@"每月低量化:" seconSting:[NSString stringWithFormat:@"%ld  ",recordAgent.ysl]]  ;
    }else{
       self.tLab.attributedText = [self getAttributedString:@"每月低量化:" seconSting:[NSString stringWithFormat:@"%ld  已连续%ld月低量化",recordAgent.ysl,recordAgent.sflx]]  ;
    }
   
    
}

- (NSMutableAttributedString *)getAttributedString:(NSString *)firstString seconSting:(NSString *)secondString threeString:(NSString *)threeString
{
    NSMutableAttributedString  *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@%@",firstString,secondString,threeString]];
    
    NSRange firstrange = NSMakeRange(0, firstString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value: KBCOLOR_WITH_HEX(0x666666) range:firstrange];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:firstrange];
    NSRange strange  = NSMakeRange(firstString.length, secondString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:KBCOLOR_WITH_HEX(0x666666) range:strange];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:strange];
    
    NSRange trange = NSMakeRange(firstString.length+secondString.length, threeString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:trange];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:trange];
    return attributedString;
}

- (NSMutableAttributedString *)getAttributedString:(NSString *)firstString seconSting:(NSString *)secondString
{
    NSMutableAttributedString  *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",firstString,secondString]];
    
    NSRange firstrange = NSMakeRange(0, firstString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value: KBCOLOR_WITH_HEX(0x666666) range:firstrange];
    NSRange srange = NSMakeRange(firstString.length, secondString.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:srange];
    
    return attributedString;
}


@end
