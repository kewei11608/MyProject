//
//  KBProcessView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBProcessView.h"


#define kCircleViewTag  100
#define kLineViewTag  200

#define kCurrentColor kMainColor
#define kDefaultColor KBCOLOR_WITH_HEX(0xd8d8d8)

@interface KBProcessView ()
@property (nonatomic,strong) NSArray *titleArray;


@end
@implementation KBProcessView


- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.titleArray = array;
    [self setup];
    return self;
}

- (void)setup
{
    //CGFloat  width  =  self.ct_width - 100;
    CGFloat  lineWidth  = (self.ct_width - 100 - self.titleArray.count*15)/(self.titleArray.count-1);
    
    [self.titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *circleView = [[UIView alloc]init];
        if (idx == 0) {
            circleView.backgroundColor = kCurrentColor;
        }
        else{
            circleView.backgroundColor = kDefaultColor;
        }
        circleView.frame = CGRectMake(50+lineWidth*idx+(idx>=2?idx:1)*15, 50, 15, 15);
        circleView.layer.masksToBounds = YES;
        circleView.layer.cornerRadius = 7.5;
        circleView.tag = kCircleViewTag +idx;
        [self  addSubview:circleView];
        
        if (idx < self.titleArray.count-1) {
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = kDefaultColor;
            lineView.frame = CGRectMake(circleView.ct_right, 56.5, lineWidth, 2);
            lineView.tag = kLineViewTag + idx;
            [self addSubview:lineView];
        }
        
        UILabel *lable  = [[UILabel alloc]init];
        lable.text = obj;
        lable.textColor = KBCOLOR_WITH_HEX(0x333333);
        lable.font = [UIFont systemFontOfSize:14];
        lable.textAlignment = NSTextAlignmentCenter;
        [self  addSubview:lable];
        lable.frame = CGRectMake(0, circleView.ct_bottom+20, 100, 15);
        lable.ct_centerX = circleView.ct_centerX;

    }];
    
}

- (void)setModifyIphoneState:(KBModifyIphoneState ) modifyIphoneState
{
    UIView *circleView = [self viewWithTag:modifyIphoneState+kCircleViewTag];
    if (circleView) {
        circleView.backgroundColor = kCurrentColor;
    }
    UIView *lineView  = [self viewWithTag:modifyIphoneState+kLineViewTag-1];
    if (lineView) {
        lineView.backgroundColor = kCurrentColor;
    }
}

- (void)setModifyPasswordState:(KBModifyPasswordState ) passwordState
{
    UIView *circleView = [self viewWithTag:passwordState+kCircleViewTag];
    if (circleView) {
        circleView.backgroundColor = kCurrentColor;
    }
    UIView *lineView  = [self viewWithTag:passwordState+kLineViewTag-1];
    if (lineView) {
        lineView.backgroundColor = kCurrentColor;
    }
}




@end
