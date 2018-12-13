//
//  NSObject+kbHelper.m
//  kbTest
//
//  Created by yuyang on 2018/1/3.
//  Copyright © 2018年 kbun. All rights reserved.
//

#import "NSObject+KBHelper.h"
#import "UINavigationController+KBHepler.h"
#import <objc/runtime.h>

@implementation NSObject (KBHelper)

- (UIViewController *)kb_currentController {
    UIViewController *rootViewController = [[UIApplication sharedApplication] keyWindow].rootViewController;
    return [self kb_getCurrentControllerFrom:rootViewController];
}

- (void)kb_pushVC:(UIViewController *)viewController  animated:(BOOL)animated
{
     [[self kb_currentController].navigationController kb_pushViewController:viewController animated:animated release:NO];
}
- (void)kb_presentVC:(UIViewController *)viewController  animated:(BOOL)animated
{
    [[self kb_currentController] presentViewController:viewController animated:animated completion:nil];
}

//push
- (void)kb_pushViewController:(NSString *)className  animated:(BOOL)animated
{
      [self setValueForClass:className withPropertyValue:nil selector:@""  navigation:YES animated:animated release:NO];
}
// present
- (void)kb_presentViewController:(NSString *)className  animated:(BOOL)animated
{
      [self setValueForClass:className withPropertyValue:nil selector:@""  navigation:NO animated:animated release:NO];
}

- (void)kb_presentViewController:(NSString *)className withPropertyValue:(NSDictionary *)pvDic animated:(BOOL)animated release:(BOOL)release
{
      [self setValueForClass:className withPropertyValue:pvDic selector:@""  navigation:NO animated:animated release:release];
}


- (void)kb_pushViewController:(NSString *)className withPropertyValue:(NSDictionary *)pvDic animated:(BOOL)animated release:(BOOL)release
{
     [self setValueForClass:className withPropertyValue:pvDic selector:@""  navigation:YES animated:animated release:release];
}


- (void)kb_pushViewController:(NSString *)className withPropertyValue:(NSDictionary *)pvDic selector:(NSString *)selector animated:(BOOL)animated release:(BOOL)release
{
    [self setValueForClass:className withPropertyValue:pvDic selector:selector  navigation:YES animated:animated release:release];
}


//跳转赋值方法
- (void)setValueForClass:(NSString *)className withPropertyValue:(NSDictionary *)pvDic selector:(NSString *)selector navigation:(BOOL)navigation animated:(BOOL)animated release:(BOOL)release{
    
    Class newClass = NSClassFromString(className);
    
    id instance = [[newClass alloc] init];
    
    [pvDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            [instance setValue:obj forKey:key];
        } else {
            NSLog(@"类 %@ 不包含 %@ 属性,传值失败,请检查是否拼写错误.", className, key);
        }
        
    }];
    
    if (selector.length > 0) {
        if ([instance respondsToSelector:NSSelectorFromString(selector)]) {
            [instance performSelector:(NSSelectorFromString(selector)) withObject:nil afterDelay:0];
        }
    }
    
    if (navigation) {
        
        [[self kb_currentController].navigationController kb_pushViewController:instance animated:animated release:release];
    } else {
        [[self kb_currentController] presentViewController:instance animated:animated completion:nil];
    }
    
    
}

//遍历是否存在属性
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    objc_property_t * properties = class_copyPropertyList([instance class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    
    free(properties);
    
    return NO;
}

- (UIViewController *)kb_getCurrentControllerFrom:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self kb_getCurrentControllerFrom:[((UINavigationController *) vc) visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self kb_getCurrentControllerFrom:[((UITabBarController *) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self kb_getCurrentControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

@end
