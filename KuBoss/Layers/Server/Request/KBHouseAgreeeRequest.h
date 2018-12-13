//
//  KBHouseAgreeeRequest.h
//  KuBoss
//
//  Created by yuyang on 2018/6/10.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBBaseRequest.h"

@interface KBHouseAgreeeRequest : KBBaseRequest

- (instancetype)initWithUserid:(NSString *)userid
                     approvaid:(NSString *)approvaid
                 completedmemo:(NSString *)completedmemo
                    sourcetype:(NSString *)sourcetype
                     tradetype:(NSString*)tradetype
                rentemployeeid:(NSString*)rentemployeeid
                saleemployeeid:(NSString*)saleemployeeid
                     rentprice:(NSString *)rentprice
                     saleprice:(NSString *)saleprice
               unitofrentprice:(NSString *)unitofrentprice
                 RentUnitPrice:(NSString *)RentUnitPrice
           UnitofRentUnitPrice:(NSString *)UnitofRentUnitPrice
                 SaleUnitPrice:(NSString *)SaleUnitPrice
              ConstructionArea:(NSString *)ConstructionArea;

@end
