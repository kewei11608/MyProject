//
//  HousingMsgCell.m
//  CoolBroker
//
//  Created by lidan on 2018/9/14.
//  Copyright © 2018年 bxs. All rights reserved.
//

#import "HousingMsgCell.h"

#define TEXTFONT     [UIFont systemFontOfSize:13]
@implementation HousingMsgCell
{
    UILabel         *_lbtitle;             //标题
    UILabel         *_lbreddes1;           //多少钱
    UILabel         *_lbreddes2;           //室厅
    UILabel         *_lbreddes3;           //平米
    UILabel         *_lbprice;             //单价
    UILabel         *_lbnumber;            //房源编号
    UILabel         *_lbproperty;               //钥匙
    UILabel         *_lbtype;              //建筑类型
    UILabel         *_lbtoward;            //朝向
    UILabel         *_lbyear;              //年限
    UILabel         *lbline3;
    UIView          *_desview;              //m标签view
    UILabel         *_lbtime;                //首次加入时间
    UILabel         *_lbdoor;                //所属门店
    UILabel         *_lbadd;                 //加入微店量
    UILabel         *_lbbrowse;              //浏览量
    UILabel         *_lbvisitors;            //访客


}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _lbtitle = [[UILabel alloc] init];
    _lbtitle.textColor =blackTextColor;
    _lbtitle.backgroundColor=[UIColor clearColor];
    _lbtitle.numberOfLines=0;
    _lbtitle.font = [UIFont systemFontOfSize:18];
    [self addSubview:_lbtitle];
    [_lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(56);
        make.width.mas_equalTo(MSW-40);
    }];
    
    UILabel*lbline1 = [[UILabel alloc] init];
    lbline1.backgroundColor =LineColor;
    [self addSubview:lbline1];
    [lbline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbtitle.mas_bottom).offset(15);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(MSW-30);
    }];
    
    
    _lbreddes1= [[UILabel alloc] init];
    _lbreddes1.textColor =[UIColor colorWithHex:@"#FC5F61"];
    _lbreddes1.numberOfLines=0;
    _lbreddes1.textAlignment=NSTextAlignmentCenter;
    _lbreddes1.font = [UIFont systemFontOfSize:(30 / 2)];
    [self addSubview:_lbreddes1];
    [_lbreddes1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbline1.mas_bottom).offset(10);
        make.left.equalTo(_lbtitle.mas_left).offset(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(MSW/3-30);
    }];
    
    UILabel*lbvline1 = [[UILabel alloc] init];
    lbvline1.backgroundColor =LineColor;
    [self addSubview:lbvline1];
    [lbvline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbline1.mas_bottom).offset(10);
        make.left.equalTo(_lbreddes1.mas_right).offset(14.5);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(1);
    }];
    
    _lbreddes2= [[UILabel alloc] init];
    _lbreddes2.textColor =[UIColor colorWithHex:@"#FC5F61"];
    _lbreddes2.numberOfLines=0;
    _lbreddes2.textAlignment=NSTextAlignmentCenter;
    _lbreddes2.font = [UIFont systemFontOfSize:(30 / 2)];
    [self addSubview:_lbreddes2];
    [_lbreddes2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbline1.mas_bottom).offset(10);
        make.left.equalTo(_lbreddes1.mas_right).offset(30);
        make.height.mas_equalTo(_lbreddes1.mas_height);
        make.width.mas_equalTo(_lbreddes1.mas_width);
        
    }];
    
    UILabel*lbvline2 = [[UILabel alloc] init];
    lbvline2.backgroundColor =LineColor;
    [self addSubview:lbvline2];
    [lbvline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbvline1.mas_top).offset(0);
        make.left.equalTo(_lbreddes2.mas_right).offset(14.5);
        make.height.mas_equalTo(lbvline1.mas_height);
        make.width.mas_equalTo(lbvline1.mas_width);
    }];
    
    _lbreddes3= [[UILabel alloc] init];
    _lbreddes3.textColor =[UIColor colorWithHex:@"#FC5F61"];
    _lbreddes3.numberOfLines=0;
    _lbreddes3.textAlignment=NSTextAlignmentCenter;
    _lbreddes3.font = [UIFont systemFontOfSize:(30 / 2)];
    [self addSubview:_lbreddes3];
    [_lbreddes3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbline1.mas_bottom).offset(10);
        make.left.equalTo(_lbreddes2.mas_right).offset(30);
        make.height.mas_equalTo(_lbreddes1.mas_height);
        make.width.mas_equalTo(_lbreddes1.mas_width);
        
    }];
    
    UILabel*lbline2 = [[UILabel alloc] init];
    lbline2.backgroundColor =LineColor;
    [self addSubview:lbline2];
    [lbline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbline1.mas_bottom).offset(60);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(MSW-30);
    }];
    
    
    
    _lbprice = [[UILabel alloc] init];
    _lbprice.textColor =grayTextColor;
    _lbprice.font = TEXTFONT;
    [self addSubview:_lbprice];
    [_lbprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbline2.mas_bottom).offset(29.5 / 2);
        make.left.equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MSW/2-20);
    }];
    
    _lbnumber = [[UILabel alloc] init];
    _lbnumber.textColor =grayTextColor;
    _lbnumber.font =TEXTFONT;
    [self addSubview:_lbnumber];
    [_lbnumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbprice.mas_top).offset(0);
        make.left.equalTo(_lbprice.mas_right).offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MSW/2-20);
    }];
    
    _lbproperty = [[UILabel alloc] init];
    _lbproperty.textColor =grayTextColor;
    _lbproperty.font =TEXTFONT;
    [self addSubview:_lbproperty];
    [_lbproperty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbprice.mas_bottom).offset(10);
        make.left.equalTo(_lbprice.mas_left).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MSW/2-20);
    }];
    
    
    _lbtype = [[UILabel alloc] init];
    _lbtype.textColor =grayTextColor;
    _lbtype.font = TEXTFONT;
    [self addSubview:_lbtype];
    [_lbtype mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbproperty.mas_top).offset(0);
        make.left.equalTo(_lbproperty.mas_right).offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MSW/2-20);
    }];
    
    
    _lbyear = [[UILabel alloc] init];
    _lbyear.textColor =grayTextColor;
    _lbyear.font =TEXTFONT;
    [self addSubview:_lbyear];
    [_lbyear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbproperty.mas_bottom).offset(20/ 2);
        make.left.equalTo(_lbprice.mas_left).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MSW/2-20);
    }];
    
    _lbtoward = [[UILabel alloc] init];
    _lbtoward.textColor =grayTextColor;
    _lbtoward.font = TEXTFONT;
    [self addSubview:_lbtoward];
    [_lbtoward mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbyear.mas_top).offset(0);
        make.left.equalTo(_lbyear.mas_right).offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MSW/2-20);
    }];
    
    _desview=[[UIView alloc]init];
