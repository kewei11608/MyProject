//
//  KBLQSettingViewCell.h
//  KuBoss
//
//  Created by yuyang on 2018/6/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^enableBlock_t)(BOOL isOn);

@interface KBLQSettingViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *bottomLeftLable;
@property (nonatomic,strong) UISwitch *switchView;
@property (nonatomic,copy)  enableBlock_t  enableBlock;
@end
