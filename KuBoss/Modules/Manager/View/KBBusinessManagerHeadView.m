//
//  KBBusinessManagerHeadView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBusinessManagerHeadView.h"

@interface KBBusinessManagerHeadView ()
{
    UILabel *sub1;
    UILabel *sub2;
    UILabel *sub3;
    UILabel *sub4;
    UILabel *sub5;
    UILabel *sub6;
    UILabel *sub7;
    UILabel *sub8;
    UILabel *sub9;
    UILabel *sub10;
    
    UILabel *Lab1;
    UILabel *Lab2;
    UILabel *Lab3;
    UILabel *Lab4;
    UILabel *Lab5;
    UILabel *Lab6;
    UILabel *Lab7;
    UILabel *Lab8;
    UILabel *Lab9;
}

@end
@implementation KBBusinessManagerHeadView


- (instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame: frame];
    if (!self) return nil;
    
    [self setup];
    return self;
}

- (void)setup
{
    
    if ([KBUserDefaultLayer getFilterHouseType]) {
        NSString *str =  [KBUserDefaultLayer getFilterHouseType];
        if ([str integerValue] == 102) {
            self.isNew = YES;
        }
        else{
              self.isNew = NO;
        }
    } ;
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(15, 16, 4, 13)];
    leftView.backgroundColor = kMainColor;
    [self addSubview:leftView];
    
    UILabel *totalLable = [[UILabel alloc]initWithFrame:CGRectMake(leftView.ct_right+6, 14, 200, 16)];
    totalLable.text  = @"汇总数据";
    totalLable.textColor = KBCOLOR_WITH_HEX(0x666666);
    totalLable.font = [UIFont systemFontOfSize:14];
    [self addSubview:totalLable];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(15, totalLable.ct_bottom+15, self.ct_width-30, 220)];
    bgView.backgroundColor = [UIColor whiteColor];
