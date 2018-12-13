//
//  KBUserBehaviorHeader.h
//  KuBoss
//
//  Created by yuyang on 2018/6/10.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#ifndef KBUserBehaviorHeader_h
#define KBUserBehaviorHeader_h

//static NSString * const KBRankEventId = @"click_ranking_list"; // 点击-排行榜
//static NSString * const KBWarEventId = @"click_more_war_newspapers"; // 点击-战报推送 更多
//// ======= 业务管理
//static NSString * const KBBusinessManagerSummaryEventId = @"entering_business_management_summary_ata_pages"; // 入业务管理-汇总数据页
//static NSString * const KBBusinessYesterdaysDataEventId = @"using_the_screening_bar_to_view_yesterdays_data"; // 使用筛选栏查看昨日数据
//static NSString * const KBBusinessWeeklyDataEventId = @"using_a_screening_bar_to_view_the_weekly_data"; // 使用筛选栏查看周数据
//static NSString * const KBBusinessMonthlyDataEventId = @"using_the_screening_bar_to_view_the_monthly_data"; // 使用筛选栏查看月数据
//static NSString * const KBMonthlyDataEventId = @"using_the_screening_bar_to_view_the_monthly_data"; // 使用筛选栏查看月数据
//static NSString * const KBEnterBusinessEventId = @"entering_the_business_data_page"; // 进入业务数据页面
//static NSString * const KBClickStoreListEventId = @"click_store_list"; // 点击-门店列表
//static NSString * const KBEnterResourceEventId = @"enter_the_resource_management_page"; // 进入资源管理页面
//static NSString * const KBSummaryDataEventId = @"using_the_screening_bar_to_view_the_summary_data"; //使用筛选栏查看汇总数据
//static NSString * const KBIndividualStoreDataEventId = @"using_a_screening_bar_to_view_individual_store_data"; //使用筛选栏查看单独门店数据
//// ======= 业务管理 - 门店
//static NSString * const KBEnterStorePageEventId = @"enter_the_store_information_page"; //进入门店信息页面
//static NSString * const KBStoreYesterdaysDataEventId = @"using_the_screening_bar_to_view_the_store_yesterday_data"; //使用筛选栏查看门店昨日数据
//static NSString * const KBStoreWeeklyDataEventId = @"using_a_screening_bar_to_view_the_store_weekly_data"; //使用筛选栏查看门店周数据
//static NSString * const KBStoreMonthlyDataEventId = @"using_the_screening_bar_to_view_the_store_monthly_data"; //使用筛选栏查看门店月数据
//// ======= 业务管理 - 门店 - 经纪人
//static NSString * const KBClickAgentListEventId = @"click_broker_list"; //点击-经纪人列表
//static NSString * const KBEnterAgentDetailEventId = @"enter_the_details_page_of_the_broker"; //进入经纪人详情页面
//static NSString * const KBClickAgentPhoneEventId = @"click_the_broker_call_button"; //点击经纪人呼叫按钮
//static NSString * const KBAgentYesterdaysDataEventId = @"using_a_screening_bar_to_view_yesterdays_brokers_data"; //使用筛选栏查看经纪人昨日数据
//static NSString * const KBAgentWeeklyDataEventId = @"using_a_screening_bar_to_view_the_weekly_brokers_data"; //使用筛选栏查看经纪人周数据
//static NSString * const KBAgentMonthlyDataEventId = @"using_the_screening_bar_to_view_the_monthly_brokers_data"; //使用筛选栏查看经纪人月数据,
//static NSString * const KBClickEmployeeDynamicsEventId = @"click_employee_dynamics_more"; //点击-员工动态 更多
//// ======= 低量化
//static NSString * const KBClickLQWaringEventId = @"click_low_quantify_early_warning_records_to_see_details"; //点击-低量化预警记录 查看详情
//static NSString * const KBEnterLQWaringPageEventId = @"enter_the_low_quantified_early_warning_page"; //进入低量化预警页面
//static NSString * const KBClickLQSettingEventId = @"click_settings"; //点击- 低量化设置
//static NSString * const KBClickMoreLQRecordsEventId = @"click_more_early_warning_records"; //点击-更多预警记录
//static NSString * const KBClickWeeklyLQEventId = @"look_at_the_weekly_low_warning"; //查看每周低量化预警
//static NSString * const KBRemindWeeklyLQAgentEventId = @"weekly_low_quantization_manually_send_reminder_to_low_brokers"; //每周低量化-向低量化经纪人手动发送提醒
//static NSString * const KBClickMonthlyLQEventId = @"view_the_monthly_low_warning"; //查看每月低量化预警
//static NSString * const KBRemindMonthlyLQAgentEventId = @"low_monthly_quantification_manual_reminders_to_low_brokers"; //每周低量化-向低量化经纪人手动发送提醒
//
//static NSString * const KBEnterLQRecordPageEventId = @"entering_a_low_quantized_early_warning_record_page,"; //进入低量化预警记录页面
//static NSString * const KBClickLQAgentDetialEventId = @"click_broker_to_see_the_details_of_early_warning"; //点击-经纪人查看预警详情
//static NSString * const KBClickLQAgentPhoneEventId = @"click_the_low_quantity_broker_call_button"; //点击经纪人呼叫按钮
//static NSString * const KBClickLQWeeklyListEventId = @"click_weekly_low_weight_view_list"; //点击-每周低量化查看列表
//static NSString * const KBClickLQMonthlyListEventId = @"click_monthly_low_Volume_view_list"; //点击-每月低量化查看列表
//// ======= 任务
//static NSString * const KBEnterTaskPageEventId = @"entering_the_task_approval_page"; //进入任务审批页面
//static NSString * const KBClickHousingCirculationEventId = @"clicking_housing_circulation"; //点击-房源流通
//static NSString * const KBClickFreezeEventId = @"click_account_freeze_processing"; //点击-账号冻结处理
//static NSString * const KEnterFreezeDetailEventId = @"access_to_the_account_freeze_processing_task_page"; //进入账号冻结处理任务页面,
//static NSString * const KBEnterHousingCirculationEventId = @"entry_into_the_housing_circulation_task_page"; //进入房源流通任务页面
//static NSString * const KBClickHousingCirculationRecordEventId = @"clicking_house_circulation_processing_record"; //点击-房源流通处理记录
//static NSString * const KBClickHousingItemEventId = @"the_task_in_the_click_list"; //点击-房源流通列表中的任务
//static NSString * const KBEnterHousingDetailEventId = @"entry_into_the_task_details_page"; //进入房源流通任务详情页面
//
//static NSString * const KBHandleHousingAdoptEventId = @"adopt"; //房源流通-通过
//static NSString * const KBHandleHousingRefuseEventId = @"refuse"; //房源流通-拒绝

