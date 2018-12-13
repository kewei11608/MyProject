//
//Created by ESJsonFormatForMac on 18/06/02.
//

#import <Foundation/Foundation.h>
#import "KBBaseModel.h"

@class KBStationItem;
@interface KBStationModel : KBBaseModel

@property (nonatomic, strong) NSArray<KBStationItem *> *data;

@end
@interface KBStationItem : NSObject

@property (nonatomic, assign) NSInteger publishType;

@property (nonatomic, copy) NSString *cmReleaseDate;

@property (nonatomic, copy) NSString *cmModifiedDate;

@property (nonatomic, assign) NSInteger shareVolume;

@property (nonatomic, copy) NSString *articehdUrl;

@property (nonatomic, copy) NSString *stationDescription;

@property (nonatomic, assign) NSInteger stationsId;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *publishIngArea;

@property (nonatomic, assign) NSInteger sharetf;

@property (nonatomic, assign) NSInteger clickQuantity;

@property (nonatomic, copy) NSString *addTime;

@property (nonatomic, copy) NSString *stationTitle;

@property (nonatomic, copy) NSString *stationContent;

@end