//    bgView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
//    bgView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    bgView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
//    bgView.layer.shadowRadius = 2;//阴影半径，默认3
    [self addSubview:bgView];
    
    UIView *v0lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 0,bgView.ct_width-10, 0.5)];
    v0lineView.backgroundColor = KBCOLOR_WITH_HEX(0xd2d2d2);
    [bgView addSubview:v0lineView];
    
    UIView *v1lineView = [[UIView alloc]initWithFrame:CGRectMake(10, bgView.ct_height/3,bgView.ct_width-10, 0.5)];
    v1lineView.backgroundColor = KBCOLOR_WITH_HEX(0xd2d2d2);
    [bgView addSubview:v1lineView];
    
    UIView *v2lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 2*bgView.ct_height/3,bgView.ct_width-10, 0.5)];
    v2lineView.backgroundColor = KBCOLOR_WITH_HEX(0xd2d2d2);
    [bgView addSubview:v2lineView];
    
    UIView *v3lineView = [[UIView alloc]initWithFrame:CGRectMake(10, bgView.ct_height,bgView.ct_width-10, 0.5)];
    v3lineView.backgroundColor = KBCOLOR_WITH_HEX(0xd2d2d2);
    [bgView addSubview:v3lineView];
    
    for ( int i = 0; i < 6; i++)
    {

        float h  = 18+(bgView.ct_height/3)*(i/2);
        UIView *hlineView = [[UIView alloc]initWithFrame:CGRectMake(bgView.ct_width/2, h, 0.5, bgView.ct_height/3 - 36)];
        hlineView.backgroundColor = KBCOLOR_WITH_HEX(0xd2d2d2);
        [bgView addSubview:hlineView];
        
        
    }
    

    UILabel *Lab = [self lable];
    Lab.text = @"总业绩（已审核）";
    [bgView addSubview:Lab];
    Lab.frame = CGRectMake(15, 15,bgView.ct_width/2, 15);
    
    sub1 = [self lable];
    sub1.textColor = [UIColor redColor];
    sub1.font = [UIFont systemFontOfSize:20];
    sub1.text = @"";
    sub1.frame = CGRectMake(15, Lab.ct_bottom+2, bgView.ct_width/2, 30);
    [bgView addSubview:sub1];
    
    
    
    Lab1 = [self lable];
    Lab1.text = @"总成交数";
    [bgView addSubview:Lab1];
    Lab1.textAlignment = NSTextAlignmentCenter;
    Lab1.frame = CGRectMake(bgView.ct_width/2, 15,bgView.ct_width/4, 15);
    
    sub2 = [self lable];
    sub2.textColor = [UIColor blackColor];
    sub2.font = [UIFont systemFontOfSize:20];
    sub2.text = @"0";
    sub2.textAlignment = NSTextAlignmentLeft;
    sub2.frame = CGRectMake(bgView.ct_width/2, Lab1.ct_bottom+2, bgView.ct_width/2, 30);
    [bgView addSubview:sub2];
    
    
    //  ltem1
    Lab2 = [self lable];
    Lab2.text = @"新增报备";
    Lab2.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:Lab2];
    Lab2.frame = CGRectMake(0, bgView.ct_height/3+15,bgView.ct_width/4, 15);
    
    sub3 = [self lable];
    sub3.text = @"0";
    sub3.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:sub3];
    sub3.frame = CGRectMake(0, Lab2.ct_bottom+10,bgView.ct_width/4, 15);
    
    
    
    Lab3 = [self lable];
    Lab3.text = @"店均";
    [bgView addSubview:Lab3];
     Lab3.textAlignment = NSTextAlignmentCenter;
    Lab3.frame = CGRectMake(bgView.ct_width/4, bgView.ct_height/3+15,bgView.ct_width/4, 15);
    
    sub4 = [self lable];
    sub4.text = @"0";
    [bgView addSubview:sub4];
     sub4.textAlignment = NSTextAlignmentCenter;
    sub4.frame = CGRectMake(bgView.ct_width/4, Lab3.ct_bottom+10,bgView.ct_width/4, 15);
    
    
    //  ltem2
    Lab4 = [self lable];
    Lab4.text = @"新增确客";
    Lab4.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:Lab4];
    Lab4.frame = CGRectMake(bgView.ct_width/2 + 10, bgView.ct_height/3+15,bgView.ct_width/4, 15);
    
    sub5 = [self lable];
    sub5.text = @"0";
    [bgView addSubview:sub5];
    sub5.textAlignment = NSTextAlignmentCenter;
    sub5.frame = CGRectMake(bgView.ct_width/2 + 10, Lab4.ct_bottom+15,bgView.ct_width/4, 15);
    
    
    Lab5 = [self lable];
    Lab5.text = @"店均";
    [bgView addSubview:Lab5];
    Lab5.textAlignment = NSTextAlignmentCenter;
    Lab5.frame = CGRectMake(3*bgView.ct_width/4, bgView.ct_height/3+15,bgView.ct_width/4, 15);
    
    sub6 = [self lable];
    sub6.text = @"0";
    [bgView addSubview:sub6];
    sub6.textAlignment = NSTextAlignmentCenter;
    sub6.frame = CGRectMake(3*bgView.ct_width/4, Lab5.ct_bottom+15,bgView.ct_width/4, 15);
    
    
    //  ltem3
    Lab6 = [self lable];
    Lab6.text = @"新增客源带看";
    [bgView addSubview:Lab6];
    Lab6.textAlignment = NSTextAlignmentCenter;
    Lab6.frame = CGRectMake(0, 2*bgView.ct_height/3+15,bgView.ct_width/4, 15);
    
    
    sub7 = [self lable];
    sub7.text = @"0";
    [bgView addSubview:sub7];
    sub7.textAlignment = NSTextAlignmentCenter;
    sub7.frame = CGRectMake(0, Lab6.ct_bottom+15,bgView.ct_width/4, 15);
    
    
    
    Lab7 = [self lable];
    Lab7.text = @"店均";
    [bgView addSubview:Lab7];
    Lab7.textAlignment = NSTextAlignmentCenter;
    Lab7.frame = CGRectMake(bgView.ct_width/4, 2*bgView.ct_height/3+15,bgView.ct_width/4, 15);
    
    
    sub8 = [self lable];
    sub8.text = @"0";
    [bgView addSubview:sub8];
    sub8.textAlignment = NSTextAlignmentCenter;
    sub8.frame = CGRectMake(bgView.ct_width/4, Lab7.ct_bottom+15,bgView.ct_width/4, 15);
    
    
    //  ltem3
    Lab8 = [self lable];
    Lab8.text = @"新增认购";
    [bgView addSubview:Lab8];
    Lab8.textAlignment = NSTextAlignmentCenter;
    Lab8.frame = CGRectMake(bgView.ct_width/2 + 10, 2*bgView.ct_height/3+15,bgView.ct_width/4, 15);
    
    
    sub9 = [self lable];
    sub9.text = @"0";
    [bgView addSubview:sub9];
    sub9.textAlignment = NSTextAlignmentCenter;
    sub9.frame = CGRectMake(bgView.ct_width/2 + 10, Lab8.ct_bottom+15,bgView.ct_width/4, 15);
    
    Lab9 = [self lable];
    Lab9.text = @"店均";
    [bgView addSubview:Lab9];
    Lab9.textAlignment = NSTextAlignmentCenter;
    Lab9.frame = CGRectMake(3*bgView.ct_width/4, 2*bgView.ct_height/3+15,bgView.ct_width/4, 15);
    
    sub10 = [self lable];
    sub10.text = @"0";
    [bgView addSubview:sub10];
    sub10.textAlignment = NSTextAlignmentCenter;
    sub10.frame = CGRectMake(3*bgView.ct_width/4, Lab9.ct_bottom+15,bgView.ct_width/4, 15);
    
    
    UIView *b = [[UIView alloc] initWithFrame:CGRectMake(0, self.ct_height-10, self.ct_width, 10)];
    b.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    [self addSubview:b];
    
    
}

