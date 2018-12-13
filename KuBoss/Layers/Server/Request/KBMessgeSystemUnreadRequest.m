//
//  KBMessgeSystemUnreadRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/6/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//
//areaCode=1&userId=1
#import "KBMessgeSystemUnreadRequest.h"
@interface KBMessgeSystemUnreadRequest ()
@property (nonatomic,assign) NSInteger areaCode;

@end

@implementation KBMessgeSystemUnreadRequest
- (instancetype)initWithUserid:(NSString *)userid
                      areaCode:(NSInteger) code
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.areaCode = code;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/announcements/unread";
}

- (YTKRequestMethod)baseRequestMethod
{
    return YTKRequestMethodGET;
}

- (id)baseRequestArgument
{

    return @{@"areaCode":[KBUserInfoModel areaCode] ,
             @"userId":self.uid
             };
}

@end
