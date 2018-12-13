//
//  KBAttributedStringTool.h
//  test
//
//  Created by yuyang on 2018/6/11.
//  Copyright © 2018年 shareit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KBAttributedStringModel : NSObject
@property (nonatomic,copy)  NSString *text;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIColor *color;

+ (instancetype)initWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color;

@end
@interface KBAttributedStringTool : NSObject

+ (NSAttributedString *)conversionAttributedStringFromModelArray:(NSArray *)array;

@end
