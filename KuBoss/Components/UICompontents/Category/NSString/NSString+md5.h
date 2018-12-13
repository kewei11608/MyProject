//
//  NSString+md5.h
//  CiticMovie
//
//  Created by fuqiang on 12/9/13.
//  Copyright (c) 2013 fuqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (md5)

- (NSString *)md5;

- (NSString *)md5ForUTF16:(NSStringEncoding)encoding;

@end
