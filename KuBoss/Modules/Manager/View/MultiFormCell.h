//
//  MultiFormCell.h
//  Demo
//
//  Created by yuyang on 2018/5/21.
//  Copyright © 2018年 shareit. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *tapCellScrollNotification = @"tapCellScrollNotification";
@interface MultiFormCell : UITableViewCell <UIScrollViewDelegate>



- (void)setArrayTitle:(NSArray *)array;

- (void)scrollViewX:(CGFloat) x;

@end
