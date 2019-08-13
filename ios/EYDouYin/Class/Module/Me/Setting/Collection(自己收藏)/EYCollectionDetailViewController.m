//
//  EYCollectionDetailViewController.m
//  EYDouYin
//
//  Created by 李二洋 on 2018/11/2.
//  Copyright © 2018年 李二洋. All rights reserved.
//

#import "EYCollectionDetailViewController.h"
#import <WebKit/WebKit.h>

@interface EYCollectionDetailViewController () <WKNavigationDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) WKWebView *webView;

@end

@implementation EYCollectionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"self.content_url-----%@", self.localUseModel.content_url);

//    NSHTTPCookie *cookieWID = [NSHTTPCookie cookieWithProperties:[NSDictionary dictionaryWithObjectsAndKeys: @"wid" ,NSHTTPCookieName, WID,NSHTTPCookieValue, @"www.google.com",NSHTTPCookieDomain, @"",NSHTTPCookiePath, @"false",@"HttpOnly", nil]];

    self.gk_navTitle = self.localUseModel.title;
    
    WKWebViewConfiguration*config = [[WKWebViewConfiguration alloc]init];
    config.selectionGranularity = WKSelectionGranularityCharacter;
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight) configuration:config];
    webView.navigationDelegate = self;
    webView.scrollView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.self.localUseModel.content_url]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    self.webView = webView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - WKNavigationDelegate

/**
 网页即将开始加载

 @param webView 需要加载的网页
 @param navigationAction 导航触发
 @param decisionHandler 决定回调
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    WKNavigationActionPolicy policy = WKNavigationActionPolicyCancel;
    if (webView && [webView.URL.absoluteString isEqualToString:self.localUseModel.content_url]) {
         policy = WKNavigationActionPolicyAllow;
    }
    EYLog(@"网页即将开始加载-->%@", navigationAction);
    //这句是必须加上的，不然会崩溃
    decisionHandler(policy);
}

/**
 已经开始开始加载

 @param webView 网页
 @param navigation 导航
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    EYLog(@"已经开始开始加载--%@", navigation);
}

/**
 在收到响应后,决定是否跳转,是否把这个链接加载到webView 上

 @param webView 网页
 @param navigationResponse 导航响应描述信息
 @param decisionHandler 决定回调
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler  {
    EYLog(@"在收到响应后,决定是否跳转,是否把这个链接加载到webView 上-->%@", navigationResponse);
    WKNavigationResponsePolicy policy = WKNavigationResponsePolicyCancel;
    if (webView && [webView.URL.absoluteString isEqualToString:self.localUseModel.content_url]) {
        policy = WKNavigationResponsePolicyAllow;
    }
    decisionHandler(policy);
}

/**
 当内容开始返回时,服务器已经开始向客户端发送网页数据

 @param webView 网页
 @param navigation 导航
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    EYLog(@"当内容开始返回时,服务器已经开始向客户端发送网页数据-->%@", navigation);
}

/**
 网页加载完成之后 (JS注入)

 @param webView 网页
 @param navigation 导航
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    EYLog(@"网页加载完成之后 (JS注入)-->%@", navigation);
    [webView evaluateJavaScript:@"" completionHandler:^(id _Nullable response, NSError * _Nullable error) {

    }];
}

/**
 网页加载失败

 @param webView 网页
 @param navigation 导航
 @param error 错误信息
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    EYLog(@"网页加载失败-->%@", navigation);
}

/**
 已经收到了服务器从定向为临时导航
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    EYLog(@"已经收到了服务器从定向为临时导航-->%@", navigation);
}

/**
 网页加载失败

 @param webView 网页
 @param navigation 导航
 @param error 错误信息
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    EYLog(@"网页加载失败-->%@", navigation);
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
