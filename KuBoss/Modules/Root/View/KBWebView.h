//
//  KBWebView.h
//  test
//
//  Created by yuyang on 2018/5/31.
//  Copyright © 2018年 shareit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol KBWebViewDelegate<NSObject>

@optional

- (BOOL)webView:(WKWebView *)webView decidePolicyForUrl:(NSString *)url decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;

@end

@interface KBWebView : UIView

@property (nonatomic,weak) id <KBWebViewDelegate> delegate;

@property (nonatomic, copy) NSString *currentUrl;

- (void)loadRequestUrl:(NSString *)fileUrl;

@end

