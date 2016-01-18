//
//  OAuthViewController.m
//  微博
//
//  Created by llairen on 15/11/5.
//  Copyright © 2015年 llairen. All rights reserved.
//

#import "OAuthViewController.h"

#import "OAuthTool.h"
#import "WBAccountTool.h"

#import "MJExtension.h"


#define AppKye @"3807872977"
#define AppSecret @"6c1968be8eaaf06f7b0d9ce70185c1eb"
#define Redirect_uri @"http://user.qzone.qq.com/793190036/main"
@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView * webView=[[UIWebView alloc]init];
    webView.delegate=self;
    webView.frame=self.view.bounds;
    
    NSURL * url=[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3807872977&redirect_uri=http://user.qzone.qq.com/793190036/main&response_type=code"];
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断url 加载code的url
    NSString * url=request.URL.absoluteString;
    NSRange range=[url rangeOfString:@"code="];
    if (range.length!=0)
    {
        long index=range.location+range.length;
        NSString * code=[url substringFromIndex:index];
        [self accessTokenWithCode:code];
    }
    return YES;
}
-(void)accessTokenWithCode:(NSString *)code
{
     //1.封装参数
//    NSMutableDictionary *parame=[NSMutableDictionary dictionary];
//    parame[@"client_id"]=AppKye;
//    parame[@"client_secret"]=AppSecret;
//    parame[@"grant_type"]=@"authorization_code";
//    parame[@"code"]=code;
//    parame[@"redirect_uri"]=Redirect_uri;
    
    OAuthParmaModel * parma=[[OAuthParmaModel alloc]init];
    parma.client_id=AppKye;
    parma.client_secret=AppSecret;
    parma.grant_type=@"authorization_code";
    parma.code=code;
    parma.redirect_uri=Redirect_uri;
    [OAuthTool oauthWithParma:parma success:^(OAuthResultModel *result) {
        NSDictionary * dic=result.mj_keyValues;
        WBAccount *account=[WBAccount accountWithDict:dic];
                //存帐号到沙盒
        [WBAccountTool saveAccount:account];
        
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
       
    }];
//    [HttpTool postWithUrl:@"https://api.weibo.com/oauth2/access_token" parmar:parame success:^(id json) {
//        //字典转模型
//        WBAccount *account=[WBAccount accountWithDict:json];
//        //存帐号到沙盒
//        [WBAccountTool saveAccount:account];
//        
//        UIWindow *window=[UIApplication sharedApplication].keyWindow;
//        [window switchRootViewController];
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUD];
//        NSLog(@"请求失败==%@",error);
//    }];

}




@end
