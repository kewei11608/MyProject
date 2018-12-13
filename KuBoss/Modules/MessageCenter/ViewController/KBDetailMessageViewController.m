//
//  KBDeatilMessageViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/9.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBDetailMessageViewController.h"
#import "KBWebView.h"
#import "KBShare.h"
#import "MJRefresh.h"
#import "KBShareSuccessRequest.h"

@interface KBDetailMessageViewController ()<UIActionSheetDelegate>
@property (nonatomic,copy) NSString *messageId;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *shareUrl;
@property (nonatomic,assign)NSInteger indexPage;
@property (nonatomic,assign)BOOL isClear;
@end

@implementation KBDetailMessageViewController
- (instancetype)initMessageId:(NSString *)messageId type:(NSString *)type
{
    self = [super init];
    if (!self) return nil;
    self.messageId = messageId;
    self.type = type;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.type integerValue] == 1) {
        [self setCustomTitle:@"站内消息"];
    }
    else{
       [self setCustomTitle:@"消息详情"];
    }

    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    KBWebView *webView = [[KBWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height - self.navigationController.navigationBar.ct_bottom-[[UIApplication sharedApplication] statusBarFrame].size.height)];
    [self.view addSubview:webView];
    
    NSString *url = [NSString stringWithFormat:@"%@%@/message_detail?messageid=%@&type=%@&userid=%@",httpApi,httpFilePath,self.messageId,self.type,[KBUserInfoModel encodeUid]];
    [webView loadRequestUrl:url];
    
    self.shareUrl = url;
    
    if ([self.type  integerValue] ==1 && self.sharetf == 0) {
        UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBut.frame =CGRectMake(0,0, 22, 22);
        [rightBut setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [rightBut addTarget:self action:@selector(onClickRightMenu) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * rightButItem = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
        self.navigationItem.rightBarButtonItem = rightButItem;
    }

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareSuccess) name:@"WXShareSuccess" object:@"WXShare"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXShareSuccess" object:@"WXShare"];
}

- (void)shareSuccess {
    KBShareSuccessRequest *request = [[KBShareSuccessRequest alloc] initWithStationsId:self.messageId];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"%@", request.responseObject);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)onClickRightMenu
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"分享到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信好友",@"微信朋友圈", nil];
    
    // 用tag值来分辨是代理方法调用时哪个actionSheet
    sheet.tag = 10;
    
    [sheet showInView:self.view];
    
}
#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [KBShare shareScene:0 title:self.messageTitle url:self.shareUrl content:self.content imgurl:self.imgurl];
    }
    else if(buttonIndex == 1){
        [KBShare shareScene:1 title:self.messageTitle url:self.shareUrl content:self.content imgurl:self.imgurl];
    }
    
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
