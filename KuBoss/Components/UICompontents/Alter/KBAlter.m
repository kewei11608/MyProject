//
//  KBAlter.m
//  KuBoss
//
//  Created by yuyang on 2018/5/12.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBAlter.h"
#import "MBProgressHUD.h"
@interface KBAlter ()
@property (nonatomic,strong) MBProgressHUD *hud;

@end
@implementation KBAlter

+ (void)show:(NSString *)text  superView:(UIView *)view
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    
    [view addSubview:hud];
    
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    
    hud.mode = MBProgressHUDModeText;
    
    [hud showAnimated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [MBProgressHUD hideHUDForView:view animated:YES];
          
    });
  
}

+ (void)showLoadingForView:(UIView *)view
{
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
   hud.label.text = @"加载中";
}

+ (void)hideLoadingForView:(UIView *)view;
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}
@end
