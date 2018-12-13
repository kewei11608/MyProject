//
//  KBProcessView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBProcessView : UIView


- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)array;

- (void)setModifyIphoneState:(KBModifyIphoneState ) modifyIphoneState;

- (void)setModifyPasswordState:(KBModifyPasswordState ) passwordState;

@end
