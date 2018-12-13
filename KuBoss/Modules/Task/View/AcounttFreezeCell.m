//
//  AcounttFreezeCell.m
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "AcounttFreezeCell.h"

@implementation AcounttFreezeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatarImg.layer.cornerRadius = 25;
    self.avatarImg.layer.masksToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