static NSString * const KBRankEventId = @"点击-排行榜"; // 点击-排行榜
static NSString * const KBWarEventId = @"点击-战报推送 更多"; // 点击-战报推送 更多
// ======= 业务管理
static NSString * const KBBusinessManagerSummaryEventId = @"入业务管理-汇总数据页"; // 入业务管理-汇总数据页
static NSString * const KBBusinessYesterdaysDataEventId = @"使用筛选栏查看昨日数据"; // 使用筛选栏查看昨日数据
static NSString * const KBBusinessWeeklyDataEventId = @"使用筛选栏查看周数据"; // 使用筛选栏查看周数据
static NSString * const KBBusinessMonthlyDataEventId = @"使用筛选栏查看月数据"; // 使用筛选栏查看月数据
static NSString * const KBMonthlyDataEventId = @"使用筛选栏查看月数据"; // 使用筛选栏查看月数据
static NSString * const KBEnterBusinessEventId = @"进入业务数据页面"; // 进入业务数据页面
static NSString * const KBClickStoreListEventId = @"点击-门店列表"; // 点击-门店列表
static NSString * const KBEnterResourceEventId = @"进入资源管理页面"; // 进入资源管理页面
static NSString * const KBSummaryDataEventId = @"使用筛选栏查看汇总数据"; //使用筛选栏查看汇总数据
static NSString * const KBIndividualStoreDataEventId = @"使用筛选栏查看单独门店数据"; //使用筛选栏查看单独门店数据
// ======= 业务管理 - 门店
static NSString * const KBEnterStorePageEventId = @"进入门店信息页面"; //进入门店信息页面
static NSString * const KBStoreYesterdaysDataEventId = @"使用筛选栏查看门店昨日数据"; //使用筛选栏查看门店昨日数据
static NSString * const KBStoreWeeklyDataEventId = @"使用筛选栏查看门店周数据"; //使用筛选栏查看门店周数据
static NSString * const KBStoreMonthlyDataEventId = @"使用筛选栏查看门店月数据"; //使用筛选栏查看门店月数据
// ======= 业务管理 - 门店 - 经纪人
static NSString * const KBClickAgentListEventId = @"点击-经纪人列表"; //点击-经纪人列表
static NSString * const KBEnterAgentDetailEventId = @"进入经纪人详情页面"; //进入经纪人详情页面
static NSString * const KBClickAgentPhoneEventId = @"点击经纪人呼叫按钮"; //点击经纪人呼叫按钮
static NSString * const KBAgentYesterdaysDataEventId = @"使用筛选栏查看经纪人昨日数据"; //使用筛选栏查看经纪人昨日数据
static NSString * const KBAgentWeeklyDataEventId = @"使用筛选栏查看经纪人周数据"; //使用筛选栏查看经纪人周数据
static NSString * const KBAgentMonthlyDataEventId = @"使用筛选栏查看经纪人月数据"; //使用筛选栏查看经纪人月数据,
static NSString * const KBClickEmployeeDynamicsEventId = @"点击-员工动态 更多"; //点击-员工动态 更多
// ======= 低量化
static NSString * const KBClickLQWaringEventId = @"点击-低量化预警记录 查看详情"; //点击-低量化预警记录 查看详情
static NSString * const KBEnterLQWaringPageEventId = @"进入低量化预警页面"; //进入低量化预警页面
static NSString * const KBClickLQSettingEventId = @"点击- 低量化设置"; //点击- 低量化设置
static NSString * const KBClickMoreLQRecordsEventId = @"点击-更多预警记录"; //点击-更多预警记录
static NSString * const KBClickWeeklyLQEventId = @"查看每周低量化预警"; //查看每周低量化预警
static NSString * const KBRemindWeeklyLQAgentEventId = @"每周低量化-向低量化经纪人手动发送提醒"; //每周低量化-向低量化经纪人手动发送提醒
static NSString * const KBClickMonthlyLQEventId = @"查看每月低量化预警"; //查看每月低量化预警
static NSString * const KBRemindMonthlyLQAgentEventId = @"每周低量化-向低量化经纪人手动发送提醒"; //每周低量化-向低量化经纪人手动发送提醒

