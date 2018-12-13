//
//  KBBusinessManageCell.m
//  KuBoss
//
//  Created by yuyang on 2018/4/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBusinessManageCell.h"
@interface KBBusinessManageCell ()
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *subTitleLable;
@property (nonatomic,strong)  UIImageView *imgView;
@property (nonatomic,strong) UIView *line ;

@end
@implementation KBBusinessManageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self)  return nil;
    [self setup];
    return self;
}

- (void)setup
{
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(18, 13,210, 15)];
    self.titleLable.font = [UIFont systemFontOfSize:14];
    self.titleLable.textColor  = KBCOLOR_WITH_HEX(0x333333);
    self.titleLable.text = @"";
    [self.contentView  addSubview:self.titleLable];
    
    self.subTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(18, self.titleLable.ct_bottom+8, self.ct_width, 13)];
    
    self.subTitleLable.font = [UIFont systemFontOfSize:12];
    self.subTitleLable.textColor  = KBCOLOR_WITH_HEX(0x999999);
    self.subTitleLable.text = @"";
    [self.contentView  addSubview:self.subTitleLable];
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.image = [UIImage imageNamed:@"right_arrow"];
    [self.contentView addSubview:self.imgView];
    
    self.line = [[UIView alloc]init];
    self.line.backgroundColor = KBCOLOR_WITH_HEX(0xd2d2d2);
    [self.contentView addSubview:self.line];
    
}

- (void)layoutSubviews
{
    self.titleLable.frame = CGRectMake(18, 13,210, 15);
    self.subTitleLable.frame = CGRectMake(18, self.titleLable.ct_bottom+8, self.ct_width, 13);
    self.imgView.frame = CGRectMake(self.ct_width-25,( self.ct_height-18)/2,10, 18);
    self.line.frame   =  CGRectMake(15, self.ct_height-1,self.ct_width-15, 0.5);
}

- (void)setModel:(KBListRBModel *)model isNew:(BOOL) isNew
{
    self.titleLable.text = model.officename;
    if (!isNew) {
    self.subTitleLable.text = [NSString stringWithFormat:@"%ld房  %ld客  %ld勘  %ld带  %.1f边",model.oaddavailabilitynumber,model.oaddtouristnumber,model.oaddrealservicenumber,model.oaddtakealookinumber,model.oagencysidesnumber];
    }
    else{
    self.subTitleLable.text = [NSString stringWithFormat:@"%ld报  %ld确  %ld带  %ld认  %.f成",model.oaddreportnumber,model.oaddaccurateguestnumber,model.oaddtakealookinumber,model.oaddsubscribenumber,model.oagencysidesnumber];
    }
 
}


@end
