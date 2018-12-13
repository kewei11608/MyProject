//
//  KBWarReportRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBWarReportRequest.h"
@interface KBWarReportRequest ()
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger size;

@end
@implementation KBWarReportRequest

- (instancetype)initWithUserid:(NSString *)userid page:(NSInteger )page size:(NSInteger )size
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.page = page;
    self.size = size;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/slist/getsign";
}


- (id)baseRequestArgument
{
    return @{@"userid":self.uid,@"page":@(self.page),@"size":@(self.size)};
}

@end
