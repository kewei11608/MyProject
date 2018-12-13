//
//  KBTaskHouseDetailViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/6/3.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBTaskHouseDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "HouseDetailView.h"
#import "KBTaskHouseRefuseViewController.h"
#import "KBTaskHouseAgreeViewController.h"
#import "KBTaskRoomDetailViewController.h"
 #import "UIImageView+WebCache.h"
#import "KBAttributedStringTool.h"

@interface KBTaskHouseDetailViewController ()
@property (nonatomic,strong)HouseDetailView *mainView;
@property (nonatomic,assign)NSString * approvaid;
@property (nonatomic,strong)KBHouseDetailModel *houseDetailModel;
@property (nonatomic,assign) NSInteger  realtyid;
@property (nonatomic,assign) BOOL  isRecord;
@end

@implementation KBTaskHouseDetailViewController
- (instancetype)initApprovaid:(NSString *)approvaid record:(BOOL)isRecord
{
    self = [super init];
    if (!self) return nil;
    self.approvaid = approvaid;
    self.isRecord = isRecord;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomTitle:@"非流通房源转流通申请"];
    [self.view addSubview:self.mainView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 1)];
    [self.view addSubview:view];
    [self.mainView setAutoLayoutLeftToViewLeft:self.view constant:0];
    [self.mainView setAutoLayoutRightToViewRight:self.view constant:0];
    [self.mainView setAutoLayoutTopToViewBottom:view constant:0];
    [self.mainView setAutoLayoutBottomToViewBottom:self.view constant:0];
    [self api];
    if (!self.isRecord) {
        self.mainView.refuseBtn.hidden = YES;
        self.mainView.agreeBtn.hidden = YES;
        self.mainView.doneView.hidden = NO;
    }
    @KBWeakObj(self);
    self.mainView.roomDetailBlock = ^{
        @KBStrongObj(self);
        if (!self.realtyid) {
            return ;
        }
        KBTaskRoomDetailViewController  *vc = [[KBTaskRoomDetailViewController alloc] initRealtyid:self.realtyid];
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    self.mainView.refuseBlock = ^{
        @KBStrongObj(self);
        [KBUserBehavior behaviorEventId:KBHandleHousingRefuseEventId];
        [self pushToRefuse];
    };
    self.mainView.agreeBlock = ^{
        @KBStrongObj(self);
        [KBUserBehavior behaviorEventId:KBHandleHousingRefuseEventId];
        [self pushToAgreee];
        
    };
}

- (void)pushToAgreee
{
    if (!self.houseDetailModel) {
        return;
    }
    KBTaskHouseAgreeViewController *vc = [[KBTaskHouseAgreeViewController alloc] initRealtyid:[self.houseDetailModel.data.realtyid integerValue] approvaid:self.approvaid];
    [self.navigationController pushViewController:vc animated:YES];
    
    @KBWeakObj(self);
    vc.agreeControllerBlock = ^(NSString *str) {
        @KBStrongObj(self);

        [[KBApiLayer sharedInstance] taskHouseHandleApprovaid:self.approvaid decisiontype:0 input:str success:^(KBBaseModel* model) {
            if (model.code == 0){
               
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
                });
                
            }
             [KBAlter show:model.desc superView:self.view];
        } fail:^(NSError *error) {
            [KBAlter hideLoadingForView:self.view];
        }];
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [KBUserBehavior behaviorEventId:KBEnterHousingDetailEventId];
}

- (void)pushToRefuse
{
    KBTaskHouseRefuseViewController *vc = [[KBTaskHouseRefuseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    @KBWeakObj(self);
    vc.submitBlock = ^(NSString *input) {
         @KBStrongObj(self);
        [[KBApiLayer sharedInstance] taskHouseHandleApprovaid:self.approvaid decisiontype:1 input:input success:^(KBBaseModel* model) {
            if (model.code == 0){
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
                });
               
            }
            [KBAlter show:model.desc superView:self.view];
        } fail:^(NSError *error) {
            [KBAlter hideLoadingForView:self.view];
        }];
    };
}

