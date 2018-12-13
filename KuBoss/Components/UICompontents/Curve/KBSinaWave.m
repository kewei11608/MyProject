//
//  KBSinaWave.m
//  KBSinaWave
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBSinaWave.h"

#define    VIEW_WIDTH     self.bounds.size.width
#define    VIEW_HEIGHT    self.bounds.size.height

static  const float  kWaveDuration = 2 / 40.0f; // 周期
static  const float  kWaveYMax = 20.0f; // 振幅
static  const float  kWaveYOffset = 100.0f; //竖直方向上的偏移位置



@interface KBSinaWave ()
/**
 波浪层
 */
@property(nonatomic,weak)CAShapeLayer *waveLayer;

/**
 波浪在Y轴上的偏移
 */
@property(nonatomic,assign)CGFloat waveOffset;


@end
@implementation KBSinaWave

- (void)layoutSubviews{
    [super layoutSubviews];
    self.waveLayer.frame = self.bounds;
 
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawWaterWave];
}
// Asin(x*@ + offset) + C
- (void)drawWaterWave{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, VIEW_HEIGHT/2.0);
    for (int i = 0; i <= VIEW_WIDTH ; i++) {
        CGFloat y = kWaveYMax * sin(kWaveDuration*i+self.waveOffset) + kWaveYOffset;
        CGPathAddLineToPoint(path, NULL, i, y);
    }
    CGPathAddLineToPoint(path, NULL,VIEW_WIDTH, VIEW_HEIGHT);
    CGPathAddLineToPoint(path, NULL, 0, VIEW_HEIGHT);
    CGPathCloseSubpath(path);
    self.waveLayer.path = path;
    CGPathRelease(path);
}
- (CAShapeLayer *)waveLayer{
    if (_waveLayer == nil) {
        CAShapeLayer * shapeLayer = [CAShapeLayer layer];
        shapeLayer.fillColor = kMainColor.CGColor;
        shapeLayer.lineWidth = 1.0f;
        shapeLayer.strokeColor = KBCOLOR_WITH_HEX(0xCCCCCC).CGColor;
        [self.layer addSublayer:shapeLayer];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:250/255.0 green:170/255.0 blue:10/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.4].CGColor];
        
        gradientLayer.locations=@[@0.0,@1.0];
        gradientLayer.startPoint = CGPointMake(0.0,0.0);
        gradientLayer.endPoint = CGPointMake(0,1);
        shapeLayer.mask = gradientLayer;
        _waveLayer = shapeLayer;
        
        
    }
    return _waveLayer;
}

@end
