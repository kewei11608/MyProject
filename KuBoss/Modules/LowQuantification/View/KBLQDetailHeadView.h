//
//  KBLQDetailHeadView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectdBlock_t)(NSInteger index);

@interface KBLQDetailHeadView : UIView

@property (nonatomic,copy) selectdBlock_t selectdBlock;

- (void)setModel:(KBLQDetailModel *)model;

@end
