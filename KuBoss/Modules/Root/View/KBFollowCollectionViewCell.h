//
//  KBFollowCollectionViewCell.h
//  KuBoss
//
//  Created by yuyang on 2018/4/4.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBFollowCollectionViewCell : UICollectionViewCell
@property (nonatomic,assign)BOOL isFollowed;

- (void)setModel:(KBBottomIndicatorConcernModel *)model;

- (void)home;

@end
