//
//  NSObject+kbHelper.h
//  kbTest
//
//  Created by yuyang on 2018/1/3.
//  Copyright © 2018年 kbun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (KBHelper)

/**
 *
 *  获取当前的视图控制器
 *
 *  @return 返回当前的视图控制器
 */
- (UIViewController *)kb_currentController;


/**
 *
 *  present  模态视图
 *
 *  @param viewController 控制器
 *  @param animated  动画
 */
- (void)kb_pushVC:(UIViewController *)viewController  animated:(BOOL)animated;

/**
 *
 *  present  模态视图
 *
 *  @param viewController 控制器
 *  @param animated  动画
 */
- (void)kb_presentVC:(UIViewController *)viewController  animated:(BOOL)animated;

/**
 *
 *  push
 *
 *  @param className 类名,字符串形式
 *  @param animated  动画
 */
- (void)kb_pushViewController:(NSString *)className  animated:(BOOL)animated;
/**
 *
 *  present  模态视图
 *
 *  @param className 类名,字符串形式
 *  @param animated  动画
 */
- (void)kb_presentViewController:(NSString *)className  animated:(BOOL)animated;

/**
 *
 *  普通跳转
 *
 *  @param className 类名,字符串形式
 *  @param pvDic     需要传入的数据,以字典形式保存
 *  @param animated  动画
 *  @param release   是否需要释放
 */
- (void)kb_presentViewController:(NSString *)className withPropertyValue:(NSDictionary *)pvDic animated:(BOOL)animated release:(BOOL)release;

/**
 *
 *  导航跳转
 *
 *  @param className 类名,字符串形式
 *  @param pvDic     需要传入的数据,以字典形式保存
 *  @param animated  动画
 *  @param release   是否需要释放
 */
- (void)kb_pushViewController:(NSString *)className withPropertyValue:(NSDictionary *)pvDic animated:(BOOL)animated release:(BOOL)release;

/**
 *
 *  导航跳转
 *
 *  @param className 类名,字符串形式
 *  @param pvDic     需要传入的数据,以字典形式保存
 *  @param animated  动画
 *  @param release   是否需要释放
 */



- (void)kb_pushViewController:(NSString *)className withPropertyValue:(NSDictionary *)pvDic selector:(NSString *)selector animated:(BOOL)animated release:(BOOL)release;

@end
