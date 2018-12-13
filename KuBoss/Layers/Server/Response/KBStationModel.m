//
//Created by ESJsonFormatForMac on 18/06/02.
//

#import "KBStationModel.h"
@implementation KBStationModel
@synthesize data;
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [KBStationItem class]};
}


@end

@implementation KBStationItem


@end


