//
//  AccountRecodCell.h
//  KuBoss
//
//  Created by yuyang on 2018/5/25.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountRecodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *startLable;
@property (weak, nonatomic) IBOutlet UILabel *freezeLable;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end
