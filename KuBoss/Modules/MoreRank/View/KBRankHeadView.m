//
//  KBRankHeadView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRankHeadView.h"
@interface KBRankHeadView ()

@end
@implementation KBRankHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.backgroundColor = [UIColor whiteColor];
    [self setup];
    return self;
}

- (void)setup
{
//    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(15, 16, 5, 13)];
//    leftView.backgroundColor = kMainColor;
//    [self addSubview:leftView];
    
    self.leftLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 45)];
    self.leftLable.text  = @"成交业绩榜";
    self.leftLable.textColor = KBCOLOR_WITH_HEX(0x666666);
    self.leftLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.leftLable];
    
    self.rightLable = [[UILabel alloc]initWithFrame:CGRectMake(self.ct_width-15-300, 0, 300, 45)];
    self.rightLable.text  = @"";
    self.rightLable.textAlignment = NSTextAlignmentRight;
    self.rightLable.font = [UIFont systemFontOfSize:13];
    self.rightLable.textColor = kMainColor;
    [self addSubview:self.rightLable];
    
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rank)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    self.rightLable.userInteractionEnabled = YES;
    [self.rightLable addGestureRecognizer:tap];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, self.ct_height-1, self.ct_width-15, 1)];
    line.backgroundColor = KBCOLOR_WITH_HEX(0xe2e2e2);
    [self addSubview:line];
}

- (void)setTitle:(NSString *)title
{
    self.rightLable.text = title;
}

- (void)rank
{
    if (self.rankBlock) {
        self.rankBlock();
    }
}

@end
