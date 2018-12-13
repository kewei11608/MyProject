//
//  KBRootHeadView.h
//  KuBoss
//
//  Created by yuyang on 2018/4/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^moreBlock_t)();
typedef void (^rankBlock_t)();

typedef void (^clickTabBlock_t)(NSInteger tag);
typedef void (^clickFollowBlock_t)();

@interface KBRootHeadView : UIView

@property (nonatomic,copy)moreBlock_t moreBlock;
@property (nonatomic,copy)rankBlock_t rankBlock;
@property (nonatomic,copy)clickTabBlock_t clickTabBlock;
@property (nonatomic,copy)clickFollowBlock_t clickFollowBlock;

- (void)setupArray:(NSArray *)array;

- (void)setFollowArray:(NSArray *)array;

- (void)setNumber:(NSInteger) number;

- (void)updateView;
@end
