//
//Created by ESJsonFormatForMac on 18/05/14.
//

#import "KBFilterDateModel.h"
@implementation KBFilterDateModel
@dynamic data;

@end

@implementation KBMidFilterDateModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"week" : [KBFilterWeekModel class], @"day" : [KBFilterDayModel class], @"month" : [KBFilterMonthModel class]};
}


@end


@implementation KBFilterWeekModel


@end


@implementation KBFilterDayModel


@end


@implementation KBFilterMonthModel


@end


