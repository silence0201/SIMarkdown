# SIMarkdown


![Language](https://img.shields.io/badge/language-objc-orange.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)  

利用WKWebView实现简单的Markdown数据解析,核心利用了bootstrap进行解析

### 导入
将项目中`MarkdownView`文件夹拖到项目里 

或者使用`Pod`安装

	pod 'SIMarkdown', '~> 1.0'	
	
### 使用
1. 导入头文件

	```objective-c
	#import "MediaMetaManager.h"
	```
	
2. 初始化

	```objective-c
    SIMarkdownView *markdownView = [[SIMarkdownView alloc] initWithFrame:self.view.bounds] ;
    markdownView.scrollEnabled = YES ;  // 是否可以滑动
    markdownView.showsScrollIndicator = NO ;  // 是否显示滑动指示器
	```
	
3. 根绝需求设置回调

	```objective-c
    markdownView.renderedAction = ^(CGFloat height) {
        NSLog(@"Height:%lf",height) ;
    } ;   // 获取结果回调
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
    } ; // 捕捉点击回调
	```
	
4. 加载本地markdown字符串

	```objective-c
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Sample" ofType:@"md"] ;
    NSError *error ;
    NSString *markStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error] ;
    if (!error) {
        [markdownView loadMarkdownString:markStr] ;
    }
	```
	
5. 加载网络markdown资源

	```objective-c
    [markdownView loadMarkdownURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/matteocrippa/awesome-swift/master/README.md"]withSuccess:^(SIMarkdownView *markView, NSData *data) {
        markdownView.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0) ;
        NSString *markdown = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] ;
        NSLog(@"%@",markdown) ;
    }];
	```
	
### 要求
iOS 8 or later.
	
## SIMarkdown

[bootstrap](http://getbootstrap.com/) is licensed under [MIT license](https://github.com/twbs/bootstrap/blob/v4-dev/LICENSE).  

SIMarkdown is available under the MIT license. See the LICENSE file for more info.
