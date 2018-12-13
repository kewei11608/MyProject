//
//Created by ESJsonFormatForMac on 18/05/17.
//

#import "KBLQRootModel.h"
@implementation KBLQRootModel
@dynamic data;

@end

@implementation KBLQDataModel


@end


@implementation KBLQWeekStandardModel


@end


@implementation KBBdlhModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"dlhjjr" : [KBDlhjjrModel class]};
}


@end


@implementation KBLQDlhbzModel


@end


@implementation KBDlhjjrModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"jjrlist" : [KBLQAgentListModel class]};
}


@end


@implementation KBLQAgentListModel


@end


