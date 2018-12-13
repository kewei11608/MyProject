//
//  NSString+TKUtilities.m
//  TKContactsMultiPicker
//
//  Created by Jongtae Ahn on 12. 8. 31..
//  Copyright (c) 2012년 TABKO Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "NSString+Category.h"

@implementation NSString (Category)

- (BOOL)containsString_NN:(NSString *)aString
{
	NSRange range = [self rangeOfString:aString];
    
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
	return NO;
}



- (NSString*)telephoneWithReformat
{
    NSString * str = self;
    
    if ([str containsString_NN:@"-"])
    {
        
        str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    if ([str containsString_NN:@" "])
    {
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    if ([str containsString_NN:@"("])
    {
        str = [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
    }
    
    if ([str containsString_NN:@")"])
    {
        str = [str stringByReplacingOccurrencesOfString:@")" withString:@""];
    }
    
    if ([str containsString_NN:@"+86"])
    {
        str = [str stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    }
    
    return str;
}



- (BOOL)containsString_NN__NN:(NSString *)aString
{
    NSRange range = [[self lowercaseString] rangeOfString:[aString lowercaseString]]; // 不区分大小写
    
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    return NO;
}



+(NSString *)stringFromArray_nn:(NSArray *)array
{
    NSData * data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

+(NSString *)stringFromdictioanry_nn:(NSDictionary *)dictionary
{
    NSData * data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

-(id)JSON_MD
{
    NSData *  data = [self dataUsingEncoding:NSUTF8StringEncoding];

    id  dic = nil;
    NSError *error = nil;
    
    if (data) {
        if ([data length] > 0) {
            dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error)
            {
                NSLog(@" 解析json错误 %@",[error description]);
            }
        }
    }
    return dic;
}
@end
