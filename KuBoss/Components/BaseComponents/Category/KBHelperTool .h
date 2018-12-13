//
//  KSYHelperTool.h
//  KSYTest
//
//  Created by yuyang on 2018/1/5.
//  Copyright © 2018年 Ksyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBHelperTool  : NSObject

// json 转化字典
+ (NSDictionary *)initWithFileName:(NSString *)fileName
                         extension:(NSString *)extension;

@end
