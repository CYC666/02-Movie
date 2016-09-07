//
//  WordTypeViewController.m
//  Movie
//
//  Created by CYC on 16/4/26.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "WordTypeViewController.h"
#import "JSONObject.h"

@interface WordTypeViewController () <UIWebViewDelegate> {

    UIActivityIndicatorView *_activityIndicatorView;

}

@end

@implementation WordTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     "title" : "\"银河护卫队\"库珀配音浣熊 灭霸成反派幕后首脑",
     "content" :
     "time" : "2013-8-31 15:01:54",
     "source" : "Mtime时光网",
     "author" : "gmzyq 哈麦",
     */
    //解析数据
    NSDictionary *newsWebData = [JSONObject loadData:@"news_detail"];
    NSString *title = newsWebData[@"title"];
    NSString *content = newsWebData[@"content"];
    NSString *author = newsWebData[@"author"];
    NSString *source = newsWebData[@"source"];
    NSString *time = newsWebData[@"time"];
    //将来源和年份整合一下
    NSString *timeSource = [NSString stringWithFormat:@"年份是%@,来源是%@",time,source];
    
    //这个页面显示的是一个从本地加载的网页数据
    //这个 html 他的结构是本地的,里面的数据数网络的
    
    //从本地加载 html 数据
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"news.html" ofType:nil];
    NSString *newsHtmlString = [NSString stringWithContentsOfFile:pathString
                                                         encoding:NSUTF8StringEncoding
                                                            error:nil];
    //将 html 的数据(html 的结构)和 html 中需要展示的内容进行合并
    NSString *htmlString = [NSString stringWithFormat:newsHtmlString,title,content,author,timeSource];
    //newsHtmlString本身就包含了%@，其他几个字符串对象相应的入座
    
    //创建网页视图
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - NavigationBarHeight)];
    webView.scalesPageToFit = YES;//网页视图自适应
    webView.delegate = self;        //设置代理
    [self.view addSubview:webView];
    
    //网页视图加载 html 格式的字符串,并且进行显示
    [webView loadHTMLString:htmlString baseURL:nil];
    
    //旋转木马 加载
    _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *activityItem = [[UIBarButtonItem alloc]initWithCustomView:_activityIndicatorView];
    self.navigationItem.rightBarButtonItem = activityItem;
}

//网页正在加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    //开始旋转木马
    [_activityIndicatorView startAnimating];
}
//网页加载完毕
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //停止旋转，消失
    [_activityIndicatorView stopAnimating];
}












@end