- (void)updateUI:(KBHouseDetailModel *)model
{
    self.houseDetailModel = model;
    [self.mainView.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.data.agenthead] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
    self.mainView.nameLable.text = model.data.agentname==nil?model.data.username:model.data.agentname;
    self.mainView.officeNameLable.text = model.data.officename;
    self.mainView.numberIdLable.text =[NSString stringWithFormat:@"审批编号：%@",model.data.approvaid];
    self.mainView.numberTypeLable.text = @"审批类别：非流通房源转流通申请";
    self.mainView.launchTimeLable.text = [NSString stringWithFormat:@"发起时间：%@",model.data.launchtime];
    self.mainView.runTimeLable.text = [NSString stringWithFormat:@"执行日期：%@",model.data.createtime];
    self.mainView.roomCodeLable.text = [NSString stringWithFormat:@"  房源编号：%@",model.data.realtynum];
    self.mainView.propertyNameLable.text = [NSString stringWithFormat:@"  物业名称：%@",model.data.communityname];
    self.mainView.propertyTypeLable.text = [NSString stringWithFormat:@"  房源类型：%@",model.data.strrealtytype];
    self.mainView.explainLable.text = [NSString stringWithFormat:@"说明：%@",model.data.explains];
    self.realtyid = [model.data.realtyid integerValue];
    self.mainView.phone = model.data.agentphone;
//    说明：该经纪人提交的房源流通状态变更申请。将该房源的非流通状态修改为流通状态，请您确认。
    if (!self.isRecord) {
        [self.mainView.doneView.imgAgent  sd_setImageWithURL:[NSURL URLWithString:model.data.agenthead] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
        [self.mainView.doneView.imgAuditing  sd_setImageWithURL:[NSURL URLWithString:model.data.userhead] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
        NSString *launchtime =  model.data.launchtime;
        
        NSMutableArray *array  = [[NSMutableArray alloc] init];
        [array addObject: [KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%@  ", model.data.agentname] font:[UIFont systemFontOfSize:14] color:KBCOLOR_WITH_HEX(0x333333) ]];
        [array addObject: [KBAttributedStringModel initWithText:@"发起" font:[UIFont systemFontOfSize:14] color:KBCOLOR_WITH_HEX(0x666666) ]];
        self.mainView.doneView.labeAgentTitle.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array];
        
        NSMutableArray *array1  = [[NSMutableArray alloc] init];
        [array1 addObject: [KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%@.%@   %@:%@",[self getMonth:launchtime],[self getDay:launchtime],[self getHour:launchtime],[self getMin:launchtime]] font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x666666) ]];
        self.mainView.doneView.labeAgentSubTitle.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array1];
        
       NSMutableArray *array2  = [[NSMutableArray alloc] init];
        [array2 addObject: [KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%@  ", model.data.username] font:[UIFont systemFontOfSize:14] color:KBCOLOR_WITH_HEX(0x333333) ]];
        KBAttributedStringModel *aModel;
        if ([model.data.approvalstatus integerValue] == 0)
        {
            aModel =  [KBAttributedStringModel initWithText:@"待审批" font:[UIFont systemFontOfSize:14] color:[UIColor darkGrayColor]];
        }
        else if ([model.data.approvalstatus integerValue] == 1) {
            aModel =  [KBAttributedStringModel initWithText:@"审批通过" font:[UIFont systemFontOfSize:14] color:KBCOLOR_WITH_HEX(0x0AB768)];
        }
        else if ([model.data.approvalstatus integerValue] == 2){
            aModel =  [KBAttributedStringModel initWithText:@"申请拒绝" font:[UIFont systemFontOfSize:14] color:KBCOLOR_WITH_HEX(0xF22424)];
        }
        else if ([model.data.approvalstatus integerValue] == 3) {
            aModel =  [KBAttributedStringModel initWithText:@"离职处理" font:[UIFont systemFontOfSize:14] color:KBCOLOR_WITH_HEX(0xF22424)];
        }
        else if ([model.data.approvalstatus integerValue] == 4){
            aModel =  [KBAttributedStringModel initWithText:@"解除冻结" font:[UIFont systemFontOfSize:14] color:KBCOLOR_WITH_HEX(0x0AB768)];

        }
        [array2 addObject:aModel];
        self.mainView.doneView.labeAuditTitle.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array2];
        
        
        NSMutableArray *array3  = [[NSMutableArray alloc] init];
        [array3 addObject: [KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%@.%@   %@:%@",[self getMonth:model.data.audittime],[self getDay:model.data.audittime],[self getHour:model.data.audittime],[self getMin:model.data.audittime]] font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x666666) ]];
        self.mainView.doneView.labeAuditSubTitle.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array3];

        
    }
}

- (NSString *)getMonth:(NSString *)date
{
    if (date.length<7) {
        return @"00";
    }
    return [date substringWithRange:NSMakeRange(5, 2)];
}

- (NSString *)getDay:(NSString *)date
{
    if (date.length<10) {
        return @"00";
    }
    return [date substringWithRange:NSMakeRange(8, 2)];
}

- (NSString *)getHour:(NSString *)date
{
    if (date.length<13) {
        return @"00";
    }
    return [date substringWithRange:NSMakeRange(11, 2)];
}

- (NSString *)getMin:(NSString *)date
{
    if (date.length<16) {
        return @"00";
    }
    return [date substringWithRange:NSMakeRange(14, 2)];
}



- (void)api
{
    @KBWeakObj(self);
    [KBAlter showLoadingForView:self.view];
    if (self.isRecord) {
        [[KBApiLayer sharedInstance] taskHouseApprovaid:self.approvaid success:^(KBHouseDetailModel * model) {
            @KBStrongObj(self);
            [KBAlter hideLoadingForView:self.view];
            [self updateUI:model];
            
        } fail:^(NSError *error) {
             [KBAlter hideLoadingForView:self.view];
        }];
    }
    else
    {
        [[KBApiLayer sharedInstance] taskHouseDoneApprovaid:self.approvaid success:^(KBHouseDetailModel * model) {
            @KBStrongObj(self);
            [KBAlter hideLoadingForView:self.view];
            [self updateUI:model];
            
        } fail:^(NSError *error) {
             [KBAlter hideLoadingForView:self.view];
        }];
    }
}


- (HouseDetailView *)mainView {
    if (!_mainView) {
        _mainView = [HouseDetailView loadViewFrom:@"HouseDetailView"];
    }
    return _mainView;
}



@end