//    _desview.backgroundColor=[UIColor redColor];
    [self addSubview:_desview];
    [_desview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbyear.mas_bottom).offset(15);
        make.left.equalTo(_lbyear.mas_left).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MSW-40);
    }];
    
    
    for (int i=0; i<6; i++) {
        UIImageView*imglable=[[UIImageView alloc]initWithFrame:CGRectMake(i*(50+10),0, 50, 20 )];
        imglable.image=[UIImage imageNamed:[NSString stringWithFormat:@"house_lable%i",i+1]];
        if (i==4) {
            imglable.frame=CGRectMake(i*(50+10), 0, 30, 20);
        }else if (i==5){
            imglable.frame=CGRectMake(i*(50+10)-20, 0, 39, 20);
        }
        
        
        [_desview addSubview:imglable];
    }
    
    UILabel*lbline3 = [[UILabel alloc] init];
    lbline3.backgroundColor =LineColor;
    [self addSubview:lbline3];
    [lbline3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_desview.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(15);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(MSW-30);
    }];
    
    UIView*leftview=[[UIView alloc]init];
    leftview.backgroundColor =RGBCOLOR(107, 123, 255);
    [self addSubview:leftview];

    [leftview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbline3.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left).offset(29/2);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(9/2);
    }];
    
   UILabel*lbtracking = [[UILabel alloc] init];
    lbtracking.textColor =blackTextColor;
    lbtracking.backgroundColor=[UIColor clearColor];
    lbtracking.font = [UIFont systemFontOfSize:15];
    [self addSubview:lbtracking];
    lbtracking.text=@"房源跟踪";
    [lbtracking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbline3.mas_bottom).offset(15);
        make.left.equalTo(leftview.mas_right).offset(11/2);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(100);
    }];
    
    
    
    _lbtime= [[UILabel alloc] init];
    _lbtime.textColor =grayTextColor;
    _lbtime.font = TEXTFONT;
    [self addSubview:_lbtime];
    [_lbtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbtracking.mas_bottom).offset(15);
        make.left.equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MSW-40);
    }];
    
    _lbdoor= [[UILabel alloc] init];
    _lbdoor.textColor =grayTextColor;
    _lbdoor.font = TEXTFONT;
    [self addSubview:_lbdoor];
    [_lbdoor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbtime.mas_bottom).offset(10);
        make.left.equalTo(_lbtime.mas_left).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MSW-40);
    }];
    _lbadd= [[UILabel alloc] init];
    _lbadd.textColor =grayTextColor;
    _lbadd.font = TEXTFONT;
    [self addSubview:_lbadd];
    [_lbadd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbdoor.mas_bottom).offset(10);
        make.left.equalTo(_lbdoor.mas_left).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MSW-40);
    }];
    _lbbrowse= [[UILabel alloc] init];
    _lbbrowse.textColor =grayTextColor;
    _lbbrowse.font = TEXTFONT;
    [self addSubview:_lbbrowse];
    [_lbbrowse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbadd.mas_bottom).offset(10);
        make.left.equalTo(_lbadd.mas_left).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MSW-40);
    }];
    
    _lbvisitors= [[UILabel alloc] init];
    _lbvisitors.textColor =grayTextColor;
    _lbvisitors.font = TEXTFONT;
    [self addSubview:_lbvisitors];
    [_lbvisitors mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbbrowse.mas_bottom).offset(10);
        make.left.equalTo(_lbbrowse.mas_left).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(MSW-40);
    }];
    
    
    //默认值
    _lbtitle.text=@"远洋公馆小三居中间远洋公馆";
    _lbreddes1.text=@"630万";
    _lbreddes2.text=@"2室2厅1卫";
    _lbreddes3.text=@"126.8m";
    [self setlabletextwithlable:_lbprice str1:@"单       价：  " str2:@"25500元/平"];
    [self setlabletextwithlable:_lbnumber str1:@"房源编号：  " str2:@"Hr2222"];
    [self setlabletextwithlable:_lbproperty str1:@"物业类型：  " str2:@"暂无"];
    [self setlabletextwithlable:_lbtype str1:@"建筑类型：  " str2:@"叠拼"];
    [self setlabletextwithlable:_lbtoward str1:@"朝       向：  " str2:@"南北"];
    [self setlabletextwithlable:_lbyear str1:@"产权年限：  " str2:@"70年"];

    [self setlabletextwithlable:_lbtime str1:@"首次加入时间：  " str2:@"2018-04-21"];
    [self setlabletextwithlable:_lbdoor str1:@"所  属  门  店 ：  " str2:@"朝阳店"];
    [self setlabletextwithlable:_lbadd str1:@"加 入 微 店 量：  " str2:@"33"];
    [self setlabletextwithlable:_lbbrowse str1:@"总  浏  览  量 ：  " str2:@"222"];
    [self setlabletextwithlable:_lbvisitors str1:@"总  访  客  量 ：  " str2:@"666"];

    
    self.clipsToBounds=YES;
}




-(void)setlabletextwithlable:(UILabel*)lable str1:(NSString*)str1 str2:(NSString*)str2{
    NSDictionary* style1 = @{@"v" :
                                @[[UIColor colorWithHex:@"#9B9B9B"]],
                            @"u": @[blackTextColor]};
    
    lable.attributedText = [[NSString stringWithFormat:@"<v>%@</v><u>%@</u>",str1,str2] attributedStringWithStyleBook:style1];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
