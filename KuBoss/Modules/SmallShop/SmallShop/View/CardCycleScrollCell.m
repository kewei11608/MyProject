//
//  CardCycleScrollCell.m
//  KuBoss
//
//  Created by lidan on 2018/11/26.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import "CardCycleScrollCell.h"
#import "DCCycleScrollView.h"

@implementation CardCycleScrollCell
{
    
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imageArr=@[@"banner_default",@"banner_default"];
        [self initialize];
    }
    return self;
}

- (void)initialize {
    DCCycleScrollView *banner = [DCCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10, MSW, MSW/690*320) shouldInfiniteLoop:YES imageGroups:self.imageArr];
    //    banner.placeholderImage = [UIImage imageNamed:@"placeholderImage"];
    //    banner.cellPlaceholderImage = [UIImage imageNamed:@"placeholderImage"];
    banner.autoScrollTimeInterval = 3;
    banner.autoScroll = YES;
    banner.isZoom = YES;
    banner.itemSpace = 0;
    banner.imgCornerRadius = 10;
    banner.itemWidth = MSW -40;
    banner.delegate = self;
    //隐藏pageControl
    banner.pageControl.hidden = YES;
    self.banner = banner;
    [self addSubview:banner];
    
    //添加pageControl
//    [self setupPageControl];
}
//点击图片的代理
-(void)cycleScrollView:(DCCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    DLog(@"-=-=%@",[NSString stringWithFormat:@"第%ld张图片",index]);
}

-(void)setupPageControl
{
    self.pageControl.frame = CGRectMake(0, self.banner.bottom-30, MSW, 10);
    self.pageControl.numberOfPages = self.imageArr.count;
    self.pageControl.currentPage = 0;
    [self.banner addSubview:self.pageControl];
}
-(UIPageControl *)pageControl
{
    if(_pageControl == nil)
    {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}
#pragma mark cycleScrollView delegate
-(void)cycleScrollView:(DCCycleScrollView *)cycleScrollView currentPageIndex:(NSInteger)index
{
    //设置当前页
    self.pageControl.currentPage = index;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
