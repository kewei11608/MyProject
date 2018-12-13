//
//Created by ESJsonFormatForMac on 18/05/10.
//

#import <Foundation/Foundation.h>
#import "KBBaseModel.h"

@class KBMidUserInfoModel;

@interface KBUserInfoModel : KBBaseModel

@property (nonatomic, strong) KBMidUserInfoModel *data;

- (void)sava;

+ (NSString *)uid;

+ (NSString *)encodeUid;

+ (NSString *)userName;

+ (NSString *)areaCode;

+ (NSString *)iphone;

+ (void) clear;

+ (BOOL)isLogin;

+ (NSString *)userhead;

@end

@interface KBMidUserInfoModel : NSObject

@property (nonatomic, assign) NSInteger UserType;

@property (nonatomic, copy) NSString *CCCNCode;

@property (nonatomic, copy) NSString *LockDate;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *Source;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *Phone;

@property (nonatomic, copy) NSString *CreateDate;

@property (nonatomic, copy) NSString *ModificationDate;

@property (nonatomic, copy) NSString *Fullname;

@property (nonatomic, assign) NSInteger UserStatus;

@property (nonatomic, copy) NSString *AreaCode;

@property (nonatomic, assign) NSInteger CredentialsType;

@property (nonatomic, copy) NSString *CredentialsCode;

@property (nonatomic, copy) NSString *userhead;


@end

