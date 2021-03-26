//
//  WKWebViewVCViewController.m
//  OCClass
//
//  Created by mac on 2021/3/9.
//

#import "WKWebViewVCViewController.h"
#import <WebKit/WebKit.h>
#import "ScreenUtils.h"

@interface WKWebViewVCViewController ()<WKNavigationDelegate>

@property(nonatomic, strong, readwrite) WKWebView *webView;
@property(nonatomic, strong, readwrite) UIProgressView *progressView;
@property(nonatomic, copy, readwrite) NSString *articleUrl;

@end

@implementation WKWebViewVCViewController

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if (self) {
        _articleUrl = urlString;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:({
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 44, self.view.frame.size.width, self.view.frame.size.height - STATUS_BAR_HEIGHT - 44)];
        self.webView;
    })];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_articleUrl]]];
    self.webView.navigationDelegate = self;
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:({
        self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 44, self.view.frame.size.width, 10)];
        self.progressView;
    })];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
    NSLog(@"decidePolicyForNavigationAction");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    self.progressView.progress = self.webView.estimatedProgress;
    NSLog(@"progress %f", self.webView.estimatedProgress);
}

@end
