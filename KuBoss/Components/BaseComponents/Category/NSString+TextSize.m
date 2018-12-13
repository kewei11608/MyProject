//
//  NSString+TextSize.m
//  Delegage_4_25_1
//
//  Created by ibokan on 16/4/25.
//  Copyright © 2016年 zhengshengxi. All rights reserved.
//

#import "NSString+TextSize.h"

@implementation NSString (TextSize)

- (CGFloat)kb_HeightWithMaxWidth:(CGFloat)w FontSize:(CGFloat)fontsize
{
    CGSize size=[self boundingRectWithSize:CGSizeMake(w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil].size;
    return size.height;
}

- (CGFloat)kb_WidthWithFontSize:(CGFloat)fontsize
{
    CGSize size=[self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil].size;
    return size.width;
}

@end
