//
//  KBLQAgentView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBLQAgentView : UIView
@property (nonatomic,copy) tellBlock_t tellBlock;
@property (nonatomic,strong) UILabel  *sLab;
@property (nonatomic,strong) UILabel  *tLab;
- (void)setModel:(KBLQDetailModel *)model;

- (void)setItemModel:(KBLQItemModel *)model;
@end
