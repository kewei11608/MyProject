//
//Created by ESJsonFormatForMac on 18/05/17.
//

#import <Foundation/Foundation.h>
#import "KBBaseModel.h"

@class KBLQDataModel,KBLQWeekStandardModel,KBBdlhModel,KBLQDlhbzModel,KBDlhjjrModel,KBLQAgentListModel;
@interface KBLQRootModel : KBBaseModel

@property (nonatomic, strong) KBLQDataModel *data;


@end
@interface KBLQDataModel : NSObject

@property (nonatomic, strong) KBLQWeekStandardModel *qtdlh;

@property (nonatomic, strong) KBBdlhModel *bdlh;

@end

@interface KBLQWeekStandardModel : NSObject

@property (nonatomic, strong) NSArray *zxsj;

@end

@interface KBBdlhModel : NSObject

@property (nonatomic, assign) NSInteger dlhsz;

@property (nonatomic, strong) NSArray<KBDlhjjrModel *> *dlhjjr;

@property (nonatomic, assign) NSInteger zrs;

@property (nonatomic, strong) KBLQDlhbzModel *dlhbz;

@end

@interface KBLQDlhbzModel : NSObject

@property (nonatomic, assign) NSInteger lowquantificationtype;

@property (nonatomic, assign) NSInteger touristnumber;

@property (nonatomic, copy) NSString *areacode;

@property (nonatomic, assign) NSInteger lowquantificationid;

@property (nonatomic, assign) NSInteger realservicenumber;

@property (nonatomic, assign) NSInteger availabilitynumber;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *officeid;

@property (nonatomic, assign) NSInteger takealookinumber;

@end

@interface KBDlhjjrModel : NSObject

@property (nonatomic, strong) NSArray<KBLQAgentListModel *> *jjrlist;

@property (nonatomic, copy) NSString *officename;

@property (nonatomic, copy) NSString *officeid;

@end

@interface KBLQAgentListModel : NSObject

@property (nonatomic, assign) NSInteger realservicerynumber;

@property (nonatomic, copy) NSString *agentid;

@property (nonatomic, copy) NSString *areacode;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, assign) NSInteger availabilityrynumber;

@property (nonatomic, copy) NSString *lmonths;

@property (nonatomic, assign) NSInteger recordstatus;

@property (nonatomic, assign) NSInteger touristrynumber;

@property (nonatomic, assign) NSInteger takealookirynumber;

@property (nonatomic, copy) NSString *lqtagging;

@property (nonatomic, copy) NSString *officeid;

@property (nonatomic, assign) NSInteger lowquantificationryid;

@end

