//
//Created by ESJsonFormatForMac on 18/06/06.
//

#import <Foundation/Foundation.h>
#import "KBBaseModel.h"

@class KBRoomData,KBRoomDetailsModel,KBRoomOtherData,KBRoomRentingSelling,KBRoomAgentList,KBRoomOtherSource;
@interface KBRoomModel : KBBaseModel


@property (nonatomic, strong) KBRoomData *data;


@end
@interface KBRoomData : NSObject

@property (nonatomic, strong) KBRoomDetailsModel *roomdetails;

@property (nonatomic, strong) KBRoomOtherData *dropdowndata;

@end

@interface KBRoomDetailsModel : NSObject

@property (nonatomic, copy) NSString *SaleShopName;

@property (nonatomic, copy) NSString *ConstructionType;

@property (nonatomic, copy) NSString *ToiletNums;

@property (nonatomic, copy) NSString *CertificationYears;

@property (nonatomic, copy) NSString *strSourceType;

@property (nonatomic, copy) NSString *strRealtyStatus;

@property (nonatomic, copy) NSString *LivingRoomNums;

@property (nonatomic, copy) NSString *Address;

@property (nonatomic, copy) NSString *RealtyNum;

@property (nonatomic, copy) NSString *RentPrice;

@property (nonatomic, copy) NSString *RoomNums;

@property (nonatomic, copy) NSString *AreaName;

@property (nonatomic, copy) NSString *strTradeType;

@property (nonatomic, copy) NSString *ConstructionArea;

@property (nonatomic, copy) NSString *RentShopName;

@property (nonatomic, copy) NSString *SalePrice;

@property (nonatomic, copy) NSString *UnitofRentPrice;

@property (nonatomic, copy) NSString *BalconyNums;

@property (nonatomic, copy) NSString *RentEmployeeName;

@property (nonatomic, copy) NSString *strFaceOrientation;

@property (nonatomic, copy) NSString *SaleEmployeeName;

@property (nonatomic, copy) NSString *CommunityName;
//=======================

@property (nonatomic, copy) NSString *sourcetype;

@property (nonatomic, copy) NSString *tradetype;

@property (nonatomic, copy) NSString *rentemployeeid;

@property (nonatomic, copy) NSString *saleemployeeid;

@property (nonatomic, copy) NSString *rentprice;

@property (nonatomic, copy) NSString *saleprice;

@property (nonatomic, strong) NSDictionary *FieldPermission;

// 不显示字段，传服务器
@property (nonatomic, copy) NSString *RentUnitPrice;
@property (nonatomic, copy) NSString *UnitofRentUnitPrice;
@property (nonatomic, copy) NSString *SaleUnitPrice;

@end

@interface KBRoomOtherData : NSObject

@property (nonatomic, strong) NSArray<NSString *> *rental;

@property (nonatomic, strong) NSArray<KBRoomOtherSource *> *source;

@property (nonatomic, strong) NSArray<KBRoomRentingSelling *> *rentingselling;

@property (nonatomic, strong) NSArray<KBRoomAgentList *> *agentlist;

@end

@interface KBRoomRentingSelling : NSObject

@property (nonatomic, assign) NSInteger RealtyValidity;

@property (nonatomic, assign) NSInteger Index;

@property (nonatomic, assign) NSString*  Key;

@property (nonatomic, assign) NSInteger PositionLevel;

@property (nonatomic, assign) NSInteger FieldID;

@property (nonatomic, assign) BOOL IsDeleted;

@property (nonatomic, assign) BOOL IsLocked;

@property (nonatomic, copy) NSString *FeatureTags;

@property (nonatomic, copy) NSString *Value;

@end

@interface KBRoomAgentList : NSObject

@property (nonatomic, copy) NSString *officename;

@property (nonatomic, copy) NSString *officeid;

@property (nonatomic, copy) NSArray *officeagentlist;

@end

@interface KBRoomAgent : NSObject

@property (nonatomic, copy) NSString *agenthead;

@property (nonatomic, copy) NSString *accountid;

@property (nonatomic, copy) NSString *officename;

@property (nonatomic, copy) NSString *officeid;

@property (nonatomic, copy) NSString *agentname;

@end

@interface KBRoomOtherSource : NSObject

@property (nonatomic, copy) NSString *RealtyValidity;

@property (nonatomic, assign) NSInteger Index;

@property (nonatomic, assign) NSString * Key;

@property (nonatomic, assign) NSInteger PositionLevel;

@property (nonatomic, assign) NSInteger FieldID;

@property (nonatomic, assign) BOOL IsDeleted;

@property (nonatomic, assign) BOOL IsLocked;

@property (nonatomic, copy) NSString *FeatureTags;

@property (nonatomic, copy) NSString *Value;

@end

