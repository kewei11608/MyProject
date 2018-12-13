//
//  NSStringAdditions.h
//  PlanTo
//
//  Created by  zhang jian on 14-3-23.
//  Copyright (c) 2014年 DoubleCat. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 * Doxygen does not handle categories very well, so please refer to the .m file in general
 * for the documentation that is reflected on api.three20.info.
 */
@interface NSString (Additions)

+ (NSString*)md5HexDigest:(NSString*)input;

+ (NSString *)generateGuid;
/**
 * Determines if the string contains only whitespace and newlines.
 */
- (BOOL)isWhitespaceAndNewlines;

/**
 * Determines if the string is empty or contains only whitespace.
 */
- (BOOL)isEmptyOrWhitespace;

/**
 * Parses a URL query string into a dictionary.
 */
- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding;

/**
 * Parses a URL, adds query parameters to its query, and re-encodes it as a new URL.
 */
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query;

/**
 * Compares two strings expressing software versions.
 *
 * The comparison is (except for the development version provisions noted below) lexicographic
 * string comparison. So as long as the strings being compared use consistent version formats,
 * a variety of schemes are supported. For example "3.02" < "3.03" and "3.0.2" < "3.0.3". If you
 * mix such schemes, like trying to compare "3.02" and "3.0.3", the result may not be what you
 * expect.
 *
 * Development versions are also supported by adding an "a" character and more version info after
 * it. For example "3.0a1" or "3.01a4". The way these are handled is as follows: if the parts
 * before the "a" are different, the parts after the "a" are ignored. If the parts before the "a"
 * are identical, the result of the comparison is the result of NUMERICALLY comparing the parts
 * after the "a". If the part after the "a" is empty, it is treated as if it were "0". If one
 * string has an "a" and the other does not (e.g. "3.0" and "3.0a1") the one without the "a"
 * is newer.
 *
 * Examples (?? means undefined):
 *   "3.0" = "3.0"
 *   "3.0a2" = "3.0a2"
 *   "3.0" > "2.5"
 *   "3.1" > "3.0"
 *   "3.0a1" < "3.0"
 *   "3.0a1" < "3.0a4"
 *   "3.0a2" < "3.0a19"  <-- numeric, not lexicographic
 *   "3.0a" < "3.0a1"
 *   "3.02" < "3.03"
 *   "3.0.2" < "3.0.3"
 *   "3.00" ?? "3.0"
 *   "3.02" ?? "3.0.3"
 *   "3.02" ?? "3.0.2"
 */
- (NSComparisonResult)versionStringCompare:(NSString *)other;



- (CGSize)heightWithFont:(UIFont*)withFont 
                    width:(float)width 
                linebreak:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthWithFont:(UIFont *)font;

- (CGFloat)heightWithFont:(UIFont *)font MaxW:(CGFloat)maxW;

/**
 * Calculate the md5 hash of this string using CC_MD5.
 *
 * @return md5 hash of this string
 */
@property (nonatomic, readonly) NSString* md5Hash;


- (NSString *)replacedWhiteSpacsByString:(NSString *)replaceString;


- (NSString *)trim;

- (NSString *)formatJSON;

- (BOOL)eq:(NSString *)str;

- (NSArray *)allURLs;

- (NSString *)urlByAppendingDict:(NSDictionary *)params;
- (NSString *)urlByAppendingArray:(NSArray *)params;
- (NSString *)urlByAppendingKeyValues:(id)first, ...;

- (NSString *)queryStringFromDictionary:(NSDictionary *)dict;
- (NSString *)queryStringFromArray:(NSArray *)array;
- (NSString *)queryStringFromKeyValues:(id)first, ...;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;

- (NSString *)URLEvalutionEncoding;

- (NSString *)queryStringNoEncodeFromDictionary:(NSDictionary *)dict;
- (BOOL)empty;
- (BOOL)notEmpty;


- (BOOL)isValueOf:(NSArray *)array;
- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;

/**
 *  判断是否包含字符串（适配iOS7）
 *
 *  @param aString 包含的字符串
 *
 *  @return 是否包含
 *  Added by liwenzhi
 */
- (BOOL)myContainsString:(NSString *)aString;

/**
 截取时间戳 只保留年月日
 
 @return <#return value description#>
 */
- (NSString *)cutDateString;

/**
 替换时间戳 把T . + 等乱七八糟的删除 保留年月日 时分秒
 
 @return <#return value description#>
 */
- (NSString *)replaceDateString;


@end
