//
//Created by ESJsonFormatForMac on 18/06/02.
//

#import <Foundation/Foundation.h>
#import "KBBaseModel.h"

@class KBAnnouncementItem;
@interface KBAnnouncementModel : KBBaseModel

@property (nonatomic, strong) NSArray<KBAnnouncementItem *> *data;


@end
@interface KBAnnouncementItem : NSObject

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger announcementId;

@property (nonatomic, copy) NSString *publishIngArea;

@property (nonatomic, assign) NSInteger publishType;

@property (nonatomic, copy) NSString *publishTime;

@property (nonatomic, copy) NSString *modifiedTime;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *announcementContent;

@property (nonatomic, copy) NSString *addTime;

@property (nonatomic, copy) NSString *announcementTitle;

@end

