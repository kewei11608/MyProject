//
//  KBAgentCell.m
//  KuBoss
//
//  Created by yuyang on 2018/5/13.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBAgentCell.h"
@interface KBAgentCell ()
@property (nonatomic,strong) UILabel *upTimeLab;
@property (nonatomic,strong) UILabel *downTimeLab;
@property (nonatomic,strong) UIView *circleView ;
@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *firstLab;
@property (nonatomic,strong) UILabel *secondLab;
@property (nonatomic,strong) UILabel *thirdLab;
@property (nonatomic,strong) UILabel *fourLab;
@property (nonatomic,strong) UILabel *fiveLab;

@end
@implementation KBAgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setModel:(KBBottomEDModel *)model
{
    self.firstLab.text = @"";
    self.secondLab.text = @"";
    self.thirdLab.text = @"";
    self.fourLab.text = @"";
    self.fiveLab.text = @"";
    self.titleLab.text = model.title;
   

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:model.operationtime];
   // self.downTimeLab.text =[NSString stringWithFormat:@"%ld.%ld",model.operationtime.hours,model.operationtime.minutes];
    if (!date) {
        [formatter setDateFormat:@"yyyy-M-dd HH:mm"];
        //NSString转NSDate
        date=[formatter dateFromString:model.operationtime];
    }
   
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    //NSDate转NSString
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter1 setDateFormat:@"HH:mm"];
    NSString *upTimeString = [dateFormatter stringFromDate:date];
    NSString *downTimeLab =  [dateFormatter1 stringFromDate:date];
    self.upTimeLab.text = upTimeString;
    self.downTimeLab.text = downTimeLab;
    
    
    [[model array] enumerateObjectsUsingBlock:^(NSString *content, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case 0:
                self.firstLab.text = content;
                break;
            case 1:
                self.secondLab.text = content;
                break;
            case 2:
                self.thirdLab.text = content;
                break;
            case 3:
                self.fourLab.text = content;
                break;
            case 4:
                self.fiveLab.text = content;
                break;
                
            default:
                break;
        }
        
    }];
}

- (void)setup
{
    self.upTimeLab = [[UILabel alloc]init];
    self.upTimeLab.font = [UIFont systemFontOfSize:12];
    self.upTimeLab.textColor = KBCOLOR_WITH_HEX(0x999999);
    self.upTimeLab.text = @"2018.01.28 ";
    self.upTimeLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.upTimeLab];
    
    self.downTimeLab = [[UILabel alloc]init];
    self.downTimeLab.font = [UIFont systemFontOfSize:12];
    self.downTimeLab.textColor = KBCOLOR_WITH_HEX(0x999999);
    self.downTimeLab.textAlignment = NSTextAlignmentRight;
    self.downTimeLab.text = @"23:30";
    [self addSubview:self.downTimeLab];
    
    self.circleView = [[UIView alloc]init];
    self.circleView.backgroundColor = kMainColor;
    self.circleView.layer.masksToBounds = YES;
    self.circleView.layer.cornerRadius = 5;
    [self addSubview:self.circleView];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = kMainColor;
    [self addSubview:self.lineView];
    
    
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont systemFontOfSize:16];
    self.titleLab.textColor = KBCOLOR_WITH_HEX(0x333333);
    self.titleLab.text = @"";
    [self addSubview:self.titleLab];
    
    self.firstLab = [[UILabel alloc]init];
    self.firstLab.font = [UIFont systemFontOfSize:14];
    self.firstLab.textColor =KBCOLOR_WITH_HEX(0x666666);
    self.firstLab.text = @"";
    [self addSubview:self.firstLab];
    
    self.secondLab = [[UILabel alloc]init];
    self.secondLab.font = [UIFont systemFontOfSize:14];
    self.secondLab.textColor =KBCOLOR_WITH_HEX(0x666666);
    self.secondLab.text = @"";
    [self addSubview:self.secondLab];
    
    self.thirdLab = [[UILabel alloc]init];
    self.thirdLab.font = [UIFont systemFontOfSize:14];
    self.thirdLab.textColor =KBCOLOR_WITH_HEX(0x666666);
    self.thirdLab.text = @"";
    [self addSubview:self.thirdLab];
    
    self.fourLab = [[UILabel alloc]init];
    self.fourLab.font = [UIFont systemFontOfSize:14];
    self.fourLab.textColor =KBCOLOR_WITH_HEX(0x666666);
    self.fourLab.text = @"";
    [self addSubview:self.fourLab];
    
    
    self.fiveLab = [[UILabel alloc]init];
    self.fiveLab.font = [UIFont systemFontOfSize:14];
    self.fiveLab.textColor =KBCOLOR_WITH_HEX(0x666666);
    self.fiveLab.text = @"";
    [self addSubview:self.fiveLab];
    
    
}

- (void)layoutSubviews
{
    self.upTimeLab.frame = CGRectMake(0, 0, 80, 13);
    self.downTimeLab.frame = CGRectMake(0, self.upTimeLab.ct_bottom, 80, 13);
    self.circleView.frame = CGRectMake(85, 0, 10, 10);
    self.lineView.frame = CGRectMake(89.5, self.circleView.ct_bottom, 2, self.ct_height-self.circleView.ct_bottom);
    self.titleLab.frame = CGRectMake(self.circleView.ct_left+15, self.circleView.ct_top, self.ct_width - self.circleView.ct_left -10 , 20);
    self.firstLab.frame = CGRectMake(self.circleView.ct_left+15, self.titleLab.ct_bottom, self.ct_width - self.circleView.ct_left -10 , 20);
    self.secondLab.frame = CGRectMake(self.circleView.ct_left+15, self.firstLab.ct_bottom, self.ct_width - self.circleView.ct_left -10 , 20);
    self.thirdLab.frame = CGRectMake(self.circleView.ct_left+15, self.secondLab.ct_bottom, self.ct_width - self.circleView.ct_left -10 , 20);
    self.fourLab.frame = CGRectMake(self.circleView.ct_left+15, self.thirdLab.ct_bottom, self.ct_width - self.circleView.ct_left -10 , 20);
    self.fiveLab.frame = CGRectMake(self.circleView.ct_left+15, self.fourLab.ct_bottom, self.ct_width - self.circleView.ct_left -10 , 20);
    
}

- (void)setIsLast:(BOOL)isLast {
    _isLast = isLast;
    self.lineView.hidden = isLast;
}

@end
