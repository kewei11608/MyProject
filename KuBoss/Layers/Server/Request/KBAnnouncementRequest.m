//
//  KBAnnouncementRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/6/2.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBAnnouncementRequest.h"
@interface KBAnnouncementRequest ()
@property (nonatomic,assign) NSInteger  pageIndex;
@property (nonatomic,assign) NSInteger  pageSize;
@property (nonatomic,copy)   NSString *  areaCode;

@end
@implementation KBAnnouncementRequest

- (instancetype)initWithUserid:(NSString *)userid
                      areaCode:(NSString *)areaCode
                     pageIndex:(NSInteger) pageIndex
                      pageSize:(NSInteger)pageSize
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.pageIndex = pageIndex;
    self.pageSize  = pageSize;
    self.areaCode = areaCode;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/announcements";
}

- (YTKRequestMethod)baseRequestMethod
{

    return YTKRequestMethodGET;
}

- (id)baseRequestArgument
{
    
    return @{@"areaCode":[KBUserInfoModel areaCode] ,
             @"pageIndex":@(self.pageIndex),
             @"pageSize":@(self.pageSize),
             @"userId":self.uid
             };
}

@end
