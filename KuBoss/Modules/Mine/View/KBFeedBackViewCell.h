//
//  KBFeedBackViewCell.h
//  KuBoss
//
//  Created by yuyang on 2018/5/19.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBFeedBackViewModel : NSObject
@property (nonatomic,strong)  UIImage *image;
@property (nonatomic,assign)  KBFeedBackMode mode;
@property (nonatomic,assign)  NSInteger index;
@end

@protocol FeedBackViewCellDelegate<NSObject>

- (void)pick;

- (void)deleteAction:(NSInteger) index;

@end

@interface KBFeedBackViewCell : UICollectionViewCell

@property (nonatomic,weak) id<FeedBackViewCellDelegate> delegate;

- (void)setModel:(KBFeedBackViewModel *)model;

@end
