//
//  UIView+Shadow.m
//  KuBoss
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

- (void)shadow
{
    self.layer.shadowColor = KBCOLOR_WITH_HEX(0X999999).CGColor;

    self.layer.shadowOpacity = 0.6f;

    self.layer.shadowRadius = 3.0f;
    
    self.layer.shadowOffset = CGSizeMake(0,3);
    

}
@end
