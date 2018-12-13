//
//  KBApiLayer.h
//  KuBoss
//
//  Created by yuyang on 2018/5/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBBaseModel.h"
#import "KBBanerModel.h"
#import "KBWarReportModel.h"
#import "KBRankModel.h"
#import "KBResourceManagerModel.h"
#import "KBLQModel.h"
#import "KBEDModel.h"
#import "KBShopAgentModel.h"
#import "KBUserInfoModel.h"
#import "KBRBHomeModel.h"
#import "KBShopModel.h"
#import "KBFilterDateModel.h"
#import "KBIndicatorConcernModel.h"
#import "KBLQUserConfigModel.h"
#import "KBLQRootModel.h"
#import "KBManagerModel.h"
#import "KBLQRecordModel.h"
#import "KBLQDetailModel.h"
#import "KBLQItemModel.h"
#import "KBAccountFreezeListModel.h"
#import "KBAccountFreezeDetailModel.h"
#import "KBAccountFreezeRecordListModel.h"
#import "KBHandleLeaveOfficeModel.h"
#import "KBAnnouncementModel.h"
#import "KBMessageMoudulesModel.h"
#import "KBStationModel.h"
#import "KBHouseDetailModel.h"
#import "KBRoomModel.h"
#import "KBMessgeUnreadModel.h"
#import "KBPermissionModel.h"

/**
请求成功回调

 @param model  数据载体
 */
typedef void (^responseSuccessBlock_t)(id model);


/**
 请求失败回调

 */
typedef void (^responseFailBlock_t)(NSError *error);

@interface KBApiLayer : NSObject

+ (instancetype)sharedInstance;

/**
 控制台-banner
 */
- (void)bannerSuccess:(responseSuccessBlock_t) complete
                 fail:(responseFailBlock_t)failure;

// 传入0查询登录人关注的3个指标，传入1查询所有指标 //2

/**
 指标获取

 @param type  0 获取 关注， 1 获取所有
 */
- (void)checkType:(NSString *)type
          success:(responseSuccessBlock_t) complete
             fail:(responseFailBlock_t)failure;
/**
 战报

 @param page 当前页数
 @param size 请求大小
 */
- (void)warReportPage:(NSInteger )page
                 size:(NSInteger )size
              success:(responseSuccessBlock_t) complete
                 fail:(responseFailBlock_t)failure;


/**
 排行榜

 @param tradetype 0 total , 1 
 @param page 当前页数
 @param size 请求大小
 */
- (void)rankTradeType:(NSInteger)tradetype
                 page:(NSInteger)page
                 size:(NSInteger)size
                month:(NSString *)month
              success:(responseSuccessBlock_t) complete
                 fail:(responseFailBlock_t)failure;
//5
- (void)followWithType:(NSInteger)type
               success:(responseSuccessBlock_t) complete
                  fail:(responseFailBlock_t)failure;
//6
- (void)followSetting:(NSString *)targetType
              success:(responseSuccessBlock_t) complete
                 fail:(responseFailBlock_t)failure;
//7
- (void)resourceWithOfficeid:(NSString *)officeid
                     success:(responseSuccessBlock_t) complete
                        fail:(responseFailBlock_t)failure;


//========================= user

- (void)loginWithUserCode:(NSString *)userCode
                 Password:(NSString *)password
                  success:(responseSuccessBlock_t) complete
                     fail:(responseFailBlock_t)failure;

- (void)loginOutSuccess:(responseSuccessBlock_t) complete
                   fail:(responseFailBlock_t)failure;

- (void)loginShopSuccess:(responseSuccessBlock_t) complete
                   fail:(responseFailBlock_t)failure;

//send code
- (void)sendSmsCodeWithPhone:(NSString *)phone
            success:(responseSuccessBlock_t) complete
               fail:(responseFailBlock_t)failure;


- (void)validateSmsCodeWithPassword:(NSString *)password
                               code:(NSString *)code
                            success:(responseSuccessBlock_t) complete
                               fail:(responseFailBlock_t)failure;

- (void)modifyPhone:(NSString *)phone
               code:(NSString *)code
           password:(NSString *)password
            success:(responseSuccessBlock_t) complete
               fail:(responseFailBlock_t)failure;

- (void)validatePassword:(NSString *)password
                 success:(responseSuccessBlock_t) complete
                    fail:(responseFailBlock_t)failure;

- (void)modifyOldPassword:(NSString *)pwdOld
           newPassword:(NSString *)pwdNew
               success:(responseSuccessBlock_t) complete
                  fail:(responseFailBlock_t)failure;


//=========================resourse


- (void)resourceManagerHomeTimeType:(NSInteger) timeType
                          dataRange:(NSInteger) dataRange
                        housingType:(NSInteger) housingType
                            success:(responseSuccessBlock_t) complete
                               fail:(responseFailBlock_t)failure;


- (void)shopTimeType:(NSInteger) timeType
                           officeid:(NSString *) officeid
                          dataRange:(NSInteger) dataRange
                        housingType:(NSInteger) housingType
                            success:(responseSuccessBlock_t) complete
                               fail:(responseFailBlock_t)failure;

- (void)filterDateSuccess:(responseSuccessBlock_t) complete
                     fail:(responseFailBlock_t)failure;



/**
 员工动态
 */
- (void)edWithType:(NSInteger)type
          agentid :(NSInteger)agentid
              page:(NSInteger)page
           success:(responseSuccessBlock_t) complete
              fail:(responseFailBlock_t) failure;
//10
- (void)shopAgentid:(NSInteger) agentid
           timetype:(NSInteger) timetype
          daterange:(NSInteger)daterange
        housingtype:(NSInteger)housingtype
            success:(responseSuccessBlock_t) complete
               fail:(responseFailBlock_t)failure;

