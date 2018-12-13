//
//  KBLQHeadView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/11.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^loadMoreBlock_t)();

@interface KBLQHeadView : UIView
@property (nonatomic,copy)loadMoreBlock_t loadMoreBlock;

@end
