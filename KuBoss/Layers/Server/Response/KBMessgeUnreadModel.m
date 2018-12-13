//
//Created by ESJsonFormatForMac on 18/06/05.
//

#import "KBMessgeUnreadModel.h"
@implementation KBMessgeUnreadModel
@dynamic data;
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [KBMessgeUnreadData class]};
}


@end

@implementation KBMessgeUnreadData


@end


