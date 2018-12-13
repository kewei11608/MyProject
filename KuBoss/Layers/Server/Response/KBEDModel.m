//
//  KBEDModel.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBEDModel.h"

#define  kHouseName       @"房源名称"
#define  kHouseId         @"房源编号"
#define  kCustomerName    @"客户名称"
#define  kCustomerId      @"客源编号"
#define  kUploadImage     @"上传图片张数"


@implementation KBBottomEDTimeModel


@end

@implementation KBBottomEDModel

- (NSString *)title
{
    NSString *title;
    NSInteger  type = [self.types integerValue];
    switch (type) {
        case 0:
            title =  @"新增二手房房源";
            break;
        case 1:
            title = @"新增二手房客源";
            break;
        case 2:
            title =  @"二手房实勘";
            break;
        case 3:
            title =  @"二手房带看";
            break;
        case 4:
             title = @"新增租赁房源";
            break;
        case 5:
             title = @"新增租赁客源";
            break;
        case 6:
             title =  @"租赁实勘";
            break;
        case 7:
              title =  @"租赁带看";
            break;
        case 8:
            title =  @"新房报备";
            break;
            
        default:
            break;
    }
    
    return  title;
}

- (NSArray *)array
{
    NSMutableArray * arr = [[NSMutableArray array]init];
    NSInteger  type = [self.types integerValue];
    if (!self.customername) {
        self.customername = @"--";
    }
    if (!self.propertyname) {
        self.propertyname = @"--";
    }
    switch (type) {
        case 0:
        {
            NSString *  hourseName = [NSString stringWithFormat:@"%@ : %@",kHouseName,self.propertyname];
            [arr addObject:hourseName];
            NSString *  hourseId = [NSString stringWithFormat:@"%@ : %@",kHouseId,self.realtyid];
            [arr addObject:hourseId];
        }
            break;
        case 1:
        {
            NSString *  customerName = [NSString stringWithFormat:@"%@ : %@",kCustomerName,self.customername];
            [arr addObject:customerName];
            NSString *  customerId = [NSString stringWithFormat:@"%@ : %@",kCustomerId,self.customerid];
            [arr addObject:customerId];
        }
            break;
        case 2:
        {
            NSString *  hourseName = [NSString stringWithFormat:@"%@ : %@",kHouseName,self.propertyname];
            [arr addObject:hourseName];
            NSString *  hourseId =   [NSString stringWithFormat:@"%@ : %@",kHouseId,self.realtyid];
            [arr addObject:hourseId];
            NSString *  uploadImage = [NSString stringWithFormat:@"%@ : %@",kUploadImage,self.customername];
            [arr addObject:uploadImage];
            
        }
            break;
        case 3:
        {
            NSString *  hourseName = [NSString stringWithFormat:@"%@ : %@",kHouseName,self.propertyname];
            [arr addObject:hourseName];
            NSString *  hourseId =   [NSString stringWithFormat:@"%@ : %@",kHouseId,self.realtyid];
            [arr addObject:hourseId];
            NSString *  customerName = [NSString stringWithFormat:@"%@ : %@",kCustomerName,self.customername];
            [arr addObject:customerName];
            NSString *  customerId = [NSString stringWithFormat:@"%@ : %@",kCustomerId,self.customerid];
            [arr addObject:customerId];
            
        }
            break;
            
        case 4:
        {
            NSString *  hourseName = [NSString stringWithFormat:@"%@ : %@",kHouseName,self.propertyname];
            [arr addObject:hourseName];
            NSString *  hourseId = [NSString stringWithFormat:@"%@ : %@",kHouseId,self.realtyid];
            [arr addObject:hourseId];
            
        }
            break;
        case 5:
        {
            NSString *  customerName = [NSString stringWithFormat:@"%@ : %@",kCustomerName,self.customername];
            [arr addObject:customerName];
            NSString *  customerId = [NSString stringWithFormat:@"%@ : %@",kCustomerId,self.customerid];
            [arr addObject:customerId];
            
        }
            break;
        case 6:
        {
            NSString *  hourseName = [NSString stringWithFormat:@"%@ : %@",kHouseName,self.propertyname];
            [arr addObject:hourseName];
            NSString *  hourseId =   [NSString stringWithFormat:@"%@ : %@",kHouseId,self.realtyid];
            [arr addObject:hourseId];
            NSString *  uploadImage = [NSString stringWithFormat:@"%@ : %@",kUploadImage,self.customername];
            [arr addObject:uploadImage];
            
        }
            break;
        case 7:
        {
            NSString *  hourseName = [NSString stringWithFormat:@"%@ : %@",kHouseName,self.propertyname];
            [arr addObject:hourseName];
            NSString *  hourseId =   [NSString stringWithFormat:@"%@ : %@",kHouseId,self.realtyid];
            [arr addObject:hourseId];
            NSString *  customerName = [NSString stringWithFormat:@"%@ : %@",kCustomerName,self.customername];
            [arr addObject:customerName];
            NSString *  customerId = [NSString stringWithFormat:@"%@ : %@",kCustomerId,self.customerid];
            [arr addObject:customerId];
            
        }
            break;
        case 8:
        {
            NSString *  customerName = [NSString stringWithFormat:@"%@ : %@",kCustomerName,self.propertyname];
            [arr addObject:customerName];
//            NSString *  customerId = [NSString stringWithFormat:@"%@ : %@",kCustomerId,self.realtyid];
//            [arr addObject:customerId];
            
        }
            break;
        default:
            break;
    }
    return  arr;
}

@end

@implementation KBMidEDModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"EmployeeDynamicslist" : [KBBottomEDModel class]};
}
@end
@implementation KBEDModel
@dynamic data;

@end
