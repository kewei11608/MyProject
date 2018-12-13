//
//  KBHouseAgreeeRequest.m
//  KuBoss
//
//  Created by yuyang on 2018/6/10.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBHouseAgreeeRequest.h"
@interface KBHouseAgreeeRequest ()
@property (nonatomic,copy) NSString *approvaid;
@property (nonatomic,copy) NSString *completedmemo;
@property (nonatomic,copy) NSString *sourcetype;
@property (nonatomic,copy) NSString *tradetype;
@property (nonatomic,copy) NSString *rentemployeeid;
@property (nonatomic,copy) NSString *saleemployeeid;
@property (nonatomic,copy) NSString *rentprice;
@property (nonatomic,copy) NSString *saleprice;
@property (nonatomic,copy) NSString *unitofrentprice;
@property (nonatomic, copy) NSString *RentUnitPrice;
@property (nonatomic, copy) NSString *UnitofRentUnitPrice;
@property (nonatomic, copy) NSString *SaleUnitPrice;
@property (nonatomic, copy) NSString *ConstructionArea;
@end

@implementation KBHouseAgreeeRequest

- (instancetype)initWithUserid:(NSString *)userid
                     approvaid:(NSString *)approvaid
                 completedmemo:(NSString *)completedmemo
                    sourcetype:(NSString *)sourcetype
                     tradetype:(NSString *)tradetype
                rentemployeeid:(NSString *)rentemployeeid
                saleemployeeid:(NSString *)saleemployeeid
                     rentprice:(NSString *)rentprice
                     saleprice:(NSString *)saleprice
               unitofrentprice:(NSString *)unitofrentprice
                 RentUnitPrice:(NSString *)RentUnitPrice
           UnitofRentUnitPrice:(NSString *)UnitofRentUnitPrice
                 SaleUnitPrice:(NSString *)SaleUnitPrice
              ConstructionArea:(NSString *)ConstructionArea
{
    self = [super initWithUserid:userid];
    if (!self) return nil;
    self.approvaid = approvaid;
    self.completedmemo = completedmemo;
    self.sourcetype = sourcetype;
    self.tradetype = tradetype;
    self.rentemployeeid = rentemployeeid;
    self.saleemployeeid = saleemployeeid;
    self.rentprice  = rentprice;
    self.saleprice = saleprice;
    self.unitofrentprice = unitofrentprice;
    self.SaleUnitPrice = SaleUnitPrice;
    self.UnitofRentUnitPrice = UnitofRentUnitPrice;
    self.RentUnitPrice = RentUnitPrice;
    self.ConstructionArea = ConstructionArea;
    return self;
}
- (NSString *)baseRequestUrl
{
    
    return @"/task/gethcModifyMission";
}


- (id)baseRequestArgument
{
    
    return @{
             @"userid":self.uid,
             @"approvaid":self.approvaid,
              @"completedmemo":self.completedmemo,
              @"sourcetype":self.sourcetype,
              @"tradetype":self.tradetype,
              @"rentemployeeid":self.rentemployeeid,
              @"saleemployeeid":self.saleemployeeid,
              @"rentprice":self.rentprice,
              @"saleprice":self.saleprice,
              @"unitofrentprice":self.unitofrentprice,
//             @"SaleUnitPrice":self.SaleUnitPrice,
//             @"UnitofRentUnitPrice":self.UnitofRentUnitPrice,
//             @"RentUnitPrice":self.RentUnitPrice,
             @"ConstructionArea" : self.ConstructionArea
             };
}
@end
