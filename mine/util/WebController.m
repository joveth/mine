//
//  WebController.m
//  IsaacNew
//
//  Created by Shuwei on 15/9/14.
//  Copyright (c) 2015年 jov. All rights reserved.
//

#import "WebController.h"
#import "ShareData.h"
#import "MBProgressHUD.h"

@interface WebController ()<UIWebViewDelegate>

@end

@implementation WebController{
    UIWebView *webview;
    MBProgressHUD *HUD;
    NSURLRequest *req;
    NSString *html;
    NSURL *baseURL ;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"加载中...";
    [HUD show:YES];
    NSString *path = [[NSBundle mainBundle] pathForResource:[ShareData shareInstance].html ofType:@"html"];
    html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    //self.title=[ShareData shareInstance].title;
    NSURL *url = [NSURL URLWithString:[ShareData shareInstance].urltype];
    req = [NSURLRequest requestWithURL:url];
    webview.delegate=self;
    [self.view addSubview:webview];
    
    self.view.backgroundColor=[UIColor whiteColor];
    if([ShareData shareInstance].urltype){
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:self action:@selector(toView)];
    backItem.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=backItem;
    }
}
-(void)toView{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    backItem.tintColor=[UIColor whiteColor];
    [self.navigationItem setBackBarButtonItem:backItem];
    ViewController *show = [[ViewController alloc] init];
    [self.navigationController pushViewController:show animated:YES];

}

-(void)viewDidAppear:(BOOL)animated{
    if([ShareData shareInstance].urltype){
        [webview loadRequest:req];
    }else{
        [webview loadHTMLString:html baseURL:baseURL];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [HUD hide:YES];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [HUD hide:YES];
}

@end
