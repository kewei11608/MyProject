//
//  RoomDetailView.h
//  KuBoss
//
//  Created by yuyang on 2018/6/7.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FreezeDetailView.h"

@interface RoomDetailView : UIView
@property (weak, nonatomic) IBOutlet UITableView *tbView;
- (void)setArray:(NSArray *)array;
@end
