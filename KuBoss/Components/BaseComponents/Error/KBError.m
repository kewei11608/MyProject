//
//  KSYError.m
//  KSYTest
//
//  Created by yuyang on 2018/1/5.
//  Copyright © 2018年 Ksyun. All rights reserved.
//

#import "KBError.h"

static NSDictionary *errorDictionary = nil;
@implementation KBError


+ (void)initialize
{
    if (self == [KBError class])
    {
     errorDictionary = \
        @{
          /* code        :        errorWithDomain */
          /* ==================================== */
          
          @(KSYDataFormatErrorCodeNoDic)       :        @"不是字典类型的指针",
          @(KSYDataFormatErrorCodeNoArray)  :        @"不是字典类型的指针",
          @(KSYDataFormatErrorCodeNoJson)      :        @"不是Json格式",
          
          /* ==================================== */
          };
    }
}
+ (NSError *)errorCode:(KSYDataFormatErrorCode)errorCode userInfo:(NSDictionary *)dic
{
    return [NSError errorWithDomain:kDataErrorDomain
                               code:errorCode
                           userInfo:dic];
}

@end
