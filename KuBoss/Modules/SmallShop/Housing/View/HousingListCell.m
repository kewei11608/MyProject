//
//  HousingListCell.m
//  KuBoss
//
//  Created by lidan on 2018/11/21.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import "HousingListCell.h"

@implementation HousingListCell
{
    UIImageView         *_imghose;
    UILabel             *_lbtitle;             //标题
    UILabel             *_lbtime;             //时间
    UILabel             *_lbvisitors;         //访客
    UILabel             *_lbbrowse;         //浏览量

    UILabel             *_lbprice;         //价格

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    _imghose=[[UIImageView alloc]init];
    _imghose.backgroundColor=[UIColor redColor];
    [self addSubview:_imghose];
    [_imghose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(75);
        make.width.mas_equalTo(100);
    }];
    
    UIButton*btimg = [UIButton buttonWithType:UIButtonTypeCustom];

    btimg.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btimg setImage:[UIImage imageNamed:@"house_ sigh"] forState:UIControlStateNormal];
//    [btimg addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [btimg setTitleColor:[UIColor grayColor] forState:0];
    [self addSubview:btimg];
    [btimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(self.mas_right).offset(-22);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
    
    _lbtitle = [[UILabel alloc] init];
    _lbtitle.textColor =[UIColor blackColor];
    _lbtitle.backgroundColor=[UIColor clearColor];
    _lbtitle.numberOfLines=0;
    _lbtitle.font = [UIFont systemFontOfSize:14];
    [self addSubview:_lbtitle];
    [_lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(23/2);
        make.left.equalTo(_imghose.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-50);
        make.height.mas_equalTo(14);
//        make.width.mas_equalTo(MSW-50);
    }];
    _lbtitle.text=@"中式装修风格的诚心出售";
    
    _lbtime = [[UILabel alloc] init];
    _lbtime.textColor =[UIColor colorWithHex:@"#767676"];
    _lbtime.backgroundColor=[UIColor clearColor];
    _lbtime.numberOfLines=0;
    _lbtime.font = [UIFont systemFontOfSize:12];
    [self addSubview:_lbtime];
    [_lbtime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbtitle.mas_bottom).offset(20/2);
        make.left.equalTo(_lbtitle.mas_left).offset(0);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(MSW-150);
    }];
    _lbtime.text=@"加入时间：2018-04-21";
    
    _lbvisitors = [[UILabel alloc] init];
    _lbvisitors.textColor =[UIColor colorWithHex:@"#767676"];
    _lbvisitors.backgroundColor=[UIColor clearColor];
    _lbvisitors.numberOfLines=0;
    _lbvisitors.font = [UIFont systemFontOfSize:12];
    [self addSubview:_lbvisitors];
    [_lbvisitors mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbtime.mas_bottom).offset(14/2);
        make.left.equalTo(_lbtitle.mas_left).offset(0);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(100);
    }];
    _lbvisitors.text=@"总访客量：211";
    
    _lbbrowse = [[UILabel alloc] init];
    _lbbrowse.textColor =[UIColor colorWithHex:@"#767676"];
    _lbbrowse.backgroundColor=[UIColor clearColor];
    _lbbrowse.numberOfLines=0;
    _lbbrowse.font = [UIFont systemFontOfSize:12];
    [self addSubview:_lbbrowse];
    [_lbbrowse mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lbvisitors.mas_bottom).offset(15/2);
        make.left.equalTo(_lbtitle.mas_left).offset(0);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(100);
    }];
    _lbbrowse.text=@"总浏览量：211";
    
    
    
    _lbprice = [[UILabel alloc] init];
    _lbprice.textColor =[UIColor colorWithHex:@"#9B9B9B"];
    _lbprice.backgroundColor=[UIColor clearColor];
    _lbprice.numberOfLines=0;
    _lbprice.font = [UIFont systemFontOfSize:12];
    [self addSubview:_lbprice];
    [_lbprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(109/2);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    _lbprice.textAlignment=NSTextAlignmentRight;
    NSDictionary* style1 = @{@"v" :
                                 @[
                                     [UIFont fontWithName:@"DINAlternate-Bold" size:18]],
                             @"u": @[[UIFont systemFontOfSize:11] ]
                             };
    
    _lbprice.attributedText = [[NSString stringWithFormat: @"<v>1020</v>元/月"] attributedStringWithStyleBook:style1];

//    _lbprice.text=@"12333";
    
    
    
    for (int i=0; i<6; i++) {
        UIImageView*imglable=[[UIImageView alloc]initWithFrame:CGRectMake(120+i*(50+10),95, 50, 20 )];
//        imglable.backgroundColor=[UIColor redColor];
        imglable.image=[UIImage imageNamed:[NSString stringWithFormat:@"house_lable%i",i+1]];
        if (i==4) {
            imglable.frame=CGRectMake(120, 125, 30, 20);
        }else if (i==5){
            imglable.frame=CGRectMake(160, 125, 39, 20);
        }
        
        
        [self addSubview:imglable];
    }
    
    
    
    
    
    UILabel*lbline = [[UILabel alloc] init];
    lbline.backgroundColor =LineColor;
    [self addSubview:lbline];
    [lbline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(MSW-40);
    }];
    
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
