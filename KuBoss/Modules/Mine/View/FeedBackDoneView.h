//
//  FeedBackDoneView.h
//  KuBoss
//
//  Created by yuyang on 2018/6/17.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^backActionBlock_t)(void);

@interface FeedBackDoneView : UIView
@property (nonatomic,copy)backActionBlock_t backActionBlock;
@end
