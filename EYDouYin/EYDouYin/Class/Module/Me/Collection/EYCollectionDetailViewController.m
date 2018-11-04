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

//    self.naviBar.hidden = NO;

    NSLog(@"2222-%@", self.content_url);

//    NSHTTPCookie *cookieWID = [NSHTTPCookie cookieWithProperties:[NSDictionary dictionaryWithObjectsAndKeys: @"wid" ,NSHTTPCookieName, WID,NSHTTPCookieValue, @"www.google.com",NSHTTPCookieDomain, @"",NSHTTPCookiePath, @"false",@"HttpOnly", nil]];

    WKWebViewConfiguration*config = [[WKWebViewConfiguration alloc]init];
    config.selectionGranularity = WKSelectionGranularityCharacter;
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, EYStatusBarAndNaviBarHeight, EYScreenWidth, EYScreenHeight - EYStatusBarAndNaviBarHeight) configuration:config];
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
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler {
//    NSLog(@"111111111111111111--%@", webView.URL);
//    decisionHandler(WKNavigationActionPolicyAllow);
//}

- (void)dealloc {
    self.webView = nil;
}

@end
