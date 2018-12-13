//
//Created by ESJsonFormatForMac on 18/05/21.
//

#import "KBLQRecordModel.h"
@implementation  KBLQRecordModel
@dynamic data;

@end

@implementation  KBLQRecordData

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"symddlhxxtj" : [ KBLQRecordShop class]};
}


@end


@implementation  KBLQRecordShop

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"jjrlist" : [ KBLQRecordAgent class]};
}


@end


@implementation  KBLQRecordAgent


@end


