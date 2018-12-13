//
//  FeedBackDoneView.m
//  KuBoss
//
//  Created by yuyang on 2018/6/17.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "FeedBackDoneView.h"
@interface FeedBackDoneView ()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end
@implementation FeedBackDoneView


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backBtn.backgroundColor = kMainColor;
    self.backBtn.layer.cornerRadius = 5;
    self.backBtn.layer.masksToBounds = YES;
    
}
- (IBAction)backAction:(id)sender {
    if (self.backActionBlock) {
        self.backActionBlock();
    }
}

@end
