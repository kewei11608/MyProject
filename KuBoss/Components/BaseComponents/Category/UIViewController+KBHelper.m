//
//  UIViewController+KSYHelper.m
//  KSYTest
//
//  Created by yuyang on 2018/1/3.
//  Copyright © 2018年 Ksyun. All rights reserved.
//

#import "UIViewController+KBHelper.h"
#import <objc/runtime.h>

@implementation UIViewController (KBHelper)
static char kAssociatedParamsObjectKey;

- (void)setParams:(NSDictionary *)paramsDictionary
{
    objc_setAssociatedObject(self, &kAssociatedParamsObjectKey, paramsDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)params
{
    return objc_getAssociatedObject(self, &kAssociatedParamsObjectKey);
}

@end
