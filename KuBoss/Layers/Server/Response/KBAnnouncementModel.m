//
//Created by ESJsonFormatForMac on 18/06/02.
//

#import "KBAnnouncementModel.h"
@implementation KBAnnouncementModel
@dynamic data;
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [KBAnnouncementItem class]};
}


@end

@implementation KBAnnouncementItem


@end


