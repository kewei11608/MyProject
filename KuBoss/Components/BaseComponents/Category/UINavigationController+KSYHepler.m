//
//  NSObject+kbHepler.m
//  kbTest
//
//  Created by yuyang on 2018/1/3.
//  Copyright © 2018年 kbun. All rights reserved.
//

#import "UINavigationController+KBHepler.h"

@implementation UINavigationController (KBHepler)


- (void)kb_pushViewController:(UIViewController *)viewController animated:(BOOL)animated release:(BOOL )release
{
    if (release) {
        
        NSMutableArray * viewControllers =[[NSMutableArray alloc]initWithArray:self.viewControllers];
        [viewControllers removeLastObject];
        [viewControllers addObject:viewController];
        [self setViewControllers:viewControllers animated:animated];
        
    } else {
        
        [self pushViewController:viewController animated:animated];
        
    }
}

- (void)kb_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
     [self pushViewController:viewController animated:animated];
}
@end
