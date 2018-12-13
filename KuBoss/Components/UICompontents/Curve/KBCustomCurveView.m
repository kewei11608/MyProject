//
//  KBCustomCurveView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/4.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBCustomCurveView.h"
#import "KBSinaWave.h"

@interface KBCustomCurveView ()
@property (nonatomic,strong) NSMutableArray *vArray;//竖向坐标点
@property (nonatomic,strong) NSMutableArray *hArray;//横向坐标点

@property (nonatomic,strong) NSMutableArray *shArray;//二手房数组
@property (nonatomic,strong) NSMutableArray *rentArray;//租房

@property (nonatomic, strong) KBSinaWave * chartView;

@end
@implementation KBCustomCurveView
- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (!self) return nil;
    self.vArray = [[NSMutableArray alloc]init];
    self.hArray = [[NSMutableArray alloc]init];
    self.shArray =  [[NSMutableArray alloc]init];
    self.rentArray = [[NSMutableArray alloc]init];
    
    [self.vArray  addObjectsFromArray:@[@"20",@"15",@"10",@"5",@"0"]];
    [self.hArray  addObjectsFromArray:@[@"11.0 1",@"11.0 1",@"11.0 1",@"11.0 1",@"11.0 1"]];
    [self.shArray addObjectsFromArray:@[@"13",@"12",@"14",@"16",@"5"]];
    [self.rentArray addObjectsFromArray:@[@"17",@"15",@"13",@"10",@"9"]];
    [self setup];
    return self;
}

- (void)setup
{
    
    NSInteger vLineHeight = self.ct_height-50;
    NSInteger hLineWidth  = self.ct_width-33;
    NSInteger max = 20;
    
    UIView *vLine = [[UIView alloc]initWithFrame:CGRectMake(33, 0, 2, vLineHeight)];
    vLine.backgroundColor = KBCOLOR_WITH_HEX(0xCCCCCC);
    [self addSubview:vLine];
    
    UIView *hLine = [[UIView alloc]initWithFrame:CGRectMake(33, vLineHeight,  hLineWidth, 2)];
    hLine.backgroundColor = KBCOLOR_WITH_HEX(0xCCCCCC);
    [self addSubview:hLine];
    
    NSInteger vItem = (vLineHeight)/(self.vArray.count-1);
    NSInteger hItem = (self.ct_width-250-33)/(self.hArray.count-1);
    
    [self.vArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, vItem*idx, 33, 13)];
        [self addSubview:lable];
        lable.text = obj;
        lable.textColor = KBCOLOR_WITH_HEX(0x666666);
        lable.textAlignment = NSTextAlignmentRight;
        lable.font = [UIFont systemFontOfSize:12];
        
    }];
    
    [self.hArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake( 40+hItem*idx+40*idx,self.ct_height-50, 50, 33)];
        [self addSubview:lable];
        lable.numberOfLines = 2;
        lable.textAlignment = NSTextAlignmentLeft;
        lable.text = obj;
        lable.textColor = KBCOLOR_WITH_HEX(0x666666);
        lable.textAlignment = NSTextAlignmentRight;
        lable.font = [UIFont systemFontOfSize:12];
        
        
       
        
    }];
    
    [self addSubview:self.chartView];
    
    
    
}

- (KBSinaWave * )chartView{
    if (!_chartView) {
        _chartView = [[KBSinaWave alloc]init];
        _chartView.backgroundColor = [UIColor whiteColor];
        _chartView.frame =CGRectMake(33, 0, self.ct_width-33, self.ct_height-50);
 
    }
    return _chartView;
}



@end
