//
//Created by ESJsonFormatForMac on 18/05/14.
//

#import <Foundation/Foundation.h>
#import "KBBaseModel.h"
@class KBMidFilterDateModel,KBFilterWeekModel,KBFilterDayModel,KBFilterMonthModel;
@interface KBFilterDateModel : KBBaseModel


@property (nonatomic, strong) KBMidFilterDateModel *data;


@end
@interface KBMidFilterDateModel : NSObject

@property (nonatomic, strong) NSArray<KBFilterWeekModel *> *week;

@property (nonatomic, copy) NSString *userid;

@property (nonatomic, strong) NSArray<KBFilterDayModel *> *day;

@property (nonatomic, strong) NSArray<KBFilterMonthModel *> *month;

@end

@interface KBFilterWeekModel : NSObject

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *data;

@end

@interface KBFilterDayModel : NSObject

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *data;

@end

@interface KBFilterMonthModel : NSObject

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *data;

@end

