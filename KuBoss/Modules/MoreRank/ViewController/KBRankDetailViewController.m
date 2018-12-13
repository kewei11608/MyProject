//
//  KBRankDetailViewController.m
//  KuBoss
//
//  Created by yuyang on 2018/4/5.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBRankDetailViewController.h"
#import "KBRankListTopCell.h"
#import "KBWebView.h"
#import "KBRankLastViewController.h"

#import "KBShare.h"

@interface KBRankDetailViewController ()<WKNavigationDelegate,UIActionSheetDelegate>
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,copy) NSString *shareUrl;
@property (nonatomic,copy) NSString *startDate;
@property (nonatomic,copy) NSString *endDate;
@end

@implementation KBRankDetailViewController
- (instancetype)initTotal:(NSInteger)index startDate:(NSString *)date endDate:(NSString *)endDate
{
    self = [super init];
    if (!self) return nil;
    self.index = index;
    self.startDate = date;
    self.endDate = endDate;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (self.index == 0) {
        [self setCustomTitle:@"成交业绩榜"];
    }
    else if (self.index == 1)
    {
        [self setCustomTitle:@"成交边数榜"];
    }
    else if (self.index == 2)
    {
         [self setCustomTitle:@"新房成交榜"];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.ct_width, self.view.ct_height-self.navigationController.navigationBar.ct_height-[[UIApplication sharedApplication] statusBarFrame].size.height)];
    [self.view addSubview:webView];
    webView.navigationDelegate = self;
    
    if (self.startDate) {
        if (self.startDate.length > 7) {
            self.startDate = [self.startDate substringToIndex:7];
        }
       NSString *url = [NSString stringWithFormat:@"%@%@/achievement_ranking?type=%ld&userid=%@&datefw=%@",httpApi,httpFilePath,self.index+1,[KBUserInfoModel encodeUid], self.startDate];
         self.shareUrl = url;
    }
    else
    {
        NSString *url = [NSString stringWithFormat:@"%@%@/achievement_ranking?type=%ld&userid=%@",httpApi,httpFilePath,self.index+1,[KBUserInfoModel encodeUid]];
        self.shareUrl = url;
    }
 
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.shareUrl]]];
    
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame =CGRectMake(0,0, 22, 22);
    [rightBut setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(onClickRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightButItem = [[UIBarButtonItem alloc]initWithCustomView:rightBut];
    self.navigationItem.rightBarButtonItem = rightButItem;
    
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL absoluteString];
    NSString * date = @"";
    if ([scheme containsString:@"achievement_ranking_history"]) {
        
       
//        NSString * lowquantificationrid = @"";
        NSArray *array = [scheme componentsSeparatedByString:@"?"];
        if (array.count >= 2) {
            NSString *parameters = [array objectAtIndex:1];
            NSArray *arr1 = [parameters componentsSeparatedByString:@"&"];
            for (NSInteger i = 0; i < arr1.count; i++) {
                NSString *subParameters = [arr1 objectAtIndex:i];
                NSArray *arr2 = [subParameters componentsSeparatedByString:@"="];
                if (arr2.count == 2&& i==0) {
                    date = [arr2 objectAtIndex:1];
                }
            }
        }
       
        date = [self URLDecodedString:date];
        KBRankLastViewController *vc = [[KBRankLastViewController alloc]initTotal:self.index month:date];
        [self.navigationController pushViewController:vc animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(NSString*)URLDecodedString:(NSString*)str

{
    
    NSString*decodedString=(__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
    
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
    NSString *type = @"";
    if (self.index == 0) {
        type = @"成交业绩榜";
    }
    else if (self.index == 1)
    {
        type = @"成交边数榜";
    }
    else if (self.index == 2)
    {
        type = @"新房成交榜";
    }
    
    NSString *month = @"";
    if (self.startDate) {
        month = [self.startDate substringFromIndex:self.startDate.length - 2];
    } else {
        month = [[self getMonth] substringFromIndex:[self getMonth].length - 2];
        self.shareUrl = [self.shareUrl stringByAppendingFormat:@"&datefw=%@", [self getMonth]];
    }
    
    
    if (buttonIndex == 0) {
        [KBShare shareScene:0 title:[NSString stringWithFormat:@"我正在看%@月%@", month, type] url:self.shareUrl content:@"每月都有更新，权威发布，酷BOSS @你" imgurl:@""];
    }
    else if(buttonIndex == 1){
        [KBShare shareScene:1 title:[NSString stringWithFormat:@"我正在看%@月%@", month, type] url:self.shareUrl content:@"每月都有更新，权威发布，酷BOSS @你" imgurl:@""];
    }
    
}

- (NSString *)getMonth {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    [lastMonthComps setMonth:-1];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    return [formatter stringFromDate:newdate];
}


@end
