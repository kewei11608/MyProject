//
//Created by ESJsonFormatForMac on 18/06/02.
//

#import "KBMessageMoudulesModel.h"
@implementation KBMessageMoudulesModel
@synthesize data;
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data" : [KBMessageMoudulesItem class]};
}


@end

@implementation KBMessageMoudulesItem


@end


