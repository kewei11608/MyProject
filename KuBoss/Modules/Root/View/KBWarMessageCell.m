//
//  KBWarMessageCell.m
//  KuBoss
//
//  Created by yuyang on 2018/4/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBWarMessageCell.h"
@interface KBWarMessageCell ()
@property (nonatomic,strong)UILabel *titleLable;
@property (nonatomic,strong)UILabel *subTitleLable;
@property (nonatomic,strong)UIImageView *bgImg;
@property (nonatomic,strong)UIView *lineView;

@end
@implementation KBWarMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return self;
    [self setup];
    return self;
}
- (void)setup
{
    
//    self.bgImg = [[UIImageView alloc]init];
//    [self.contentView addSubview:self.bgImg];
//    self.bgImg.image =  [UIImage imageNamed:@"CombinedShape"];
    
    self.titleLable = [[UILabel  alloc]init];
    self.titleLable.textColor = KBCOLOR_WITH_HEX(0x585858);
    self.titleLable.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLable];
    self.titleLable.text =@"恭喜朝阳大悦城店经纪人张小建顺利签约买卖单！";
    
    self.subTitleLable = [[UILabel  alloc]init];
    self.subTitleLable.textColor = KBCOLOR_WITH_HEX(0x999999);
    self.subTitleLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.subTitleLable];
    self.subTitleLable.text =@"龙锦苑一区  89m²  2018.09.27 13:42";
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = KBCOLOR_WITH_HEX(0xE2E2E2);
    [self.contentView addSubview:self.lineView];
}

- (void)layoutSubviews
{
  //  self.bgImg.frame = CGRectMake(15, 0, self.ct_width-30, 85);
    self.titleLable.frame = CGRectMake(20, 15, self.ct_width-72, 15);
    self.subTitleLable.frame = CGRectMake(20, self.titleLable.ct_bottom+10, self.ct_width-72, 13);
    self.lineView.frame = CGRectMake(20, self.ct_height-1, self.ct_width-20, 1);
}

- (void)setModel:(KBMidWarReportModel *)warModel
{
    self.titleLable.text =  warModel.message; //[NSString stringWithFormat:@"恭喜%@经纪人%@顺利签约买卖单！",warModel.officename,warModel.agentname];
    self.subTitleLable.text =  [NSString stringWithFormat:@"%@  %@m² %@",warModel.housename,warModel.area,warModel.signingtime];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
