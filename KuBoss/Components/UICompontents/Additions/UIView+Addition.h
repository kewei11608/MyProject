//
//  UIView+Addition.h
//  AntGroupBuy
//
//  Created by 健 张 on 14-7-14.
//  Copyright (c) 2014年 AntGroupBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

/**
 *  左边距
 */
@property(nonatomic) CGFloat left;

/**
 *  上边距
 */
@property(nonatomic) CGFloat top;

/**
 *  右边距
 */
@property(nonatomic) CGFloat right;

/**
 *  下边距
 */
@property(nonatomic) CGFloat bottom;

/**
 *  宽度
 */
@property(nonatomic) CGFloat width;

/**
 *  高度
 */
@property(nonatomic) CGFloat height;

/**
 *  中心点x值
 */
@property(nonatomic) CGFloat centerX;

/**
 *  中心点y值
 */
@property(nonatomic) CGFloat centerY;

/**
 *  原点
 */
@property(nonatomic) CGPoint origin;

/**
 *  大小
 */
@property(nonatomic) CGSize size;

/**
 *  设置原点y值
 *
 *  @param originY y值
 */
- (void)setOriginY:(CGFloat)originY;

/**
 *  设置原点X值
 *
 *  @param originx x值
 */
- (void)setOriginX:(CGFloat)originX;

/**
 *  移除所有子视图
 */
- (void)removeAllSubviews;

/**
 *  移除子视图
 *
 *  @param  子视图
 */
- (void)removeSubview:(UIView *)view;

@end
