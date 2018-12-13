//
//  KBTaskMainViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/5/23.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBTaskMainViewController.h"
#import "TaskMainView.h"
#import "KBRootViewController.h"
#import "KBTaskNumberRequest.h"
#import "KBTaskNumberModel.h"
#import "WZLBadgeImport.h"
@interface KBTaskMainViewController ()
@property (nonatomic,strong)TaskMainView *mainView;

@end

@implementation KBTaskMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setCustomTitle:@"任务审批"];
    [self.view addSubview:self.mainView];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, 1)];
    [self.view addSubview:view];
    [self.mainView setAutoLayoutLeftToViewLeft:self.view constant:0];
    [self.mainView setAutoLayoutRightToViewRight:self.view constant:0];
    [self.mainView setAutoLayoutTopToViewBottom:view constant:0];
    [self.mainView setAutoLayoutBottomToViewBottom:self.view constant:0];
    // Do any additional setup after loading the view from its nib.
    @KBWeakObj(self);
    self.mainView.clickTask = ^(NSInteger index) {
        @KBStrongObj(self);
        switch (index) {
            case 0:
            {
                
                if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeHouseCirculation]){
                    [KBUserBehavior behaviorEventId:KBClickHousingCirculationEventId];
                    [self.navigationController pushViewController:[NSClassFromString(@"KBTaskHouseViewController") new] animated:YES];
                }
         
            }
          
                break;
            case 1:
            {
                if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeAccountStop]){
                    [KBUserBehavior behaviorEventId:KBClickFreezeEventId];
                    [self.navigationController pushViewController:[NSClassFromString(@"KBTaskAcounttFreezeViewController") new] animated:YES];
                }
               
            }
                break;
            case 2: {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂无其他的任务哦！" message:@"点击确认返回当前页面。" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:alertAction];
                [self showDetailViewController:alert sender:nil];
                break;
            }
            default:
                break;
        }
       
    };
    
    
}

- (void)request{
    
    
    KBTaskNumberRequest *request = [[KBTaskNumberRequest alloc] initWithUserid:[KBUserInfoModel uid]];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dict = request.responseJSONObject;
        KBTaskNumberModel *model = [KBTaskNumberModel yy_modelWithDictionary:dict];
        
        [self.mainView.houseImg showBadgeWithStyle:WBadgeStyleNumber value:[model.data.hcnumber integerValue] animationType:WBadgeAnimTypeNone];
        [self.mainView.accountImg showBadgeWithStyle:WBadgeStyleNumber value:[model.data.freezeCount integerValue] animationType:WBadgeAnimTypeNone];
        
      
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
      
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self request];
}

- (TaskMainView *)mainView {
    if (!_mainView) {
        _mainView = [TaskMainView loadViewFrom:@"TaskMainView"];
    }
    return _mainView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
