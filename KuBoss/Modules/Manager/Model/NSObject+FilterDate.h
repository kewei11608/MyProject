//
//  NSObject+FilterDate.h
//  KuBoss
//
//  Created by yuyang on 2018/6/14.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FilterDate)
- (NSString *)getInitData;
- (NSString *)getDateModeString:(NSInteger) index;
- (NSString *)getPreDay:(NSInteger )index;
- (NSMutableAttributedString *)setTitleName:(NSString *)imageName  string:(NSString *)string;

- (NSString *)getMonth:(NSInteger )index  format:(NSString *)format;

- (NSMutableAttributedString *)getArrow:(NSString *)text;

@end
