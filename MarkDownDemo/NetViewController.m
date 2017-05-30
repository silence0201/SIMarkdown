//
//  NetViewController.m
//  MarkDownDemo
//
//  Created by 杨晴贺 on 2017/5/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "NetViewController.h"
#import "SIMarkdownView.h"
#import <WebKit/WebKit.h>

@interface NetViewController ()

@end

@implementation NetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SIMarkdownView *markdownView = [[SIMarkdownView alloc] initWithFrame:self.view.bounds] ;
    markdownView.scrollEnabled = YES ;
    markdownView.showsScrollIndicator = NO ;
    markdownView.renderedAction = ^(CGFloat height) {
        NSLog(@"Height:%lf",height) ;
    } ;
    self.automaticallyAdjustsScrollViewInsets = NO ;
    [self.view addSubview:markdownView] ;
    [markdownView loadMarkdownURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/matteocrippa/awesome-swift/master/README.md"]withSuccess:^(SIMarkdownView *markView, NSData *data) {
        markdownView.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0) ;
        NSString *markdown = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
        NSLog(@"%@",markdown) ;
    }];
}

@end
