//
//  KBRootItemView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/4.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRootItemView.h"
#import "KBHeader.h"
#import "WZLBadgeImport.h"
@interface KBRootItemView ()

@end
@implementation KBRootItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)  return nil;
    self.backgroundColor = [UIColor whiteColor];
    [self setup];
    return self;
}

- (void)setup
{
    for (int i = 0 ; i < 4 ; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 25 ,50, 80)];
        view.tag  = i;
        [self addSubview:view];
//        if (i==3) {
//            view.ct_centerX = self.ct_width*(0.83);
//        }
//        else
//        {
//        view.ct_centerX = self.ct_width*(0.17+i*0.33);

            view.ct_centerX = self.ct_width*(0.125+i*0.25);
//        }
        
        UIImageView *imageView =[[UIImageView  alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
       
        [view addSubview:imageView];
        imageView.tag = 500+i;
        
//        UILabel *infolable = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.ct_width-30, 30, 15)];
//        [infolable sizeToFit];
//        infolable.font = [UIFont  systemFontOfSize:12];
//        infolable.backgroundColor = [UIColor redColor];
//        infolable.layer.masksToBounds = YES;
//        infolable.layer.cornerRadius = 5;
//        infolable.textColor = [UIColor whiteColor];
//        infolable.tag = 100;
//        [imageView addSubview:infolable];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.ct_bottom+6, 100, 15)];
        lable.font = [UIFont  systemFontOfSize:14];
        lable.textColor = KBCOLOR_WITH_HEX(0x333333);
        [view addSubview:lable];
        
        if (i == 0) {
            imageView.image = [UIImage imageNamed:@"item_modules"];
            lable.text = @"业务数据";
        }
        else if (i == 1) {
            lable.frame=CGRectMake(-10, imageView.ct_bottom+6, 100, 15);
            imageView.image = [UIImage imageNamed:@"item_lows"];
            lable.text = @"低量化预警";
        }
        else if (i == 2) {
            imageView.image = [UIImage imageNamed:@"item_tasks"];
            lable.text = @"任务审批";
        }
        else if (i == 3) {
            imageView.image = [UIImage imageNamed:@"item_weidian"];
            lable.text = @"门店微店";
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];

    }
    
}

- (void)setNumber:(NSInteger) number
{
    UIImageView *imageView = [self viewWithTag:502];
    if (imageView) {
        [imageView showBadgeWithStyle:WBadgeStyleNumber value:number animationType:WBadgeAnimTypeNone];
    }
}

- (void)click:(UITapGestureRecognizer *)tap
{
    if (self.clickTabBlock) {
        self.clickTabBlock(tap.view.tag);
    }
}

@end
