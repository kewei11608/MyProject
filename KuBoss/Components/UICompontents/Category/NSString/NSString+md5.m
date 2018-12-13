//
//  NSString+md5.m
//  CiticMovie
//
//  Created by fuqiang on 12/9/13.
//  Copyright (c) 2013 fuqiang. All rights reserved.
//

#import "NSString+md5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (md5)

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];

    CC_LONG strlong = (CC_LONG)strlen(cStr);
    CC_MD5(cStr, strlong, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];

}

- (NSString *)md5ForUTF16:(NSStringEncoding)encoding
{
    NSData *temp = [self dataUsingEncoding:encoding];
    
    UInt8 *cStr = (UInt8 *)[temp bytes];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)[temp length], result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

@end
