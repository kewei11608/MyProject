//
//  KBAttributedStringTool.m
//  test
//
//  Created by yuyang on 2018/6/11.
//  Copyright © 2018年 shareit. All rights reserved.
//

#import "KBAttributedStringTool.h"


@implementation KBAttributedStringModel

+ (instancetype)initWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color
{
    KBAttributedStringModel *model = [[KBAttributedStringModel alloc] init];
    model.text  = text;
    model.font  = font;
    model.color = color;
    return model;
}

@end

@implementation KBAttributedStringTool

+ (NSAttributedString *)conversionAttributedStringFromModelArray:(NSArray *)array
{
    NSInteger  locationStartIndex = 0;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] init];
    for (NSInteger i = 0 ; i<array.count; i++) {
        KBAttributedStringModel *model  = [array  objectAtIndex:i];
        [attributedStr appendAttributedString:[[NSAttributedString alloc] initWithString:model.text]];
        NSRange range = NSMakeRange(locationStartIndex, model.text.length);
        [attributedStr addAttribute:NSFontAttributeName value:model.font range:range];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:model.color range:range];
        locationStartIndex = model.text.length + locationStartIndex;
    }
    return attributedStr;
}

@end
