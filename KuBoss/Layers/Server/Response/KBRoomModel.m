//
//Created by ESJsonFormatForMac on 18/06/06.
//

#import "KBRoomModel.h"
@implementation KBRoomModel
@dynamic data;

@end

@implementation KBRoomData


@end


@implementation KBRoomDetailsModel


@end


@implementation KBRoomOtherData

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"rentingselling" : [KBRoomRentingSelling class], @"agentlist" : [KBRoomAgentList class], @"source" : [KBRoomOtherSource class]};
}


@end


@implementation KBRoomRentingSelling


@end


@implementation KBRoomAgentList
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"officeagentlist" : [KBRoomAgent class]};
}


@end

@implementation KBRoomAgent


@end
@implementation KBRoomOtherSource


@end


