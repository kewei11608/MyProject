//
//  KSYError.h
//  KSYTest
//
//  Created by yuyang on 2018/1/5.
//  Copyright © 2018年 Ksyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBErrorHeader.h"

@interface KBError : NSObject

+ (NSError *)errorCode:(KSYDataFormatErrorCode)errorCode userInfo:(NSDictionary *)dic;

@end
