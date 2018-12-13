//
//  KBJPushRegistRequest.m
//  KuBoss
//
//  Created by risenb_mac on 2018/6/27.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBJPushRegistRequest.h"

@interface KBJPushRegistRequest()

@property (nonatomic, copy) NSString *registID;

@end

@implementation KBJPushRegistRequest

- (instancetype)initWithUserid:(NSString *)userid
                      registID:(NSString *)registID
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.registID = registID;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/jpush/cr";
}

- (YTKRequestMethod)baseRequestMethod
{
    return YTKRequestMethodPOST;
}

- (id)baseRequestArgument
{
    
    return @{@"RegisteredId":self.registID,
             @"userId":self.uid};
}

@end
