//
//  KBWebView.m
//  test
//
//  Created by yuyang on 2018/5/31.
//  Copyright © 2018年 shareit. All rights reserved.
//

#import "KBWebView.h"
#import "KBLoopProgressView.h"
@interface KBWebView ()<WKNavigationDelegate>
@property (nonatomic,strong)WKWebView * webView;
@property (nonatomic, strong) KBLoopProgressView *loopProgressView;

@end
@implementation KBWebView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    [self setup];
    return self;
}

- (void)setup
{
    self.webView = [[WKWebView alloc]initWithFrame:self.bounds];
    self.webView.navigationDelegate = self;
    [self addSubview:self.webView];
    self.loopProgressView = [[KBLoopProgressView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [self addSubview:self.loopProgressView];
    self.loopProgressView.arcFinishColor = kMainColor;
    self.loopProgressView.arcUnfinishColor = kMainColor;
    self.loopProgressView.center = CGPointMake(self.ct_width/2, self.ct_height/2);
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.loopProgressView.percent = self.webView.estimatedProgress;
        NSLog(@"%f",self.webView.estimatedProgress);
        if (self.loopProgressView.percent == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                  self.loopProgressView.hidden = YES;
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.loopProgressView.hidden = NO;
    [self bringSubviewToFront:self.loopProgressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {

    self.loopProgressView.hidden = YES;

}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    NSString *schemeString = [URL absoluteString];
    if (self.delegate && [self.delegate respondsToSelector:@selector(webView:decidePolicyForUrl:decisionHandler:)]){
        BOOL isFinsih  = [self.delegate webView:webView decidePolicyForUrl:schemeString decisionHandler:decisionHandler];
        if (!isFinsih) {
            return;
        }
        
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)loadRequestUrl:(NSString *)fileUrl
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:fileUrl]]];
    self.currentUrl = fileUrl;
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);

}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);

}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSLog(@"%s", __func__);
}

@end
