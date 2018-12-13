//
//Created by ESJsonFormatForMac on 18/05/10.
//

#import "KBUserInfoModel.h"
#import "RSA.h"

@implementation KBUserInfoModel
@synthesize data;

- (void)sava
{
    NSString * encWithPubKey = [RSA encryptString:[NSString stringWithFormat:@"%ld",(long)self.data.ID] publicKey:rsa_publick_key];
    [[NSUserDefaults standardUserDefaults] setObject:encWithPubKey forKey:@"KBID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.data.Fullname forKey:@"KBFullname"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.data.AreaCode forKey:@"areaCode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.data.Phone forKey:@"Phone"];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.data.userhead forKey:@"userhead"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) clear
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"KBID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)userName
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"KBFullname"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"KBFullname"];
    }
    return @"";
}

+ (NSString *)uid
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"KBID"]) {
        return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"KBID"]];
    }
    return @"";
}

+ (NSString *)encodeUid
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"KBID"]) {
        return [self encodeToPercentEscapeString: [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"KBID"]]];
    }
    return @"";
}

+ (NSString *)iphone
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Phone"]) {
        return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Phone"]];
    }
    return @"";
}

+ (NSString *)userhead
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userhead"]) {
        return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userhead"]];
    }
    return @"";
}

+ (NSString *)areaCode
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"areaCode"]) {
        return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"areaCode"]];
    }
    return @"";
}

+ (BOOL)isLogin
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"KBID"]) {
        return YES;
    }
    return  NO;
}

+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *outputStr = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)input,NULL,(CFStringRef)@"!*'();:@&=+ $,/?%#[]",kCFStringEncodingUTF8));
    return outputStr;
}

@end

@implementation KBMidUserInfoModel


@end


