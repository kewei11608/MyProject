//
//  KBTaskFreezeDetailVC.m
//  KuBoss
//
//  Created by yuyang on 2018/5/26.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBTaskFreezeDetailVC.h"
#import "FreezeDetailView.h"
#import "UIImageView+WebCache.h"
#import "KBTaskLeaveOfficeViewController.h"
 #import "UIImageView+WebCache.h"

@interface KBTaskFreezeDetailVC ()
@property (nonatomic,strong)FreezeDetailView *mainView;
@property (nonatomic,copy)NSString *accountId;
@property (nonatomic,assign)BOOL isHandle;
@property (nonatomic,copy) NSString * agentName;
@property (nonatomic,strong)HouseDoneView *doneView;
@property (nonatomic, copy) NSString *approvaid;
@end

@implementation KBTaskFreezeDetailVC

- (instancetype)initAccountId:(NSString *)accountId handle:(BOOL) isHandle
{
    self = [super init];
    if (!self) return nil;
    self.accountId = accountId;
    self.isHandle = isHandle;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomTitle:@"账号三日未登录冻结处理"];
   
    [self.view addSubview:self.mainView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.ct_width, 1)];
    [self.view addSubview:view];
    [self.mainView setAutoLayoutLeftToViewLeft:self.view constant:0];
    [self.mainView setAutoLayoutRightToViewRight:self.view constant:0];
    [self.mainView setAutoLayoutTopToViewBottom:view constant:0];
    [self.mainView setAutoLayoutBottomToViewBottom:self.view constant:0];
    if (!self.isHandle) {
        self.mainView.freezeBtn.hidden = YES;
        self.mainView.leaveBtn.hidden = YES;
    }
    // Do any additional setup after loading the view.
    [self detailApi];
    @KBWeakObj(self);
    self.mainView.freezeBlock = ^{
        @KBStrongObj(self);
        [self freezeApi];
    };
    self.mainView.leaveBlock = ^{
        @KBStrongObj(self);
        KBTaskLeaveOfficeViewController *vc = [[KBTaskLeaveOfficeViewController alloc]initWithAccountid:[self.accountId integerValue] agentName:self.agentName];
        vc.approvaid = self.approvaid;
        [self.navigationController pushViewController:vc animated:YES];
    };
}

- (void)freezeApi
{
   
    [[KBApiLayer sharedInstance] taskRelieveAccountFreezeAccountid:[self.accountId integerValue] success:^(KBAccountFreezeDetailModel * model) {
        [KBAlter  show:model.desc superView:self.view];
        if (model.code == 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToViewController:self.navigationController.childViewControllers[1] animated:YES];
            });
        }
    } fail:^(NSError *error) {
        [KBAlter hideLoadingForView:self.view];
    }];
}

- (void)detailApi
{
    [KBAlter showLoadingForView:self.view];
    if (self.isHandle) {
        [[KBApiLayer sharedInstance] taskAccountFreezeDetailAccountid:[self.accountId integerValue] success:^(KBAccountFreezeDetailModel * model) {
            [self handleData:model];
            
            [KBAlter hideLoadingForView:self.view];
        } fail:^(NSError *error) {
            
            [KBAlter hideLoadingForView:self.view];
        }];
    }
    else
    {
        [[KBApiLayer sharedInstance] taskFreezeRecordDetailsApprovaid:self.accountId success:^(KBAccountFreezeDetailModel * model) {
            [self handleData:model];
            
            [KBAlter hideLoadingForView:self.view];
        } fail:^(NSError *error) {
            
            [KBAlter hideLoadingForView:self.view];
        }];
    }

}

