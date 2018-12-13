//
//Created by ESJsonFormatForMac on 18/05/13.
//

#import <Foundation/Foundation.h>
#import "KBBaseModel.h"

@class KBMidRBModel,KBMidUperRBMolde,KBListRBModel;
@interface KBRBHomeModel : KBBaseModel

@property (nonatomic, strong) KBMidRBModel *data;


@end
@interface KBMidRBModel : NSObject

@property (nonatomic, strong) NSArray<KBMidUperRBMolde *> *zrzsj;

@property (nonatomic, copy) NSString *userid;

@property (nonatomic, strong) NSArray<KBListRBModel *> *ggmdlist;

@property (nonatomic, copy) NSString *gxsj;


@end

@interface KBMidUperRBMolde : NSObject

@property (nonatomic, assign) NSInteger oaddaccurateguestnumber;//新增确客
@property (nonatomic, assign) CGFloat   oaddaccurateguestnumberavg;

@property (nonatomic, assign) NSInteger oaddrealservicenumber;//新增实勘数
@property (nonatomic, assign) CGFloat   oaddrealservicenumberavg;
@property (nonatomic, assign) NSInteger oaddtakealookinumber;//新增带看数
@property (nonatomic, assign) CGFloat   oaddtakealookinumberavg;

@property (nonatomic, assign) NSInteger oaddsubscribenumber;//新增认购
@property (nonatomic, assign) CGFloat   oaddsubscribenumberavg;

@property (nonatomic, assign) CGFloat oagencysidesnumber; //总签约边数
@property (nonatomic, assign) CGFloat   oagencysidesnumberavg;

@property (nonatomic, assign) NSInteger oaddtouristnumber;//新增客源数
@property (nonatomic, assign) CGFloat   oaddtouristnumberavg;
@property (nonatomic, assign) NSInteger oaddavailabilitynumber;//新增房源数
@property (nonatomic, assign) CGFloat oaddavailabilitynumberavg;


@property (nonatomic, assign) NSInteger oaddreportnumber;//新增报备
@property (nonatomic, assign) CGFloat   oaddreportnumberavg;

@property (nonatomic, assign) CGFloat oagencyperformance; //总业绩
@property (nonatomic, assign) CGFloat   oagencyperformanceavg;



@end

@interface KBListRBModel : NSObject

@property (nonatomic, assign) NSInteger oagencyperformance;

@property (nonatomic, assign) NSInteger oaddrealservicenumber;

@property (nonatomic, assign) NSInteger oaddaccurateguestnumber;

@property (nonatomic, assign) NSInteger oaddtakealookinumber;

@property (nonatomic, assign) NSInteger oaddsubscribenumber;

@property (nonatomic, assign) CGFloat oagencysidesnumber;

@property (nonatomic, assign) NSInteger oaddtouristnumber;

@property (nonatomic, assign) NSInteger oaddavailabilitynumber;

@property (nonatomic, assign) NSInteger oaddreportnumber;

@property (nonatomic, copy) NSString *officeid;

@property (nonatomic, copy) NSString *officename;

@end

