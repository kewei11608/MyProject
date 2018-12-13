//
//  UIImage+Addition.h
//  AntGroupBuy
//
//  Created by 健 张 on 14-7-14.
//  Copyright (c) 2014年 AntGroupBuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

@property (nonatomic, strong) NSString          *title;

+ (UIImage *)imageWithColor: (UIColor *) color imageSize:(CGSize)imageSize;
//将图片裁剪成圆形
+ (UIImage *)circleImage:(UIImage *)image withParam:(CGFloat)inset;
//将图片裁剪成指定大小
- (UIImage *)resizedImage:(CGSize)size imageOrientation:(UIImageOrientation)imageOrientation;

//图片缩放
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

//view 转 image
+ (UIImage *)imageFromView:(UIView *)orgView;

//图片裁剪
+ (UIImage *)cutImageFromImage:(UIImage *)image inRect:(CGRect)rect;

//切图拉伸
+ (UIImage *)imageResizableWithName:(NSString *)imageName;

//模糊效果
- (UIImage *)boxblurImageWithBlur:(CGFloat)blur;

#pragma mark - 压缩图片
+ (UIImage *)getJPEGImagerImg:(UIImage *)image;

+ (NSArray *)getJPEGImagerImgArr:(NSArray *)imageArr;

+ (UIImage *)getJPEGImagerImg:(UIImage *)image compressibilityFactor:(CGFloat)compressibilityFactor;

+ (NSArray *)getJPEGImagerImgArr:(NSArray *)imageArr compressibilityFactor:(CGFloat)compressibilityFactor;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

//剪裁
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;
@end
