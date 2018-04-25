//
//  WZUIWebViewController.m
//  WZRootNavigationController
//
//  Created by 吴哲 on 2018/4/25.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

#import "WZUIWebViewController.h"

@interface WZUIWebViewController ()<UIWebViewDelegate>
/// uiWebView
@property(nonatomic ,strong) UIWebView *uiWebView;
/// activity
@property(nonatomic ,strong) UIActivityIndicatorView *activity;
@end

@implementation WZUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _uiWebView = [UIWebView new];
    _uiWebView.delegate = self;
    _uiWebView.frame = self.view.bounds;
    [self.view addSubview:_uiWebView];
    
    _activity = [UIActivityIndicatorView new];
    _activity.color = UIColor.greenColor;
    _activity.center = _uiWebView.center;
    [self.view addSubview:_activity];
    
    [_uiWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/arcangelw/WZRootNavigationController"]]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [_activity startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activity stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_activity stopAnimating];
}

@end
