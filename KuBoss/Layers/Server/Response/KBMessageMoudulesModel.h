//
//Created by ESJsonFormatForMac on 18/06/02.
//

#import <Foundation/Foundation.h>
#import "KBBaseModel.h"

@class KBMessageMoudulesItem;
@interface KBMessageMoudulesModel : KBBaseModel

@property (nonatomic, strong) NSArray<KBMessageMoudulesItem *> *data;


@end
@interface KBMessageMoudulesItem : NSObject

@property (nonatomic, copy) NSString *timeslot;

@property (nonatomic, assign) NSInteger touristnumber;

@property (nonatomic, copy) NSString *areacode;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, assign) NSInteger recordstatus;

@property (nonatomic, assign) NSInteger realservicenumber;

@property (nonatomic, assign) NSInteger lowquantification;

@property (nonatomic, copy) NSString *userid;

@property (nonatomic, copy) NSString *lowquantificationid;

@property (nonatomic, assign) NSInteger availabilitynumber;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger lowquantificationrnoticeid;

@property (nonatomic, assign) NSInteger notificationtype;

@property (nonatomic, copy) NSString *completionrate;

@property (nonatomic, assign) NSInteger takealookinumber;

@property (nonatomic, copy) NSString *content;

@end

