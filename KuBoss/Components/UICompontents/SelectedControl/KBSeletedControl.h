//
//  KBSeletedControl.h
//  KuBoss
//
//  Created by yuyang on 2018/4/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectedIndexBlock_t)(UIButton * btn);

@interface KBSeletedControl : UIView

@property (nonatomic,copy) selectedIndexBlock_t selectedIndexBlock;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)array;

- (void)setSelectedIndex:(NSInteger)index;

@end
