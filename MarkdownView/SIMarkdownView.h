//
//  SIMarkdownView.h
//  MarkDownDemo
//
//  Created by 杨晴贺 on 2017/5/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKWebView,SIMarkdownView ;

typedef BOOL(^SILinkBlock)(NSURLRequest *request);
typedef void(^SIRenderedBlock)(CGFloat height);
typedef void(^SISuccessBlock)(SIMarkdownView *markView,NSData *data);

@interface SIMarkdownView : UIView

@property (nonatomic,strong,readonly) WKWebView *webView ;

@property (nonatomic,assign,getter=isScrollEnabled) BOOL scrollEnabled ;
@property (nonatomic,assign,getter=isShowsScrollIndicator) BOOL showsScrollIndicator ;

@property (nonatomic,copy) SILinkBlock linkTouchAction ;
@property (nonatomic,copy) SIRenderedBlock renderedAction ;

- (void)loadMarkdownString:(NSString *)markdown ;
- (void)loadMarkdownURL:(NSURL *)url withSuccess:(SISuccessBlock)block;

@end
