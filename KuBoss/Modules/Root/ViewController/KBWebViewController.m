//
//  KBWebViewController.m
//  KuBoss
//
//  Created by risenb_mac on 2018/6/26.
//  Copyright © 2018年 yuyang. All rights reserved.
//

#import "KBWebViewController.h"
#import <WebKit/WebKit.h>

@interface KBWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation KBWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WKWebView alloc] init];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
        make.left.right.equalTo(self.view);
    }];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];

//    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
//    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];

}

- (void)viewWillDisappear:(BOOL)animated {
    [self.webView removeObserver:self forKeyPath:@"title"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
//    if ([keyPath isEqualToString:@"estimatedProgress"]) {
//        if (object == self.webView) {
//            [self.progressView setAlpha:1.0f];
//            [self.progressView setProgress:self.currentSubView.webView.estimatedProgress animated:YES];
//
//            if(self.currentSubView.webView.estimatedProgress >= 1.0f) {
//
//                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                    [self.progressView setAlpha:0.0f];
//                } completion:^(BOOL finished) {
//                    [self.progressView setProgress:0.0f animated:NO];
//                }];
//
//            }
//        }
//        else
//        {
//            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//        }
//    }else
    if ([keyPath isEqualToString:@"title"]){
        if (object == self.webView) {
            self.navigationItem.title = self.webView.title;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
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
