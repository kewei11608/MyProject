//
//  CardCycleScrollCell.h
//  KuBoss
//
//  Created by lidan on 2018/11/26.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCCycleScrollView.h"
NS_ASSUME_NONNULL_BEGIN
@interface CardCycleScrollCell : UITableViewCell<DCCycleScrollViewDelegate>
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) DCCycleScrollView *banner;
@property (nonatomic,strong) NSArray *imageArr;
@end

NS_ASSUME_NONNULL_END
