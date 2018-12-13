//
//  NSString+TKUtilities.h
//  TKContactsMultiPicker
//
//  Created by 종태 안 on 12. 5. 17..
//  Copyright (c) 2012년 Tabko Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

- (BOOL)containsString_NN:(NSString *)aString;

- (NSString*)telephoneWithReformat;

/**
 * 字典变字符串
 */
+(NSString *)stringFromdictioanry_nn:(NSDictionary *)dictionary;

/**
 * 数组变字符串
 */
+(NSString *)stringFromArray_nn:(NSArray *)array;

/**
 * 字符串 转 Json
 */
-(id)JSON_MD;

@end
