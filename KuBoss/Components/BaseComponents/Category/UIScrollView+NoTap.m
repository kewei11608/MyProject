//
//  UIScrollView+NoTap.m
//  KuBoss
//
//  Created by risenb_mac on 2018/6/26.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "UIScrollView+NoTap.h"

@implementation UIScrollView (NoTap)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event

{
    
    
    
    [self.superview touchesBegan:touches withEvent:event];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    
    [self.superview touchesEnded:touches withEvent:event];
    
}

@end
