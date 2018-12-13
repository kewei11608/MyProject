//
//  KSYErrorHeader.h
//  KSYTest
//
//  Created by yuyang on 2018/1/5.
//  Copyright © 2018年 Ksyun. All rights reserved.
//

#ifndef KBErrorHeader_h
#define KBErrorHeader_h

#define kDataErrorDomain   @"com.kb.error"
typedef enum {
    
    KSYDataFormatErrorCodeNoDic = -2000, // 数据不属于字典的类
    
    KSYDataFormatErrorCodeNoArray, // 数据不属于数组的类
    
    KSYDataFormatErrorCodeNoString, // 数据不属于字符串的类
    
    KSYDataFormatErrorCodeNoJson, // 不是json格式
    
    KSYDataFormatErrorCodeNoKeyData,// 请求回来字典里面不包含data 字段
    
    KSYDataFormatErrorCodeModelConversionError // 字典转模型发生错误
    
}KSYDataFormatErrorCode;



#endif /* KSYErrorHeader_h */
