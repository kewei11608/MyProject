//
//  KBLowQuantificationViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/11.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBLowQuantificationViewController.h"
#import "KBWebView.h"
#import "KBLQDetailViewController.h"
#import "KBRootViewController.h"
#import "KBLQItemViewController.h"

@interface KBLowQuantificationViewController ()<KBWebViewDelegate>

@property (nonatomic, strong) KBWebView *webView;

@end

@implementation KBLowQuantificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupSubViews]; 
    [self setCustomTitle:@"低量化预警"];
    self.automaticallyAdjustsScrollViewInsets=NO;
    NSString *url = [NSString stringWithFormat:@"%@%@/low_target?userid=%@&isGranted=%d",httpApi,httpFilePath,[KBUserInfoModel encodeUid],YES];
    [self.webView loadRequestUrl:url];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [KBUserBehavior  behaviorEventId:KBEnterLQWaringPageEventId];
    
}


- (void)setupSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame =CGRectMake(0,0, 22, 22);
    [rightBut setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(onClickRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *rightButItem = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightButItem;
    
    

    
    KBWebView *webView = [[KBWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height)];
    [self.view addSubview:webView];
    self.webView = webView;
    webView.delegate = self;
//    NSString *url = [NSString stringWithFormat:@"%@%@/low_target?userid=%@&isGranted=%d",httpApi,httpFilePath,[KBUserInfoModel encodeUid],[[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeLowQuantificationAnalysis]];
//    NSString *url = [NSString stringWithFormat:@"%@%@/low_target?userid=%@&isGranted=%d",httpApi,httpFilePath,[KBUserInfoModel encodeUid],YES];
//    [webView loadRequestUrl:url];
}


#pragma mark - WKNavigationDelegate

- (BOOL)webView:(WKWebView *)webView decidePolicyForUrl:(NSString *)url decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if ([url containsString:@"low_target_more"]) {
        [KBUserBehavior  behaviorEventId:KBClickMoreLQRecordsEventId];
        [self.navigationController pushViewController:[NSClassFromString(@"KBLQMoreViewController") new] animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
        return NO;
    }
    else if ([url containsString:@"low_target_detial"])
    {
        NSString * agentid = @"";
        NSString * lowquantificationrid = @"";
        BOOL isMonth = NO;
        NSArray *array = [url componentsSeparatedByString:@"?"];
        if (array.count >= 2) {
            NSString *parameters = [array objectAtIndex:1];
            NSArray *arr1 = [parameters componentsSeparatedByString:@"&"];
            for (NSInteger i = 0; i < arr1.count; i++) {
                NSString *subParameters = [arr1 objectAtIndex:i];
                NSArray *arr2 = [subParameters componentsSeparatedByString:@"="];
                if (arr2.count == 2&& [arr2[0] isEqualToString:@"agentid"]) {
                    agentid = [arr2 objectAtIndex:1];
                }
                if (arr2.count == 2&& [arr2[0] isEqualToString:@"lowquantificationrid"]) {
                    lowquantificationrid = [arr2 objectAtIndex:1];
                }
                if (arr2.count == 2&& [arr2[0] isEqualToString:@"RefreshType"]) {
                    isMonth = ([arr2[1] integerValue] == 2);
                }
                
            }
        }
        [KBUserBehavior  behaviorEventId:KBClickLQWaringEventId];
        KBLQItemViewController *vc = [[KBLQItemViewController alloc] initBool:isMonth agentId:[agentid integerValue] lqid:[lowquantificationrid integerValue]];
        vc.block = ^(BOOL isMonth) {
            NSString *url = [NSString stringWithFormat:@"%@%@/low_target?userid=%@&isGranted=%d&RefreshType=%d",httpApi,httpFilePath,[KBUserInfoModel encodeUid],YES, isMonth + 1];
            [self.webView loadRequestUrl:url];
        };
        [self.navigationController pushViewController:vc animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
        return NO;
    }
    self.webView.currentUrl = url;
    NSLog(@"%@", url);
    return YES;
}

#pragma mark - event response 所有触发的事件响应 按钮、通知、分段控件等
- (void)onClickRightMenu
{
//      if ([[KBRootViewController sharedInstaced] isHavaPermission:PermissionCodeLowQuantificationSet])
//      {
          [KBUserBehavior  behaviorEventId:KBClickWeeklyLQEventId];
          [self.navigationController pushViewController:[NSClassFromString(@"KBLQSettingListViewController") new] animated:YES];
//      }
   
}




@end
