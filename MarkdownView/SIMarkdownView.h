//
//  SIMarkdownView.h
//  MarkDownDemo
//
//  Created by Silence on 2017/5/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKWebView,SIMarkdownView ;

typedef BOOL(^SILinkBlock)(NSURLRequest *request);
typedef void(^SIRenderedBlock)(CGFloat height);
typedef void(^SISuccessBlock)(SIMarkdownView *markView,NSData *data);

@interface SIMarkdownView : UIView

/// 用来解析的WebView,必须先调用loadMarkdown方法初始化
@property (nonatomic,strong,readonly) WKWebView *webView ;

/// 是否开启滑动
@property (nonatomic,assign,getter=isScrollEnabled) BOOL scrollEnabled ;
/// 是否显示滑动指示器
@property (nonatomic,assign,getter=isShowsScrollIndicator) BOOL showsScrollIndicator ;

/// 是否拦截点击事件
@property (nonatomic,copy) SILinkBlock linkTouchAction ;
/// 当获取内容长度时候回调
@property (nonatomic,copy) SIRenderedBlock renderedAction ;


/**
 加载Markdown字符串

 @param markdown markdown字符串
 */
- (void)loadMarkdownString:(NSString *)markdown ;


/**
 加载URL对应的Markdown资源

 @param url markdown资源URL地址
 @param block 加载成功后回调
 */
- (void)loadMarkdownURL:(NSURL *)url withSuccess:(SISuccessBlock)block;

@end
