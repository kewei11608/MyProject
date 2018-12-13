//
//  KBApiLayer.m
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBApiLayer.h"
#import <YYModel/YYModel.h>
#import <AFNetworking.h>
#import "KBBannerRequest.h"
#import "KBICRequest.h"
#import "KBWarReportRequest.h"
#import "KBRankRequest.h"
#import "KBICRequest.h"
#import "KBICSettingRequest.h"
#import "KBResourceManagerRequest.h"
#import "KBLQRequest.h"
#import "KBEDRequest.h"
#import "KBShopAgentRequest.h"
#import "KBLoginRequest.h"
#import "KBSendSmsCodeRequest.h"
#import "KBValidateSmsCodeRequest.h"
#import "KBModifyPhoneRequest.h"
#import "KBValidatePasswordRequest.h"
#import "KBModifyPasswordRequest.h"
#import "KBRBHomeRequest.h"
#import "KBShopRequest.h"
#import "KBFilterDateRequest.h"
#import "KBLQUserConfigRequest.h"
#import "KBLQRootRequest.h"
#import "KBLQSaveConfigRequest.h"
#import "KBManagerRequest.h"
#import "KBLQRecordRequest.h"
#import "KBLQDetailRequest.h"
#import "KBLQItemRequest.h"
#import "KBLoginOutRequest.h"
#import "KBLoginShopRequest.h"
#import "KBAccountFreezeListRequest.h"
#import "KBAccountFreezeDetailRequest.h"
#import "AccountFreezeRecordListRequest.h"
#import "KBRelieveAccountFreezeRequest.h"
#import "KBHandleLeaveOfficeRequest.h"
#import "KBSubmitLeaveOfficeReqeust.h"
#import "KBHouseListingReuest.h"
#import "KBHouseHandleRecordRequest.h"
#import "KBAnnouncementRequest.h"
#import "KBModulesRequest.h"
#import "KBStationRequest.h"
#import "KBHouseDetailRequst.h"
#import "KBHouseHandleRequest.h"
#import "KBRoomDetailRequest.h"
#import "KBMessgeSystemUnreadRequest.h"
#import "KBMessgeModulesUnReadRequest.h"
#import "KBHouseListReuest.h"
#import "KBFreezeRecordDetailsRequest.h"
#import "KBHousingCirculationDoneRequest.h"
#import "KBHouseAgreeeRequest.h"
#import "KBJPushRegistRequest.h"
#import "KBCheckVersionRequest.h"

@interface KBApiLayer ()
@property (nonatomic,copy) NSString * uid;

@end
@implementation KBApiLayer

//- (instancetype)initWithUid:(NSString *)uid
//{
//    self = [super init];
//    if (!self) return nil;
//    self.uid =  uid;
//    return self;
//}

+ (instancetype)sharedInstance
{
    return  [[self alloc]init];
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;
    self.uid = [KBUserInfoModel uid];
    return self;
}

