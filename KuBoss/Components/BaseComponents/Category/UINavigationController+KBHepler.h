//
//  NSObject+kbHepler.h
//  kbTest
//
//  Created by yuyang on 2018/1/3.
//  Copyright © 2018年 kbun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UINavigationController (KBHepler)

/**
 *
 *  导航跳转
 *
 *  @param viewController 跳转目标控制器
 *  @param animated       动画
 *  @param release        是否释放
 */
- (void)kb_pushViewController:(UIViewController *)viewController animated:(BOOL)animated release:(BOOL )release;

/**
 *
 *  导航跳转
 *
 *  @param viewController 跳转目标控制器
 *  @param animated       动画
 */
- (void)kb_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end