- (void)handleData:(KBAccountFreezeDetailModel *) model
{
    [self.mainView.avatarImg sd_setImageWithURL:[NSURL URLWithString:model.data.agenthead] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
    self.mainView.agentNameLable.text = model.data.agentname;
    self.mainView.shopNameLable.text = model.data.officename;
    self.mainView.iphone = model.data.agentphone;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    self.agentName  = model.data.agentname;
    
    [array addObject:[self getPreString: @"审批编号:" postString:model.data.approvaid]];
    self.approvaid = model.data.approvaid;
//    if (self.isHandle) {
    [array addObject:[self getPreString: @"审批类别:" postString:model.data.approveType]];
//    [array addObject:[self getPreString: @"审批类别:" postString:@"账号三日未登录冻结处理"]];
    //    }
    [array addObject:[self getPreString: @"发起时间:" postString:model.data.frozentime.length > 16 ? [model.data.frozentime substringWithRange:NSMakeRange(0, 16)] : model.data.frozentime]];
    [array addObject:[self getPreString: @"员工编号:" postString:model.data.agentcode]];
    [array addObject:[self getPreString: @"员工姓名:" postString:model.data.agentname]];
    [array addObject:[self getPreString: @"拼      音:" postString:model.data.englishname]];
    [array addObject:[self getPreString: @"部      门:" postString:model.data.deptname]];
    [array addObject:[self getPreString: @"职      位:" postString:model.data.postname]];
        //[array addObject:[self getPreString: @"角      色:" postString:@"缺字段"]];
    [array addObject:[self getPreString: @"C C C N :" postString:model.data.cccncode]];
    [array addObject:[self getPreString: @"手机号码 :" postString:model.data.agentphone]];
        //[array addObject:[self getPreString: @"登 录 名:" postString:@"缺字段"]];
    [array addObject:[self getPreString: @"入职日期:" postString:model.data.entrytime]];
    [array addObject:[self getPreString: @"在职情况:" postString:[model.data.agenttype integerValue] == 0?@"在职":@"离职"]];
    [array addObject:[self getPreString: @"账号状态:" postString:[model.data.agentstatus integerValue] == 0?@"正常":[model.data.agentstatus integerValue] == 1?@"注销":[model.data.agentstatus integerValue] == 2?@"冻结":@""]];
    [array addObject:[self getPreString: @"说       明:" postString:model.data.explain]];
    
    
    [self.mainView setArray:array];
    
    
    
    if (!self.isHandle) {
        self.mainView.tbView.tableFooterView = self.doneView;
        [self.doneView.imgAgent  sd_setImageWithURL:[NSURL URLWithString:model.data.agenthead] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
        [self.doneView.imgAuditing  sd_setImageWithURL:[NSURL URLWithString:model.data.userhead] placeholderImage:[UIImage imageNamed:@"defaultUserImg"]];
        NSString *launchtime =  model.data.launchtime;
        
        NSMutableArray *array  = [[NSMutableArray alloc] init];
        [array addObject: [KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%@  ", model.data.agentname] font:[UIFont systemFontOfSize:14] color:KBCOLOR_WITH_HEX(0x333333) ]];
        [array addObject: [KBAttributedStringModel initWithText:@"发起" font:[UIFont systemFontOfSize:14] color:KBCOLOR_WITH_HEX(0x666666) ]];
        self.doneView.labeAgentTitle.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array];
        
        NSMutableArray *array1  = [[NSMutableArray alloc] init];
        [array1 addObject: [KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%@.%@   %@:%@",[self getMonth:launchtime],[self getDay:launchtime],[self getHour:launchtime],[self getMin:launchtime]] font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x666666) ]];
        self.doneView.labeAgentSubTitle.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array1];
        
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
        self.doneView.labeAuditTitle.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array2];
        
        
        NSMutableArray *array3  = [[NSMutableArray alloc] init];
        [array3 addObject: [KBAttributedStringModel initWithText:[NSString stringWithFormat:@"%@.%@   %@:%@",[self getMonth:model.data.audittime],[self getDay:model.data.audittime],[self getHour:model.data.audittime],[self getMin:model.data.audittime]] font:[UIFont systemFontOfSize:13] color:KBCOLOR_WITH_HEX(0x666666) ]];
        self.doneView.labeAuditSubTitle.attributedText = [KBAttributedStringTool conversionAttributedStringFromModelArray:array3];
        
        
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

- (FreezeDetailCellModel *)getPreString:(NSString *)preString  postString:(NSString *)postString
{
    FreezeDetailCellModel *cellModel = [[FreezeDetailCellModel alloc]init];
    cellModel.preString = preString;
    cellModel.postString= postString;
    return cellModel;
}



- (FreezeDetailView *)mainView {
    if (!_mainView) {
        _mainView = [FreezeDetailView loadViewFrom:@"FreezeDetailView"];
    }
    return _mainView;
}


- (HouseDoneView *)doneView {
    if (!_doneView) {
        _doneView = [HouseDoneView loadViewFrom:@"HouseDoneView"];
    }
    return _doneView;
}
@end
