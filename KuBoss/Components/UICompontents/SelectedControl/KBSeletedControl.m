//
//  KBSeletedControl.m
//  KuBoss
//
//  Created by yuyang on 2018/4/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBSeletedControl.h"
#define  kTag 100
@interface KBSeletedControl ()
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) NSMutableArray *pointArray;
@property (nonatomic,strong) UIView *lineView;

@end
@implementation KBSeletedControl

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.titleArray = array;
    self.pointArray = [[NSMutableArray alloc]init];
    self.backgroundColor = KBCOLOR_WITH_HEX(0xF4F5FA);
    
    [self setup];
    return self;
}

- (void)setup
{
    [self.titleArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = idx+kTag;
        [self addSubview:btn];
        btn.frame = CGRectMake(18+idx*58, 15, 45, 20);
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.pointArray addObject:[NSNumber numberWithFloat:btn.center.x]];
        
        if (idx == 0) {
            [btn setTitleColor:kMainColor forState:UIControlStateNormal];
        }
        else{
            [btn setTitleColor:KBCOLOR_WITH_HEX(0x333333) forState:UIControlStateNormal];
        }
    }];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 35+3, 20, 3)];
    self.lineView.backgroundColor = kMainColor;
    self.lineView.ct_centerX = 40;
    self.lineView.layer.cornerRadius = self.lineView.ct_height/2;
    self.lineView.layer.masksToBounds = YES;
    
    [self addSubview:self.lineView];
    
    
    if ([KBUserDefaultLayer getFilterHouseType]) {
        NSString *str =  [KBUserDefaultLayer getFilterHouseType];
        UIButton *btn = [self viewWithTag:[str integerValue]];
        if (btn) {
            [self click:btn];
        }
    } ;

    
}

- (void)click:(UIButton *)btn
{
    for (int i = 0; i<self.titleArray.count; i++) {
        UIButton *allbtn = [self viewWithTag:i+kTag];
        if (allbtn) {
             [allbtn setTitleColor:KBCOLOR_WITH_HEX(0x333333) forState:UIControlStateNormal];
        }
    }
    
    [btn setTitleColor:kMainColor forState:UIControlStateNormal];
    if (self.selectedIndexBlock) {
        self.selectedIndexBlock(btn);
    }
    self.lineView.ct_centerX = [[self.pointArray objectAtIndex:btn.tag-kTag] floatValue];
    
    [KBUserDefaultLayer setFilterHouseType:[NSString stringWithFormat:@"%ld",btn.tag]];
    
}

-(void)setSelectedIndex:(NSInteger)index {
    UIButton *selectedBtn = [self viewWithTag:index + kTag];
    [self click:selectedBtn];
}

@end
