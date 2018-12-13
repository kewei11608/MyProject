//
//  KBFeedBackViewCell.m
//  KuBoss
//
//  Created by yuyang on 2018/5/19.
//  Copyright © 2018年 yuyang. All rights reserved.
//
#import "KBFeedBackViewCell.h"

@implementation KBFeedBackViewModel

@end

@interface KBFeedBackViewCell ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton  *addBtn;
@property (nonatomic,strong) UIButton  *deleteBtn;
@property (nonatomic,strong) KBFeedBackViewModel  *feedbackmodel;

@end
@implementation KBFeedBackViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    self.layer.borderColor  = KBCOLOR_WITH_HEX(0x666666).CGColor;
    self.layer.borderWidth = 1;
    
    self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:self.imageView];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //self.addBtn.frame =  CGRectMake((self.ct_width - 22)/2, (self.ct_height - 22)/2, 22, 22);
    self.addBtn.frame =  CGRectMake(0, 0, self.ct_width, self.ct_height);
    [self.addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self addSubview: self.addBtn];
    [self.addBtn addTarget:self action:@selector(pick) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame =  CGRectMake(self.ct_width - 13, 0, 13, 13);
    [self.deleteBtn setImage:[UIImage imageNamed:@"pickCancel"] forState:UIControlStateNormal];
    [self addSubview: self.deleteBtn];
    [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setModel:(KBFeedBackViewModel *)model
{
    self.feedbackmodel = model;
    
    if (self.feedbackmodel.mode == KBFeedBackModeNormal) {
        self.imageView.hidden = NO;
        self.deleteBtn.hidden = NO;
        self.addBtn.hidden = YES;
        self.imageView.image = model.image;
        //self.layer.borderColor  = KBCOLOR_WITH_HEX(0x666666).CGColor;
        self.layer.borderWidth = 0;
        
    }
    else if (self.feedbackmodel.mode == KBFeedBackModeAdd)
    {
        self.imageView.hidden = YES;
        self.deleteBtn.hidden = YES;
        self.addBtn.hidden = NO;
        self.layer.borderColor  = KBCOLOR_WITH_HEX(0x666666).CGColor;
        self.layer.borderWidth = 1;
    }
    
}

- (void)pick
{
    if (self.feedbackmodel.mode == KBFeedBackModeNormal) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pick)]) {
        [self.delegate pick];
    }
}

- (void)deleteAction
{
    if (self.feedbackmodel.mode == KBFeedBackModeAdd) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAction:)]) {
        [self.delegate deleteAction:self.feedbackmodel.index];
    }
}

@end
