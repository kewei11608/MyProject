//
//Created by ESJsonFormatForMac on 18/06/05.
//

#import <Foundation/Foundation.h>
#import "KBBaseModel.h"
@class KBMessgeUnreadData;
@interface KBMessgeUnreadModel : KBBaseModel

@property (nonatomic, strong) NSArray<KBMessgeUnreadData *> *data;

@end
@interface KBMessgeUnreadData : NSObject

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger mstype;

@end

