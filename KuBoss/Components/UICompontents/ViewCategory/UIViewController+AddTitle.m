//
//  UIViewController+AddTitle.m
//  KuBoss
//
//  Created by yuyang on 2018/5/19.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "UIViewController+AddTitle.h"
#define iOS10 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=10)
@implementation UIViewController (AddTitle)

- (void)setCustomTitle:(NSString *)title
{
    UILabel  * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth-200, 40)];
    lable.font = [UIFont systemFontOfSize:18];
    lable.textColor =KBCOLOR_WITH_HEX(0x333333);
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = title;
    self.navigationItem.titleView = lable;
    self.navigationController.navigationBar.tintColor = KBCOLOR_WITH_HEX(0x707070);
    self.navigationController.navigationBar.topItem.title = @"";
    //[[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
}

@end
