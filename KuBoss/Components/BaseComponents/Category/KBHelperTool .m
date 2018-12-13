//
//  KSYHelperTool.m
//  KSYTest
//
//  Created by yuyang on 2018/1/5.
//  Copyright © 2018年 Ksyun. All rights reserved.
//

#import "KBHelperTool .h"

@implementation KBHelperTool 

+ (NSDictionary *)initWithFileName:(NSString *)fileName
                         extension:(NSString *)extension{
    NSString *strJSONPath =
    [[NSBundle mainBundle] pathForResource:fileName ofType:extension];
    NSDictionary *dict = [NSJSONSerialization
                          JSONObjectWithData:[NSData dataWithContentsOfFile:strJSONPath]
                          options:0
                          error:nil];
    
    return dict;
}

@end
