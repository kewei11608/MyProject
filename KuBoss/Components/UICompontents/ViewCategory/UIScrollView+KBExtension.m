//
//  UIScrollView+KBExtension.m
//  KuBoss
//
//  Created by yuyang on 2018/6/14.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "UIScrollView+KBExtension.h"

@implementation UIScrollView (KBExtension)
+ (void)load {
    
    if (@available(iOS 11.0, *)){
        
        //[[self appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        
    }
//    else
//    {
//        [[self appearance]  setAutomaticallyAdjustsScrollViewInsets:false];
//    }
    
}
@end
