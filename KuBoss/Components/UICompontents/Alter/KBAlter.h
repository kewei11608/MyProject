//
//  KBAlter.h
//  KuBoss
//
//  Created by yuyang on 2018/5/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBAlter : NSObject


+ (void)show:(NSString *)text  superView:(UIView *)view;

+ (void)showLoadingForView:(UIView *)view;

+ (void)hideLoadingForView:(UIView *)view;

@end
