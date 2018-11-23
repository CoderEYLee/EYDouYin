//
//  EYCollectionDetailViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/11/2.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYCollectionDetailViewController.h"
#import <WebKit/WebKit.h>

@interface EYCollectionDetailViewController () <WKNavigationDelegate>

@property (weak, nonatomic) WKWebView *webView;


@end

@implementation EYCollectionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"self.content_url-----%@", self.content_url);

//    NSHTTPCookie *cookieWID = [NSHTTPCookie cookieWithProperties:[NSDictionary dictionaryWithObjectsAndKeys: @"wid" ,NSHTTPCookieName, WID,NSHTTPCookieValue, @"www.google.com",NSHTTPCookieDomain, @"",NSHTTPCookiePath, @"false",@"HttpOnly", nil]];

    WKWebViewConfiguration*config = [[WKWebViewConfiguration alloc]init];
    config.selectionGranularity = WKSelectionGranularityCharacter;
    WKWebView *webView = [[WKWebView alloc] initWithFrame:EYScreenBounds configuration:config];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.content_url]];
    [self.webView loadRequest:request];
}

#pragma mark - WKNavigationDelegate

/**
 是否允许加载网页

 @param webView 需要加载的网页
 @param navigationAction 导航触发
 @param decisionHandler 决定回调
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    WKNavigationActionPolicy policy = WKNavigationActionPolicyCancel;
    if (webView && [webView.URL.absoluteString isEqualToString:self.content_url]) {
         policy = WKNavigationActionPolicyAllow;
    }
    EYLog(@"是否允许加载网页-->%@", navigationAction);
    //这句是必须加上的，不然会崩溃
    decisionHandler(policy);
}

/**
 决定是否允许或取消导航

 @param webView 网页
 @param navigationResponse 导航响应描述信息
 @param decisionHandler 决定回调
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler  {
    EYLog(@"决定是否允许或取消导航-->%@", navigationResponse);
    WKNavigationResponsePolicy policy = WKNavigationResponsePolicyCancel;
    if (webView && [webView.URL.absoluteString isEqualToString:self.content_url]) {
        policy = WKNavigationResponsePolicyAllow;
    }
    decisionHandler(policy);
}

/**
 已经开始了临时的导航

 @param webView 网页
 @param navigation 导航
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    EYLog(@"已经开始了临时的导航--%@", navigation);
}

/**
 已经收到了服务器从定向为临时导航
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    EYLog(@"已经收到了服务器从定向为临时导航-->%@", navigation);
}

/**
 临时导航已经失败

 @param webView 网页
 @param navigation 导航
 @param error 错误信息
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    EYLog(@"临时导航已经失败-->%@", navigation);
}

/**
 已经提交了导航

 @param webView 网页
 @param navigation 导航
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    EYLog(@"已经提交了导航-->%@", navigation);
}

/**
 已经结束了导航

 @param webView 网页
 @param navigation 导航
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    EYLog(@"已经结束了导航-->%@", navigation);
}

/**
 已经失败了导航

 @param webView 网页
 @param navigation 导航
 @param error 错误信息
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    EYLog(@"已经失败了导航-->%@", navigation);
}

/**
 证书验证时候调用

 @param webView 网页
 @param challenge 需要验证的信息
 @param completionHandler 决定的回调
 */
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    EYLog(@"证书验证时候调用--%@", challenge);
    completionHandler(NSURLSessionAuthChallengeUseCredential, challenge.proposedCredential);
}

/**
 网页的内容过程已经终止

 @param webView 网页
 */
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    EYLog(@"网页的内容过程已经终止--");
}

- (void)dealloc {
    self.webView = nil;
}

@end