- (UILabel *)lable
{
    UILabel *t1 = [[UILabel alloc]init];
    t1.textColor = KBCOLOR_WITH_HEX(0x333333);
    t1.font = [UIFont systemFontOfSize:14];
    return t1;
}


- (void)setModel:(KBMidUperRBMolde *)model
{
    if (model == nil) {
        sub1.text = @"--";
        sub2.text = @"  --";
        sub3.text = @"--";
        sub4.text = @"--";
        sub5.text = @"--";
        sub6.text = @"--";
        sub7.text = @"--";
        sub8.text = @"--";
        sub9.text = @"--";
        sub10.text = @"--";//店均
        return;
    }
    
    NSString *string = [NSString stringWithFormat:@"%.2f",model.oagencyperformance];
    NSMutableAttributedString  *m_attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 万",string]];
    [m_attributedString addAttribute:NSForegroundColorAttributeName
                               value: [UIColor redColor]
                               range:NSMakeRange(0, string.length)];//设
    [m_attributedString addAttribute:NSForegroundColorAttributeName
                               value: KBCOLOR_WITH_HEX(0x666666)
                               range:NSMakeRange(string.length, 2)];//设
    
    [m_attributedString addAttribute:NSFontAttributeName
                               value: [UIFont systemFontOfSize:20]
                               range:NSMakeRange(0, string.length)];//设
    
    [m_attributedString addAttribute:NSFontAttributeName
                               value: [UIFont systemFontOfSize:9]
                               range:NSMakeRange(string.length, 2)];//设
    
     sub1.attributedText =  m_attributedString;
    
    if (self.isNew) {
        
        Lab1.text = @"总成交单数";
        Lab2.text = @"新增报备";
        Lab4.text = @"新增确客";
        Lab6.text = @"新增客源带看";
        Lab8.text = @"新增认购";
        
        sub2.text =[NSString stringWithFormat:@"  %.f", model.oagencysidesnumber];
        sub3.text =[NSString stringWithFormat:@"%ld", model.oaddreportnumber];
        sub4.text =[NSString stringWithFormat:@"%.1f",model.oaddreportnumberavg];
        sub5.text =[NSString stringWithFormat:@"%ld", model.oaddaccurateguestnumber];
        sub6.text =[NSString stringWithFormat:@"%.1f",model.oaddaccurateguestnumberavg];
        sub7.text =[NSString stringWithFormat:@"%ld", model.oaddtakealookinumber];
        sub8.text =[NSString stringWithFormat:@"%.1f",model.oaddtakealookinumberavg];
        sub9.text =[NSString stringWithFormat:@"%ld", model.oaddsubscribenumber];
        sub10.text =[NSString stringWithFormat:@"%.1f", model.oaddsubscribenumberavg];//店均
    }
    else
    {
        Lab1.text = @"总签约边数";
        Lab2.text = @"新增房源";
        Lab4.text = @"新增客源";
        Lab6.text = @"新增客源带看";
        Lab8.text = @"新增实勘作业";
        
        sub2.text =[NSString stringWithFormat:@"  %.1lf", model.oagencysidesnumber];
        sub3.text =[NSString stringWithFormat:@"%ld", model.oaddavailabilitynumber];
        sub4.text =[NSString stringWithFormat:@"%.1f",model.oaddavailabilitynumberavg];
        sub5.text =[NSString stringWithFormat:@"%ld", model.oaddtouristnumber];
        sub6.text =[NSString stringWithFormat:@"%.1f",model.oaddtouristnumberavg];
        sub7.text =[NSString stringWithFormat:@"%ld", model.oaddtakealookinumber];
        sub8.text =[NSString stringWithFormat:@"%.1f",model.oaddtakealookinumberavg];
        sub9.text =[NSString stringWithFormat:@"%ld", model.oaddrealservicenumber];
        sub10.text =[NSString stringWithFormat:@"%.1f", model.oaddrealservicenumberavg];//店均
    }
    
   
}

@end