- (void)bannerSuccess:(responseSuccessBlock_t) complete
                 fail:(responseFailBlock_t)failure
{
    KBBannerRequest *request = [[KBBannerRequest alloc] initWithUserid:self.uid];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBanerModel *model = [KBBanerModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)checkType:(NSString *)type
          success:(responseSuccessBlock_t) complete
             fail:(responseFailBlock_t)failure
{
    
}

- (void)warReportPage:(NSInteger )page
                 size:(NSInteger )size
              success:(responseSuccessBlock_t) complete
                 fail:(responseFailBlock_t)failure
{
    KBWarReportRequest *request = [[KBWarReportRequest alloc] initWithUserid:self.uid
                                                                        page:page
                                                                        size:size];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBWarReportModel *model = [KBWarReportModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)rankTradeType:(NSInteger)tradetype
                 page:(NSInteger)page
                 size:(NSInteger)size
                month:(NSString *)month
              success:(responseSuccessBlock_t) complete
                 fail:(responseFailBlock_t)failure
{
    
    KBRankRequest *request = [[KBRankRequest alloc] initWithUserid:self.uid
                                                         tradeType:tradetype
                                                              page:page
                                                              size:size
                                                             month:month];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBRankModel *model = [KBRankModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)followWithType:(NSInteger )type
               success:(responseSuccessBlock_t) complete
                  fail:(responseFailBlock_t)failure
{
    KBICRequest *request = [[KBICRequest alloc] initWithUserid:self.uid
                                                     checkType:type];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
         KBIndicatorConcernModel *model = [KBIndicatorConcernModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)followSetting:(NSString *)targetType
              success:(responseSuccessBlock_t) complete
                 fail:(responseFailBlock_t)failure
{
    KBICSettingRequest *request = [[KBICSettingRequest alloc] initWithUserid:self.uid
                                                                  targetType:targetType];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)resourceWithOfficeid:(NSString *)officeid
                     success:(responseSuccessBlock_t) complete
                        fail:(responseFailBlock_t)failure
{
    KBResourceManagerRequest *request = [[KBResourceManagerRequest alloc] initWithUserid:self.uid
                                                                                officeid:officeid];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBResourceManagerModel *model = [KBResourceManagerModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)lqAgentid:(NSString *)agentid
          success:(responseSuccessBlock_t) complete
             fail:(responseFailBlock_t)failure
{
    
    KBLQRequest *request = [[KBLQRequest alloc] initWithUserid:self.uid
                                                       agentid:agentid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBLQModel *model = [KBLQModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)edWithType:(NSInteger)type
          agentid :(NSInteger)agentid
              page:(NSInteger)page
           success:(responseSuccessBlock_t) complete
              fail:(responseFailBlock_t) failure
{
    KBEDRequest *request = [[KBEDRequest alloc] initWithUserid:self.uid
                                                          type:type
                                                       agentid:agentid
                                                          page:page];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBEDModel *model = [KBEDModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}



- (void)shopAgentid:(NSInteger) agentid
           timetype:(NSInteger) timetype
          daterange:(NSInteger)daterange
        housingtype:(NSInteger)housingtype
            success:(responseSuccessBlock_t) complete
               fail:(responseFailBlock_t)failure
{
    KBShopAgentRequest *request = [[KBShopAgentRequest alloc] initWithUserid:self.uid
                                                                     agentid:agentid
                                                                    timetype:timetype
                                                                   daterange:daterange
                                                                 housingtype:housingtype];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBShopAgentModel *model = [KBShopAgentModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)loginWithUserCode:(NSString *)userCode
                 Password:(NSString *)password
                  success:(responseSuccessBlock_t) complete
                     fail:(responseFailBlock_t)failure
{
    
    KBLoginRequest *request = [[KBLoginRequest alloc]initWithUserid:self.uid
                                                           userCode:userCode
                                                           password:password];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBUserInfoModel *model = [KBUserInfoModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
    
}

- (void)sendSmsCodeWithPhone:(NSString *)phone
                     success:(responseSuccessBlock_t) complete
                        fail:(responseFailBlock_t)failure
{
    
    KBSendSmsCodeRequest *request = [[KBSendSmsCodeRequest alloc]initWithUserid:self.uid
                                                                          phone:phone];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)validateSmsCodeWithPassword:(NSString *)password
                               code:(NSString *)code
                            success:(responseSuccessBlock_t) complete
                               fail:(responseFailBlock_t)failure
{
    KBValidateSmsCodeRequest *request = [[KBValidateSmsCodeRequest alloc]initWithUserid:self.uid
                                                                               password:password
                                                                                   code:code];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)modifyPhone:(NSString *)phone
               code:(NSString *)code
           password:(NSString *)password
            success:(responseSuccessBlock_t) complete
               fail:(responseFailBlock_t)failure
{
    KBModifyPhoneRequest *request = [[KBModifyPhoneRequest alloc]initWithUserid:self.uid
                                                                       password:password
                                                                           code:code
                                                                         iphone:phone];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)validatePassword:(NSString *)password
                 success:(responseSuccessBlock_t) complete
                    fail:(responseFailBlock_t)failure
{
    
    KBValidatePasswordRequest *request = [[KBValidatePasswordRequest alloc]initWithUserid:self.uid
                                                                      password:password];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)modifyOldPassword:(NSString *)pwdOld
              newPassword:(NSString *)pwdNew
                  success:(responseSuccessBlock_t) complete
                     fail:(responseFailBlock_t)failure;
{
    
    KBModifyPasswordRequest *request = [[KBModifyPasswordRequest alloc]initWithUserid:self.uid
                                                                          oldPassword:pwdOld
                                                                          newPassword:pwdNew];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)resourceManagerHomeTimeType:(NSInteger) timeType
                          dataRange:(NSInteger) dataRange
                        housingType:(NSInteger) housingType
                            success:(responseSuccessBlock_t) complete
                               fail:(responseFailBlock_t)failure
{
    KBRBHomeRequest *request = [[KBRBHomeRequest alloc]initWithUserid:self.uid
                                                             timeType:timeType
                                                            dataRange:dataRange
                                                          housingType:housingType];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBRBHomeModel *model = [KBRBHomeModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)shopTimeType:(NSInteger) timeType
            officeid:(NSString *) officeid
           dataRange:(NSInteger) dataRange
         housingType:(NSInteger) housingType
             success:(responseSuccessBlock_t) complete
                fail:(responseFailBlock_t)failure
{
    KBShopRequest *request = [[KBShopRequest alloc] initWithUserid:self.uid
                                                          officeid:officeid
                                                          timetype:timeType
                                                         daterange:dataRange
                                                       housingtype:housingType
                                                             ];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBShopModel *model = [KBShopModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)filterDateSuccess:(responseSuccessBlock_t) complete
                     fail:(responseFailBlock_t)failure{
    KBFilterDateRequest *request = [[KBFilterDateRequest alloc] initWithUserid:self.uid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBFilterDateModel *model = [KBFilterDateModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)lqConfigSuccess:(responseSuccessBlock_t) complete
                   fail:(responseFailBlock_t)failure
{
    KBLQUserConfigRequest *request = [[KBLQUserConfigRequest alloc] initWithUserid:self.uid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBLQUserConfigModel *model = [KBLQUserConfigModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)lqRootTimeType:(NSInteger) timetype
               success:(responseSuccessBlock_t) complete
                  fail:(responseFailBlock_t)failure
{
    KBLQRootRequest *request = [[KBLQRootRequest alloc] initWithUserid:self.uid
                                                              timetype:timetype];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBLQRootModel *model = [KBLQRootModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)lqSaveConfigweeklyReminderTime:(NSString *)weeklyReminderTime
                    monthRemindingTime:(NSString *)monthRemindingTime
                            remindingz:(NSInteger)remindingz
                            remindingy:(NSInteger)remindingy
                            listString:(NSString*)listString
                            noticetype:(NSInteger)noticetype
                               success:(responseSuccessBlock_t) complete
                                  fail:(responseFailBlock_t)failure
{
    KBLQSaveConfigRequest *request = [[KBLQSaveConfigRequest alloc] initWithUserid:self.uid
                                                              weeklyReminderTime:weeklyReminderTime
                                                                monthRemindingTime:monthRemindingTime listString:listString
                                                                        noticetype:noticetype
                                                                        remindingz:remindingz
                                                                        remindingy:remindingy];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)managerOfficeid:(NSString *)officeid
                success:(responseSuccessBlock_t) complete
                   fail:(responseFailBlock_t)failure
{
    KBManagerRequest *request = [[KBManagerRequest alloc] initWithUserid:self.uid officeId:officeid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBManagerModel *model = [KBManagerModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)lqRecordListSuccess:(responseSuccessBlock_t) complete
                       fail:(responseFailBlock_t)failure
{
    KBLQRecordRequest *request = [[KBLQRecordRequest alloc] initWithUserid:self.uid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBLQRecordModel *model = [KBLQRecordModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)lqDetailTimetype:(NSInteger)timetype
                 agentid:(NSInteger)agentid
                 success:(responseSuccessBlock_t) complete
                    fail:(responseFailBlock_t)failure
{
    KBLQDetailRequest *request = [[KBLQDetailRequest alloc] initWithUserid:self.uid
                                                                  timetype:timetype
                                                                   agentid:agentid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBLQDetailModel *model = [KBLQDetailModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)lqItemAgentid:(NSInteger)agentid
 lowquantificationrid:(NSInteger)lowquantificationrid
              success:(responseSuccessBlock_t) complete
                 fail:(responseFailBlock_t)failure
{
    
    KBLQItemRequest *request = [[KBLQItemRequest alloc] initWithUserid:self.uid
                                                                 agentid:agentid
                                                  lowquantificationrid:lowquantificationrid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBLQItemModel *model = [KBLQItemModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)loginOutSuccess:(responseSuccessBlock_t) complete
                   fail:(responseFailBlock_t)failure
{
    
    KBLoginOutRequest *request = [[KBLoginOutRequest alloc] initWithUserid:self.uid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)loginShopSuccess:(responseSuccessBlock_t) complete
                    fail:(responseFailBlock_t)failure
{
    KBLoginShopRequest *request = [[KBLoginShopRequest alloc] initWithUserid:self.uid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBPermissionModel *model = [KBPermissionModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)taskAccountFreezelistSuccess:(responseSuccessBlock_t)complete
                                fail:(responseFailBlock_t)failure
{
    KBAccountFreezeListRequest *request = [[KBAccountFreezeListRequest alloc] initWithUserid:self.uid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBAccountFreezeListModel *model = [KBAccountFreezeListModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)taskAccountFreezeDetailAccountid:(NSInteger)accountid
                                 success:(responseSuccessBlock_t)complete
                                    fail:(responseFailBlock_t)failure
{
    KBAccountFreezeDetailRequest *request = [[KBAccountFreezeDetailRequest alloc] initWithUserid:self.uid accountid:accountid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBAccountFreezeDetailModel *model = [KBAccountFreezeDetailModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)taskAccountFreezelistRecordSuccess:(responseSuccessBlock_t)complete
                                      fail:(responseFailBlock_t)failure
{
    AccountFreezeRecordListRequest *request = [[AccountFreezeRecordListRequest alloc] initWithUserid:self.uid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBAccountFreezeRecordListModel *model = [KBAccountFreezeRecordListModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)taskRelieveAccountFreezeAccountid:(NSInteger)accountid
                                  success:(responseSuccessBlock_t)complete
                                     fail:(responseFailBlock_t)failure
{
    
    KBRelieveAccountFreezeRequest *request = [[KBRelieveAccountFreezeRequest alloc] initWithUserid:self.uid accountid:accountid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)taskHandleLeaveOfficeAccountid:(NSInteger)accountid
                               success:(responseSuccessBlock_t)complete
                                  fail:(responseFailBlock_t)failure
{
    
//    KBHandleLeaveOfficeRequest *request = [[KBHandleLeaveOfficeRequest alloc] initWithUserid:[KBUserInfoModel encodeUid] accountid:accountid];
//
//    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSDictionary *dict = request.responseJSONObject;
//        KBHandleLeaveOfficeModel *model = [KBHandleLeaveOfficeModel yy_modelWithDictionary:dict];
//        if (complete) { complete(model); }
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        if (failure)
//            failure(request.error);
//    }];
    
    
    NSDictionary *dParam = @{@"userid" : self.uid,
                            @"accountid" : @(accountid)
                            };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [policy setAllowInvalidCertificates:YES];
    [policy setValidatesDomainName:NO];
    manager.securityPolicy = policy;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.operationQueue.maxConcurrentOperationCount = 5;
    manager.requestSerializer.timeoutInterval = 30;
    [manager POST:[NSString stringWithFormat:@"%@%@/task/handleLeaveOffice", httpApi, httpFilePath] parameters:dParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@", dict);
        KBHandleLeaveOfficeModel *model = [KBHandleLeaveOfficeModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure)
            failure(error);
    }];
    
}

- (void)taskHandleLeaveOfficeAccountid:(NSString *)accountid
                                reason:(NSString *)reason
                             approvaid:(NSString *)approvaid
                        separationdate:(NSString *)separationdate
                               success:(responseSuccessBlock_t)complete
                                  fail:(responseFailBlock_t)failure
{
    KBSubmitLeaveOfficeReqeust *request = [[KBSubmitLeaveOfficeReqeust alloc] initWithUserid:self.uid
                                                                                   accountid:accountid
                                                                                      reason:reason
                                                                                   approvaid:approvaid
                                                                              separationdate:separationdate];
    NSDictionary *param = [request baseRequestArgument];
    NSString *url = [request baseRequestUrl];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [policy setAllowInvalidCertificates:YES];
    [policy setValidatesDomainName:NO];
    manager.securityPolicy = policy;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.operationQueue.maxConcurrentOperationCount = 5;
    manager.requestSerializer.timeoutInterval = 30;
    [manager POST:[NSString stringWithFormat:@"%@%@%@", httpApi, httpFilePath, url] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@", dict);
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure)
            failure(request.error);
    }];
    
    
//    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSDictionary *dict = request.responseJSONObject;
//        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
//        if (complete) { complete(model); }
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        if (failure)
//            failure(request.error);
//    }];
}

- (void)taskHouseListSuccess:(responseSuccessBlock_t)complete
                        fail:(responseFailBlock_t)failure
{
    KBHouseListingReuest *request = [[KBHouseListingReuest alloc] initWithUserid:self.uid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBAccountFreezeListModel *model = [KBAccountFreezeListModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)taskHouseListRecordSuccess:(responseSuccessBlock_t)complete
                              fail:(responseFailBlock_t)failure
{
    KBHouseHandleRecordRequest *request = [[KBHouseHandleRecordRequest alloc] initWithUserid:self.uid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBAccountFreezeRecordListModel *model = [KBAccountFreezeRecordListModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}
- (void)taskHouseApprovaid:(NSString*)approvaid
                   success:(responseSuccessBlock_t)complete
                      fail:(responseFailBlock_t)failure
{
    
    
    KBHouseDetailRequst *request = [[KBHouseDetailRequst alloc] initWithUserid:self.uid approvaid:approvaid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBHouseDetailModel *model = [KBHouseDetailModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)taskHouseDoneApprovaid:(NSString*)approvaid
                       success:(responseSuccessBlock_t)complete
                          fail:(responseFailBlock_t)failure
{
    KBHousingCirculationDoneRequest *request = [[KBHousingCirculationDoneRequest alloc] initWithUserid:self.uid approvaid:approvaid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBHouseDetailModel *model = [KBHouseDetailModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)taskHouseHandleApprovaid:(NSString *)approvaid
                    decisiontype:(NSInteger)decisiontype
                           input:(NSString *)input
                         success:(responseSuccessBlock_t)complete
                            fail:(responseFailBlock_t)failure
{
    KBHouseHandleRequest *request = [[KBHouseHandleRequest alloc] initWithUserid:self.uid
                                                                       approvaid:approvaid
                                                                    decisiontype:decisiontype
                                                                           input:input];
    
//    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSDictionary *dict = request.responseJSONObject;
//        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
//        if (complete) { complete(model); }
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        if (failure)
//            failure(request.error);
//    }];
    NSDictionary *param = [request baseRequestArgument];
    NSString *url = [request baseRequestUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [policy setAllowInvalidCertificates:YES];
    [policy setValidatesDomainName:NO];
    manager.securityPolicy = policy;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.operationQueue.maxConcurrentOperationCount = 5;
    manager.requestSerializer.timeoutInterval = 30;
    [manager POST:[NSString stringWithFormat:@"%@%@%@", httpApi, httpFilePath, url] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@", dict);
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure)
            failure(request.error);
    }];
}

- (void)taskRoomDetailRealtyid:(NSInteger)realtyid
                       success:(responseSuccessBlock_t)complete
                          fail:(responseFailBlock_t)failure
{
    KBRoomDetailRequest *request = [[KBRoomDetailRequest alloc] initWithUserid:self.uid
                                                                       realtyid:realtyid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBRoomModel *model = [KBRoomModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}


- (void)taskFreezeRecordDetailsApprovaid:(NSString *)approvaid
                                 success:(responseSuccessBlock_t)complete
                                    fail:(responseFailBlock_t)failure
{
    KBFreezeRecordDetailsRequest *request = [[KBFreezeRecordDetailsRequest alloc] initWithUserid:self.uid
                                                                      approvaid:approvaid];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBAccountFreezeDetailModel *model = [KBAccountFreezeDetailModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}


- (void)taskNoReadNoSuccess:(responseSuccessBlock_t)complete
                       fail:(responseFailBlock_t)failure
{
    KBHouseListReuest *request = [[KBHouseListReuest alloc] initWithUserid:self.uid] ;
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)taskHourseAgreeApprovaid:(NSString *)approvaid
                   completedmemo:(NSString *)completedmemo
                      sourcetype:(NSString *)sourcetype
                       tradetype:(NSString*)tradetype
                  rentemployeeid:(NSString*)rentemployeeid
                  saleemployeeid:(NSString*)saleemployeeid
                       rentprice:(NSString *)rentprice
                       saleprice:(NSString *)saleprice
                 unitofrentprice:(NSString *)unitofrentprice
                   RentUnitPrice:(NSString *)RentUnitPrice
             UnitofRentUnitPrice:(NSString *)UnitofRentUnitPrice
                   SaleUnitPrice:(NSString *)SaleUnitPrice
                ConstructionArea:(NSString *)ConstructionArea
                         success:(responseSuccessBlock_t)complete
                            fail:(responseFailBlock_t)failure
{
    
    KBHouseAgreeeRequest *request = [[KBHouseAgreeeRequest alloc] initWithUserid:self.uid
                                                                       approvaid:approvaid
                                                                   completedmemo:completedmemo
                                                                      sourcetype:sourcetype
                                                                       tradetype:tradetype
                                                                  rentemployeeid:rentemployeeid
                                                                  saleemployeeid:saleemployeeid
                                                                       rentprice:rentprice
                                                                       saleprice:saleprice
                                                                 unitofrentprice:unitofrentprice
                                                                   RentUnitPrice:RentUnitPrice
                                                             UnitofRentUnitPrice:UnitofRentUnitPrice
                                                                   SaleUnitPrice:SaleUnitPrice
                                                                ConstructionArea:ConstructionArea];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

//=====
- (void)messageAnnouncementAreaCode:(NSString *)areaCode
                          pageIndex:(NSInteger) pageIndex
                           pageSize:(NSInteger)pageSize
                            success:(responseSuccessBlock_t)complete
                               fail:(responseFailBlock_t)failure
{
    KBAnnouncementRequest *request = [[KBAnnouncementRequest alloc] initWithUserid:self.uid
                                                                          areaCode:areaCode
                                                                         pageIndex:pageIndex
                                                                          pageSize:pageSize];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBAnnouncementModel *model = [KBAnnouncementModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}


- (void)messageMoudulespageIndex:(NSInteger) pageIndex
                        pageSize:(NSInteger)pageSize
                         success:(responseSuccessBlock_t)complete
                            fail:(responseFailBlock_t)failure
{
    
    KBModulesRequest *request = [[KBModulesRequest alloc] initWithUserid:self.uid
                                                               pageIndex:pageIndex
                                                                pageSize:pageSize];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBMessageMoudulesModel *model = [KBMessageMoudulesModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)messageStationAreaCode:(NSString *)areaCode
                     pageIndex:(NSInteger) pageIndex
                      pageSize:(NSInteger)pageSize
                       success:(responseSuccessBlock_t)complete
                          fail:(responseFailBlock_t)failure
{
    KBStationRequest *request = [[KBStationRequest alloc] initWithUserid:self.uid
                                                                areaCode:areaCode
                                                               pageIndex:pageIndex
                                                                pageSize:pageSize];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBStationModel *model = [KBStationModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)messageAreaCode:(NSInteger) code
                success:(responseSuccessBlock_t)complete
                   fail:(responseFailBlock_t)failure
{
    KBMessgeSystemUnreadRequest *request = [[KBMessgeSystemUnreadRequest alloc] initWithUserid:self.uid areaCode:code];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBMessgeUnreadModel *model = [KBMessgeUnreadModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)jPushRegist:(NSString *)jPushID
                success:(responseSuccessBlock_t)complete
                   fail:(responseFailBlock_t)failure
{
    KBJPushRegistRequest *request = [[KBJPushRegistRequest alloc] initWithUserid:self.uid registID:jPushID];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        complete(dict);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

- (void)messageModuleSuccess:(responseSuccessBlock_t)complete
                        fail:(responseFailBlock_t)failure
{
    KBMessgeModulesUnReadRequest *request = [[KBMessgeModulesUnReadRequest alloc] initWithUserid:self.uid] ;
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBBaseModel *model = [KBBaseModel yy_modelWithDictionary:dict];
        if (complete) { complete(model); }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (failure)
            failure(request.error);
    }];
}

#pragma mark - 检查更新
-(void)checkVersionSuccess:(responseSuccessBlock_t)complete fail:(responseFailBlock_t)failure {
    KBCheckVersionRequest *request = [[KBCheckVersionRequest alloc] init];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        !complete ? : complete(dict);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        !failure ? : failure(request.error);
    }];
}

@end
