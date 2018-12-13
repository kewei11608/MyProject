//
//Created by ESJsonFormatForMac on 18/05/21.
//

#import <Foundation/Foundation.h>

@class KBLQDetailData,KBLQDetailWeek;
@interface KBLQDetailModel : KBBaseModel


@property (nonatomic, strong) KBLQDetailData *data;


@end
@interface KBLQDetailData : NSObject

@property (nonatomic, assign) NSInteger zhoushu;

@property (nonatomic, copy) NSString *agenthead;

@property (nonatomic, copy) NSString *agentid;

@property (nonatomic, copy) NSString *officename;

@property (nonatomic, copy) NSString *agentname;

@property (nonatomic, assign) NSInteger syzsz;

@property (nonatomic, strong) NSArray<KBLQDetailWeek *> *zdlhxqjh;

@property (nonatomic, assign) NSInteger sflx;

@property (nonatomic, strong) NSArray <KBLQDetailWeek *> *ydlhxqjh;

@property (nonatomic, assign) NSInteger syzdlh;

@property (nonatomic, assign) NSInteger yueshu;

@property (nonatomic, assign) NSInteger zongshu;

@property (nonatomic, assign) NSInteger syydlh;

@property (nonatomic, copy) NSString *agentphone;

@end

@interface KBLQDetailWeek : NSObject

@property (nonatomic, assign) NSInteger touristrnumber;

@property (nonatomic, assign) NSInteger lowquantificationrid;

@property (nonatomic, copy) NSString *agentid;
@property (nonatomic, copy) NSString *timeslot;


@property (nonatomic, assign) NSInteger touristnumber;

@property (nonatomic, assign) NSInteger recordstatus;

@property (nonatomic, copy) NSString *officename;

@property (nonatomic, assign) NSInteger realservicenumber;

@property (nonatomic, assign) NSInteger availabilitynumber;

@property (nonatomic, assign) NSInteger realservicernumber;

@property (nonatomic, assign) NSInteger takealookirnumber;

@property (nonatomic, copy) NSString *officeid;

@property (nonatomic, assign) NSInteger takealookinumber;

@property (nonatomic, assign) NSInteger availabilityrnumber;


@end

