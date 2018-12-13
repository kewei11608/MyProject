//
//  HouseDoneView.m
//  KuBoss
//
//  Created by yuyang on 2018/6/17.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "HouseDoneView.h"

@implementation HouseDoneView


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imgAgent.layer.masksToBounds = YES;
    self.imgAgent.layer.cornerRadius = 25;
    
    self.imgAuditing.layer.masksToBounds = YES;
    self.imgAuditing.layer.cornerRadius = 25;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
