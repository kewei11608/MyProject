//
//  UIView+CustomCorners.m
//  SnapShow_iOS
//
//  Created by yuyang on 2018/5/24.
//  Copyright © 2018年 Ushareit. All rights reserved.
//

#import "UIView+CustomCorners.h"

@implementation UIView (CustomCorners)

-(void)bezierPathWithRoundedVieCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii
{
    UIBezierPath *    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)allBezierPathWithRoundedView
{
    [self bezierPathWithRoundedVieCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.ct_height/2,self.ct_height/2)];
}

- (void)addGradientLayerFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor, (__bridge id)toColor.CGColor];
    gradientLayer.locations = @[@0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, self.ct_width, self.ct_height);
    [self.layer addSublayer:gradientLayer];
}


@end