static NSString * const KBEnterLQRecordPageEventId = @"每周低量化-向低量化经纪人手动发送提醒"; //进入低量化预警记录页面
static NSString * const KBClickLQAgentDetialEventId = @"点击-经纪人查看预警详情"; //点击-经纪人查看预警详情
static NSString * const KBClickLQAgentPhoneEventId = @"点击经纪人呼叫按钮"; //点击经纪人呼叫按钮
static NSString * const KBClickLQWeeklyListEventId = @"点击-每周低量化查看列表"; //点击-每周低量化查看列表
static NSString * const KBClickLQMonthlyListEventId = @"点击-每月低量化查看列表"; //点击-每月低量化查看列表
// ======= 任务
static NSString * const KBEnterTaskPageEventId = @"进入任务审批页面"; //进入任务审批页面
static NSString * const KBClickHousingCirculationEventId = @"点击-房源流通"; //点击-房源流通
static NSString * const KBClickFreezeEventId = @"点击-账号冻结处理"; //点击-账号冻结处理
static NSString * const KEnterFreezeDetailEventId = @"进入账号冻结处理任务页面"; //进入账号冻结处理任务页面,
static NSString * const KBEnterHousingCirculationEventId = @"进入房源流通任务页面"; //进入房源流通任务页面
static NSString * const KBClickHousingCirculationRecordEventId = @"点击-房源流通处理记录"; //点击-房源流通处理记录
static NSString * const KBClickHousingItemEventId = @"点击-房源流通列表中的任务"; //点击-房源流通列表中的任务
static NSString * const KBEnterHousingDetailEventId = @"进入房源流通任务详情页面"; //进入房源流通任务详情页面

static NSString * const KBHandleHousingAdoptEventId = @"房源流通-通过"; //房源流通-通过
static NSString * const KBHandleHousingRefuseEventId = @"房源流通-拒绝"; //房源流通-拒绝
#endif /* KBUserBehaviorHeader_h */
