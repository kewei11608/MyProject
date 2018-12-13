//
//  UIView+CustomCorners.h
//  SnapShow_iOS
//
//  Created by yuyang on 2018/5/24.
//  Copyright © 2018年 Ushareit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CustomCorners)

-(void)bezierPathWithRoundedVieCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
- (void)allBezierPathWithRoundedView;
- (void)addGradientLayerFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;
@end
