//
//  KBBannerView.m
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBannerView.h"
#import "SDCycleScrollView.h"
#import "KBWebViewController.h"

@interface KBBannerView ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)NSMutableArray *imagesURLStrings;
@property (nonatomic, strong) NSArray *array;

@end
@implementation KBBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    self.imagesURLStrings = [[NSMutableArray alloc]init];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)setupArray:(NSArray *)array
{
    self.array = array;
//    if (self.imagesURLStrings.count!=0) {
//        return;
//    }
    [self.imagesURLStrings removeAllObjects];
    [array enumerateObjectsUsingBlock:^(KBBottomBanerModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        [ self.imagesURLStrings addObject:model.imgurl];
    }];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[SDCycleScrollView class]]) {
            [view removeFromSuperview];
        }
    }
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:[UIImage imageNamed:@"banner_default"]];
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.autoScroll = YES;
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.autoScrollTimeInterval = 4;
     cycleScrollView.imageURLStringsGroup = self.imagesURLStrings;
    [self addSubview:cycleScrollView];
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.backgroundColor = [UIColor redColor];
    
}



#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    KBBottomBanerModel *model = self.array[index];
    if (model.redrectURL.length > 0) {
        UIViewController *vc = self.superview.superview.superview.nextResponder;
        KBWebViewController *wvc = [[KBWebViewController alloc] init];
        wvc.url = model.redrectURL;
        [vc.navigationController pushViewController:wvc animated:YES];
    }
    NSLog(@"%@", self.superview.superview.superview.nextResponder);
}

@end
