//
//  LocalViewControlle.m
//  MarkDownDemo
//
//  Created by 杨晴贺 on 2017/5/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "LocalViewControlle.h"
#import "SIMarkdownView.h"

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
    [self.view addSubview:markdownView] ;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sample" ofType:@"md"] ;
    NSError *error ;
    NSString *markStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error] ;
    if (!error) {
        [markdownView loadMarkdownString:markStr] ;
    }
}


@end
