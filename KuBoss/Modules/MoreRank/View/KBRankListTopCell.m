//
//  KBRankListCell.m
//  KuBoss
//
//  Created by yuyang on 2018/4/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRankListTopCell.h"

@interface KBRankListTopCell ()
@property (nonatomic,strong)UIImageView *img;
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UILabel *subTitleLable;
@property (nonatomic,strong)UILabel *thirdTitleLable;

@property (nonatomic,strong)UILabel *imgLabel;

@end

@implementation KBRankListTopCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return self;
    [self setup];
    return self;
}
- (void)setup
{
    
    self.img = [[UIImageView alloc]initWithFrame:CGRectMake(12, 7, 27, 30)];
   // self.img.backgroundColor = [UIColor redColor];
    [self addSubview:self.img];
    
    self.imgLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 7, 27, 30)];
    self.imgLabel.textColor = [UIColor blackColor];
    self.imgLabel.font = [UIFont boldSystemFontOfSize:20];
    self.imgLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.imgLabel];
    
    self.titleLable = [[UILabel  alloc]init];
    self.titleLable.textColor = KBCOLOR_WITH_HEX(0x585858);
    self.titleLable.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLable];
    self.titleLable.text =@"朝阳大悦城二店";
    
    self.subTitleLable = [[UILabel  alloc]init];
    self.subTitleLable.textColor = KBCOLOR_WITH_HEX(0xF22424);
    self.subTitleLable.font = [UIFont systemFontOfSize:13];
    self.subTitleLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.subTitleLable];
    self.subTitleLable.text =@"2048.00万";
    
    self.thirdTitleLable = [[UILabel  alloc]init];
    self.thirdTitleLable.textColor = KBCOLOR_WITH_HEX(0x666666);
    self.thirdTitleLable.font = [UIFont systemFontOfSize:13];
    self.thirdTitleLable.textAlignment =  NSTextAlignmentRight;
    [self.contentView addSubview:self.thirdTitleLable];
     self.thirdTitleLable.text =@"";
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(self.img.ct_right+9, self.ct_height-1, self.ct_width-(self.img.ct_right+9), 1)];
    self.lineView.backgroundColor = KBCOLOR_WITH_HEX(0xe2e2e2);
    [self addSubview:self.lineView];
    
    
}

- (void)layoutSubviews
{
    self.lineView.frame = CGRectMake(self.img.ct_right+9, self.ct_height-1, self.ct_width, 1);
    
    self.subTitleLable.frame = CGRectMake(self.ct_width-140, 0, 120, self.ct_height);
    self.titleLable.frame = CGRectMake(self.img.ct_right+9, 0, self.ct_width-125, self.ct_height);
    if (self.rankListCellMode == RankListCellModeTop ) {
      
        self.thirdTitleLable.hidden = YES;
        self.subTitleLable.hidden = NO;
    }
    else if (self.rankListCellMode == RankListCellModeNoneTop )
    {
 
        self.thirdTitleLable.hidden = NO;
        self.subTitleLable.hidden = YES;
        
        
    }
     else if (self.rankListCellMode == RankListCellModeAll)
     {

         self.thirdTitleLable.hidden = NO;
         self.subTitleLable.hidden = NO;
     }
     self.thirdTitleLable.frame = CGRectMake(self.ct_width-200-15,0, 200, self.ct_height);
 
}

- (void)setModel:(KBMidRankModel *)model
{
    self.titleLable.text = model.officename;
    self.titleLable.text = [self.titleLable.text stringByReplacingOccurrencesOfString:@"21世纪不动产-" withString:@""];
    self.titleLable.text = [self.titleLable.text stringByReplacingOccurrencesOfString:@"21世纪不动产—" withString:@""];
    self.titleLable.text = [self.titleLable.text stringByReplacingOccurrencesOfString:@"21世纪不动产" withString:@""];
    self.titleLable.text = [self.titleLable.text stringByReplacingOccurrencesOfString:@"21世纪-" withString:@""];
    self.titleLable.text = [self.titleLable.text stringByReplacingOccurrencesOfString:@"21世纪—" withString:@""];
    self.titleLable.text = [self.titleLable.text stringByReplacingOccurrencesOfString:@"21世纪" withString:@""];
    if (self.titleLable.text.length  > 10) {
        self.titleLable.text = [[self.titleLable.text substringToIndex:10] stringByAppendingString:@"..."];
    }
    NSString *str1 = @"带看：";
    NSString *str2 = @"     ";
    NSMutableAttributedString  *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@%@成交：%@",str1,model.oaddtakealookiynumber,str2,model.oagencysidesynumber]];
    if ([model.tradetype integerValue] == 2) {
        attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@%@成交：%d",str1,model.oaddtakealookiynumber,str2,[model.oagencysidesynumber intValue]]];
        model.oagencysidesynumber = [NSString stringWithFormat:@"%d", [model.oagencysidesynumber intValue]];
    }
    NSRange firstrange = NSMakeRange(str1.length, model.oaddtakealookiynumber.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value: [UIColor redColor] range:firstrange];
    NSRange srange = NSMakeRange(model.oaddtakealookiynumber.length+str1.length+str2.length+3, model.oagencysidesynumber.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:srange];
    self.thirdTitleLable.attributedText = attributedString;
    if (model.index == 1) {
        self.imgLabel.hidden = YES;
        self.img.image = [UIImage imageNamed:@"rank1"];
    }
    else if (model.index == 2) {
        self.imgLabel.hidden = YES;
        self.img.image = [UIImage imageNamed:@"rank2"];
    }
    else if (model.index == 3) {
        self.imgLabel.hidden = YES;
        self.img.image = [UIImage imageNamed:@"rank3"];
    }
    else{
        self.imgLabel.hidden = NO;
        self.imgLabel.text = [NSString stringWithFormat:@"%ld",(long)model.index];
        self.img.image = [UIImage imageNamed:@""];
    }
    
    self.subTitleLable.text = [NSString stringWithFormat:@"%.2f万",[model.oagencyperformancey floatValue]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
