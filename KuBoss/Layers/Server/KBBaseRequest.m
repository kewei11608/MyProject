//
//  WHBaseRequest.m
//  Pods
//
//  Created by yuyang on 2018/5/2.
//

#import "KBBaseRequest.h"
#import "AFURLRequestSerialization.h"
#import "YTKNetworkConfig.h"
@interface KBBaseRequest ()

@property (nonatomic,strong) NSMutableDictionary *headerParam;
@property (nonatomic, copy) NSString *noticetype;

@end
@implementation KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid
{
    self = [super init];
    if (!self) return nil;
    self.uid = userid;
    self.headerParam = [[NSMutableDictionary alloc]init];
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    self.uid = @"";
    return self;
}

- (NSString *)requestUrl {
    return [NSString stringWithFormat:@"%@%@",httpFilePath,[self baseRequestUrl]];
}


- (YTKRequestMethod)requestMethod {
    return [self baseRequestMethod];
}

-(YTKRequestSerializerType)requestSerializerType{
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return [self baseRequestArgument];
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
   // [self.headerParam setObject:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
//    [self.headerParam setObject:self.uid forKey:@"userid"];
    [self.headerParam setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"uuid"];
    [self.headerParam setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"version"];
    [self.headerParam setObject:[self nowTimeTimestamp] forKey:@"sendTime"];
    // to do 认证参数
    return self.headerParam;
    return  nil;
}


- (NSString *)nowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}


#pragma mark public

- (id)baseRequestArgument
{
    return  nil;
}

- (NSString *)baseRequestUrl{
    
    return nil;
}

- (YTKRequestMethod)baseRequestMethod
{
    return YTKRequestMethodPOST;
}

@end
