//
//  SIMarkdownView.m
//  MarkDownDemo
//
//  Created by Silence on 2017/5/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "SIMarkdownView.h"
#import <WebKit/WebKit.h>

@interface SIMarkdownView ()<WKNavigationDelegate>
@end

@implementation SIMarkdownView

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled ;
    if (_webView) {
        _webView.scrollView.scrollEnabled = scrollEnabled ;
    }
}

- (void)setShowsScrollIndicator:(BOOL)showsScrollIndicator {
    _showsScrollIndicator = showsScrollIndicator ;
    if (_webView) {
        _webView.scrollView.showsVerticalScrollIndicator = showsScrollIndicator ;
    }
}

- (void)loadMarkdownURL:(NSURL *)url withSuccess:(SISuccessBlock)block{
    if ([url.scheme isEqualToString:@"file"]) {
        NSString *markdown = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil] ;
        [self loadMarkdownString:markdown] ;
    }else if ([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"]) {
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]] ;
        NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) return ;
            NSString *markdown = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
            if (markdown.length == 0)  return ;
            __weak typeof(self) weakSelf = self ;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf loadMarkdownString:markdown] ;
                block(weakSelf,data) ;
            }) ;
        }] ;
        [task resume] ;
    }
}

- (void)loadMarkdownString:(NSString *)markdown {
    if (markdown.length == 0) return ;
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]] ;
    NSURL *htmlURL  = [bundle URLForResource:@"index" withExtension:@"html" subdirectory:@"Markdown.bundle"] ;
    if (htmlURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL] ;
        NSString *escapedMarkdown = [markdown stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.alphanumericCharacterSet] ;
        NSString *script = [NSString stringWithFormat:@"window.showMarkdown('%@');",escapedMarkdown] ;
        WKUserScript *userScript = [[WKUserScript alloc] initWithSource:script injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES] ;
        WKUserContentController *controller = [[WKUserContentController alloc]init] ;
        [controller addUserScript:userScript] ;
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init] ;
        configuration.userContentController = controller ;
        
        _webView = [[WKWebView alloc]initWithFrame:self.bounds configuration:configuration] ;
        _webView.scrollView.scrollEnabled = self.isScrollEnabled ;
        _webView.scrollView.showsVerticalScrollIndicator = self.isShowsScrollIndicator ;
        _webView.navigationDelegate = self ;
        [self addSubview:_webView] ;
        _webView.backgroundColor = self.backgroundColor ;
        
        [_webView loadRequest:request] ;
        
    }
}

#pragma mark -- WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *script = @"document.body.offsetHeight;" ;
    [webView evaluateJavaScript:script completionHandler:^(id result, NSError * _Nullable error) {
        if (error) return ;
        if (self.renderedAction) {
            self.renderedAction([result floatValue]) ;
        }
    }] ;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURLRequest *request = navigationAction.request ;
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated:
            if ((self.linkTouchAction && self.linkTouchAction(request))) {
                decisionHandler(WKNavigationActionPolicyAllow) ;
            }else {
                decisionHandler(WKNavigationActionPolicyCancel) ;
            }
            break;
            
        default:
            decisionHandler(WKNavigationActionPolicyAllow) ;
            break;
    }
}

@end
