//
//  AccountRecodCell.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "AccountRecodCell.h"

@implementation AccountRecodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.avatarImg.layer.cornerRadius = self.avatarImg.ct_height/2;
    self.avatarImg.layer.masksToBounds = YES;
    // Initialization code
    self.bottomView.backgroundColor = KBCOLOR_WITH_HEX(0xd2d2d2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
