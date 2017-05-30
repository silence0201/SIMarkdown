//
//  LocalViewControlle.m
//  MarkDownDemo
//
//  Created by Silence on 2017/5/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "LocalViewControlle.h"
#import "SIMarkdownView.h"
#import <SafariServices/SafariServices.h>

@interface LocalViewControlle ()

@end

@implementation LocalViewControlle

- (void)viewDidLoad {
    [super viewDidLoad];
    SIMarkdownView *markdownView = [[SIMarkdownView alloc] initWithFrame:self.view.bounds] ;
    markdownView.scrollEnabled = YES ;
    markdownView.showsScrollIndicator = NO ;
    markdownView.renderedAction = ^(CGFloat height) {
        NSLog(@"Height:%lf",height) ;
    } ;
    markdownView.linkTouchAction = ^BOOL(NSURLRequest *request) {
        NSURL *url = request.URL ;
        if (url) {
            if ([url.scheme isEqualToString:@"file"]) {
                return true ;
            }else if ([url.scheme isEqualToString:@"https"] || [url.scheme isEqualToString:@"http"]) {
                SFSafariViewController *sfvc = [[SFSafariViewController alloc]initWithURL:url] ;
                [self.navigationController pushViewController:sfvc animated:YES] ;
                return false ;
            }
        }
        return false ;
    } ;
    [self.view addSubview:markdownView] ;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sample" ofType:@"md"] ;
    NSError *error ;
    NSString *markStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error] ;
    if (!error) {
        [markdownView loadMarkdownString:markStr] ;
    }
}


@end
