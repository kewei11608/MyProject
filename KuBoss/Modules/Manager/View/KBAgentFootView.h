//
//  KBAgentFootView.h
//  KuBoss
//
//  Created by yuyang on 2018/5/13.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clickDetailBlock_t)();
@interface KBAgentFootView : UIView
@property (nonatomic,copy)clickDetailBlock_t clickDetailBlock;
- (void)setModel:(KBMidLQModel *)model;

@end
