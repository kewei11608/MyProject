//
//  TaskMainView.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "TaskMainView.h"

@implementation TaskMainView
- (IBAction)clickFirst:(id)sender {
    if (self.clickTask) {
        self.clickTask(0);
    }
}
- (IBAction)clickTask:(id)sender {
    if (self.clickTask) {
        self.clickTask(1);
    }
}

- (IBAction)clickOther:(UITapGestureRecognizer *)sender {
    if (self.clickTask) {
        self.clickTask(2);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
