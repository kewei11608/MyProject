//
//  DropSelectView.h
//  KuBoss
//
//  Created by lidan on 2018/11/26.
//  Copyright © 2018 yuyang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DropSelectView : UIView
@property (nonatomic, copy) void(^hiddenFilterview)();
@property (nonatomic, copy) void(^ dropselectindex)(int index);

@property (nonatomic, strong)NSArray *dataarray;
/** 未选中颜色 */
@property (nonatomic, strong) UIColor *normalColor;
/** 选中颜色 */
@property (nonatomic, strong) UIColor *selectColor;
/** 轮播文字label字体大小 */
@property (nonatomic, strong) UIFont  *TextFont;

-(id)initWithFrame:(CGRect)frame anddata:(NSArray*)array;



/**
 *   显示列表
 */
-(void)showView;
/**
 *   隐藏
 */
-(void)hiddenView;
@end

NS_ASSUME_NONNULL_END