- (void)managerOfficeid:(NSString *)officeid
                success:(responseSuccessBlock_t) complete
                   fail:(responseFailBlock_t)failure;


//8
- (void)lqAgentid:(NSString *)agentid
          success:(responseSuccessBlock_t) complete
             fail:(responseFailBlock_t)failure;

//=========================lq

- (void)lqConfigSuccess:(responseSuccessBlock_t) complete
                   fail:(responseFailBlock_t)failure;


- (void)lqRootTimeType:(NSInteger) timetype
               success:(responseSuccessBlock_t) complete
                  fail:(responseFailBlock_t)failure;



- (void)lqSaveConfigweeklyReminderTime:(NSString *)weeklyReminderTime
                    monthRemindingTime:(NSString *)monthRemindingTime
                            remindingz:(NSInteger)remindingz
                            remindingy:(NSInteger)remindingy
                            listString:(NSString*)listString
                            noticetype:(NSInteger)noticetype
                               success:(responseSuccessBlock_t) complete
                                  fail:(responseFailBlock_t)failure;


- (void)lqRecordListSuccess:(responseSuccessBlock_t) complete
                       fail:(responseFailBlock_t)failure;

- (void)lqDetailTimetype:(NSInteger)timetype
                 agentid:(NSInteger)agentid
                 success:(responseSuccessBlock_t) complete
                    fail:(responseFailBlock_t)failure;

- (void)lqItemAgentid:(NSInteger)agentid
 lowquantificationrid:(NSInteger)lowquantificationrid
              success:(responseSuccessBlock_t) complete
                 fail:(responseFailBlock_t)failure;

//========= task

- (void)taskAccountFreezelistSuccess:(responseSuccessBlock_t)complete
                                fail:(responseFailBlock_t)failure;

- (void)taskAccountFreezeDetailAccountid:(NSInteger)accountid
                                 success:(responseSuccessBlock_t)complete
                                    fail:(responseFailBlock_t)failure;

- (void)taskAccountFreezelistRecordSuccess:(responseSuccessBlock_t)complete
                                      fail:(responseFailBlock_t)failure;

- (void)taskRelieveAccountFreezeAccountid:(NSInteger)accountid
                                 success:(responseSuccessBlock_t)complete
                                    fail:(responseFailBlock_t)failure;

- (void)taskHandleLeaveOfficeAccountid:(NSInteger)accountid
                                  success:(responseSuccessBlock_t)complete
                                     fail:(responseFailBlock_t)failure;

- (void)taskHandleLeaveOfficeAccountid:(NSString *)accountid
                                reason:(NSString *)reason
                             approvaid:(NSString *)approvaid
                        separationdate:(NSString *)separationdate
                               success:(responseSuccessBlock_t)complete
                                  fail:(responseFailBlock_t)failure;

- (void)taskFreezeRecordDetailsApprovaid:(NSString *)approvaid
                                 success:(responseSuccessBlock_t)complete
                                    fail:(responseFailBlock_t)failure;



- (void)taskHouseListSuccess:(responseSuccessBlock_t)complete
                        fail:(responseFailBlock_t)failure;

- (void)taskHouseListRecordSuccess:(responseSuccessBlock_t)complete
                        fail:(responseFailBlock_t)failure;

- (void)taskRoomDetailRealtyid:(NSInteger)realtyid
                       success:(responseSuccessBlock_t)complete
                          fail:(responseFailBlock_t)failure;

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
                            fail:(responseFailBlock_t)failure;


//非流通详情
- (void)taskHouseApprovaid:(NSString*)approvaid
                   success:(responseSuccessBlock_t)complete
                      fail:(responseFailBlock_t)failure;

// 处理 非流通
- (void)taskHouseHandleApprovaid:(NSString *)approvaid
                  decisiontype:(NSInteger)decisiontype
                           input:(NSString *)input
                         success:(responseSuccessBlock_t)complete
                            fail:(responseFailBlock_t)failure;

- (void)taskNoReadNoSuccess:(responseSuccessBlock_t)complete
                  fail:(responseFailBlock_t)failure;

- (void)taskHouseDoneApprovaid:(NSString*)approvaid
                       success:(responseSuccessBlock_t)complete
                          fail:(responseFailBlock_t)failure;

//======================message
//公告
- (void)messageAnnouncementAreaCode:(NSString *)areaCode
                          pageIndex:(NSInteger) pageIndex
                           pageSize:(NSInteger)pageSize
                            success:(responseSuccessBlock_t)complete
                               fail:(responseFailBlock_t)failure;

- (void)messageMoudulespageIndex:(NSInteger) pageIndex
                        pageSize:(NSInteger)pageSize
                         success:(responseSuccessBlock_t)complete
                            fail:(responseFailBlock_t)failure;

- (void)messageStationAreaCode:(NSString *)areaCode
                     pageIndex:(NSInteger) pageIndex
                      pageSize:(NSInteger)pageSize
                       success:(responseSuccessBlock_t)complete
                          fail:(responseFailBlock_t)failure;

- (void)messageAreaCode:(NSInteger) code
                success:(responseSuccessBlock_t)complete
                   fail:(responseFailBlock_t)failure;

- (void)jPushRegist:(NSString *)jPushID
            success:(responseSuccessBlock_t)complete
               fail:(responseFailBlock_t)failure;

- (void)messageModuleSuccess:(responseSuccessBlock_t)complete
                   fail:(responseFailBlock_t)failure;

#pragma mark - 检查更新
- (void)checkVersionSuccess:(responseSuccessBlock_t)complete
                       fail:(responseFailBlock_t)failure;

@end
