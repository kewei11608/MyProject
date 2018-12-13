//
//  KBAgentCell.h
//  KuBoss
//
//  Created by yuyang on 2018/5/13.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBAgentCell : UITableViewCell

- (void)setModel:(KBBottomEDModel *)model;

@property (nonatomic, assign) BOOL isLast;

@end
