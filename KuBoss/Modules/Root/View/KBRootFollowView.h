//
//  KBRootFollowView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/4.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickFollowBlock_t)();

@interface KBRootFollowView : UIView

@property (nonatomic,strong)clickFollowBlock_t clickBlock;

- (void)setFollowArray:(NSArray *)array;

@end
