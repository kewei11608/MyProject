//
//  NSString+TextSize.h
//  Delegage_4_25_1
//
//  Created by ibokan on 16/4/25.
//  Copyright © 2016年 zhengshengxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (TextSize)

/**
 *  计算文本高度方法
 *
 *  @param w        要显示的控件的宽度
 *  @param fontsize 控件显示文本的字体大小
 *
 *  @return 返回计算的文本占用位置的高
 */
- (CGFloat)kb_HeightWithMaxWidth:(CGFloat)w FontSize:(CGFloat)fontsize;


/**
 *  计算文本宽度方法
 *
 *  @return 返回计算的文本占用位置的宽
 */
- (CGFloat)kb_WidthWithFontSize:(CGFloat)fontsize;

@end
