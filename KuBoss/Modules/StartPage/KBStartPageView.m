//
//  KBStartPageView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBStartPageView.h"
#import "SDCycleScrollView.h"
@interface KBStartPageView ()<SDCycleScrollViewDelegate>

@end
@implementation KBStartPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"StartPage1.jpg",
                            @"StartPage2.jpg",
                            @"StartPage3.jpg",
                            @"StartPage4.jpg",
                            ];
    if (SCREEN_HEIGHT > 800) {
        imageNames = @[@"StartPage1_iPhoneX", @"StartPage2_iPhoneX", @"StartPage3_iPhoneX", @"StartPage4_iPhoneX"];
    }
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.frame shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    cycleScrollView.autoScroll = NO;
    cycleScrollView.infiniteLoop = NO;
    [self addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.backgroundColor = [UIColor redColor];
    
    
}

- (void)remove
{
    [self removeFromSuperview];
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    if (index==3) {
        [self remove];
    }
    
}








@end
