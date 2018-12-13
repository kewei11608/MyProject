//
//  KBShareSuccessRequest.m
//  KuBoss
//
//  Created by risenb_mac on 2018/7/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBShareSuccessRequest.h"

@interface KBShareSuccessRequest ()

@property (nonatomic, copy) NSString *stationsID;

@end

@implementation KBShareSuccessRequest

- (instancetype)initWithStationsId:(NSString *)stationsID
{
    self = [super init];
    if (!self) return nil;
    self.stationsID = stationsID;
    return self;
}

- (NSString *)baseRequestUrl
{
    return @"/stations/updateShareVolume";
}

- (YTKRequestMethod)baseRequestMethod
{
    return YTKRequestMethodPOST;
}

- (id)baseRequestArgument
{
    
    return @{@"stationsId":self.stationsID};
}

@end
