//
//  ImageSize.h
//  yyxb
//
//  Created by lili on 16/3/21.
//  Copyright © 2016年 王可伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageSize : NSObject
+(CGSize)getImageSizeWithURL:(id)imageURL;

+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request;
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request;
@end
