

#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)
#pragma mark - 中心点的约束
/**
 视图的中心点横坐标相对于依赖的视图view中心点横坐标距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint*)setAutoLayoutCenterXToViewCenterX:(UIView *)view constant:(CGFloat)constant;

/**
 视图的中心点纵坐标相对于依赖的视图view中心点纵坐标距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint*)setAutoLayoutCenterYToViewCenterY:(UIView *)view constant:(CGFloat)constant;

/**
 相对于依赖的视图view居中
 
 @param view 依赖的视图
 */
- (void)setAutoLayoutCenterToViewCenter:(UIView *)view;

#pragma mark - 顶部的约束
/**
 视图的顶部相对于依赖的视图view顶部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint*)setAutoLayoutTopToViewTop:(UIView *)view constant:(CGFloat)constant;

/**
 视图的顶部相对于依赖的视图view低部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint*)setAutoLayoutTopToViewBottom:(UIView *)view constant:(CGFloat)constant;

#pragma mark - 左边的约束
/**
 视图的左边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint*)setAutoLayoutLeftToViewLeft:(UIView *)view constant:(CGFloat)constant;


/**
 视图的左边相对于依赖的视图view右边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint*)setAutoLayoutLeftToViewRight:(UIView *)view constant:(CGFloat)constant;

#pragma mark - 低部的约束
/**
 视图的低部相对于依赖的视图view低部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint*)setAutoLayoutBottomToViewBottom:(UIView *)view constant:(CGFloat)constant;

/**
 视图的低部相对于依赖的视图view顶部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint*)setAutoLayoutBottomToViewTop:(UIView *)view constant:(CGFloat)constant;


#pragma mark - 右边的约束
/**
 视图的右边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint*)setAutoLayoutRightToViewLeft:(UIView *)view constant:(CGFloat)constant;


/**
 视图的右边相对于依赖的视图view右边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint*)setAutoLayoutRightToViewRight:(UIView *)view constant:(CGFloat)constant;


#pragma mark - 尺寸的约束
/**
 视图的宽度约束
 
 @param constant 宽度
 */
- (NSLayoutConstraint*)setAutoLayoutWidth:(CGFloat)constant;

/**
 视图的宽度约束
 
 @param view 依赖的视图
 @param constant 宽度
 */
- (NSLayoutConstraint*)setAutoLayoutWidthToView:(UIView *)view constant:(CGFloat)constant;


/**
 视图的高度约束
 
 @param constant 高度
 */
- (NSLayoutConstraint*)setAutoLayoutHeight:(CGFloat)constant;

/**
 视图的高度约束
 
 @param view 依赖的视图
 @param constant 高度
 */
- (NSLayoutConstraint*)setAutoLayoutHeightToView:(UIView *)view constant:(CGFloat)constant;

/**
 视图的大小约束
 
 @param size 尺寸
 */
- (void)setAutoLayoutSize:(CGSize)size;
@end
