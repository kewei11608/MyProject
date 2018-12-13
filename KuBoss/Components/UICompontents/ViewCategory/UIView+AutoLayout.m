
#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)
#pragma mark - 中心点的约束
/**
 视图的中心点横坐标相对于依赖的视图view中心点横坐标距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint *)setAutoLayoutCenterXToViewCenterX:(UIView *)view constant:(CGFloat)constant{
 
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintCenterX = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintCenterX];
    return  constraintCenterX;
}

/**
 视图的中心点纵坐标相对于依赖的视图view中心点纵坐标距相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint *)setAutoLayoutCenterYToViewCenterY:(UIView *)view constant:(CGFloat)constant{
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintCenterY = [NSLayoutConstraint constraintWithItem:self  attribute:NSLayoutAttributeCenterY   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintCenterY];
    return constraintCenterY;
    
}

/**
 相对于依赖的视图view居中
 
 @param view 依赖的视图
 */
- (void)setAutoLayoutCenterToViewCenter:(UIView *)view{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintCenterX = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeCenterX   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    
    
      NSLayoutConstraint * constraintCenterY = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeCenterY   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [self.superview addConstraints:@[constraintCenterX,constraintCenterY]];
    
}

#pragma mark - 顶部的约束
/**
 视图的顶部相对于依赖的视图view顶部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint *)setAutoLayoutTopToViewTop:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintTop = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeTop   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintTop];
    return constraintTop;
    
    
}

/**
 视图的顶部相对于依赖的视图view低部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint *)setAutoLayoutTopToViewBottom:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintBottom = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeTop   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintBottom];
    return constraintBottom;
}

#pragma mark - 左边的约束
/**
 视图的左边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint* )setAutoLayoutLeftToViewLeft:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintLeft = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintLeft];
    return constraintLeft;
}


/**
 视图的左边相对于依赖的视图view右边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint *)setAutoLayoutLeftToViewRight:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintRight = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintRight];
    return constraintRight;
    
}

#pragma mark - 低部的约束
/**
 视图的低部相对于依赖的视图view低部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint *)setAutoLayoutBottomToViewBottom:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintBottom = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeBottom   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintBottom];
    return constraintBottom;
}

/**
 视图的低部相对于依赖的视图view顶部相距constant
 
 @param view 依赖的视图
 @param constant 距离
 */
- (NSLayoutConstraint *)setAutoLayoutBottomToViewTop:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    //创建距中的约束
    NSLayoutConstraint * constraintBottom = [NSLayoutConstraint constraintWithItem:self   attribute:NSLayoutAttributeBottom   relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintBottom];
    return constraintBottom;
    
}


#pragma mark - 右边的约束
/**
 视图的右边相对于依赖的视图view左边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint *)setAutoLayoutRightToViewLeft:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintRight];
    return constraintRight;
}


/**
 视图的右边相对于依赖的视图view右边距相距constant
 
 @param view 依赖的视图
 @param constant 相对左边的距离
 */
- (NSLayoutConstraint *)setAutoLayoutRightToViewRight:(UIView *)view constant:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintRight];
    return constraintRight;
    
}


#pragma mark - 尺寸的约束
/**
 视图的宽度约束
 
 @param constant 宽度
 */
- (NSLayoutConstraint *)setAutoLayoutWidth:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintWidth];
    return constraintWidth;
}

/**
 视图的宽度约束
 
 @param view 依赖的视图
 @param constant 宽度
 */
- (NSLayoutConstraint *)setAutoLayoutWidthToView:(UIView *)view constant:(CGFloat)constant{
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintWidth];
    return constraintWidth;

}


/**
 视图的高度约束
 
 @param constant 高度
 */
- (NSLayoutConstraint *)setAutoLayoutHeight:(CGFloat)constant{
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintHeight];
    return constraintHeight;
}

/**
 视图的高度约束
 
 @param view 依赖的视图
 @param constant 高度
 */
- (NSLayoutConstraint*)setAutoLayoutHeightToView:(UIView *)view constant:(CGFloat)constant{
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:constant];
    
    [self.superview addConstraint:constraintHeight];
    return constraintHeight;

}

/**
 视图的大小约束
 
 @param size 尺寸
 */
- (void)setAutoLayoutSize:(CGSize)size{
    
    //使用代码布局 需要将这个属性设置为NO
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size.width];
    
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:size.height];
    
    [self.superview addConstraints:@[constraintWidth,constraintHeight]];
    
}
@end
