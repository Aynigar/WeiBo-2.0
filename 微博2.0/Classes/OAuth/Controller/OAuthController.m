//
//  OAuthController.m
//  微博2.0
//
//  Created by apple on 16/1/24.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "OAuthController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "AccountTool.h"
#import "UIWindow+Extesion.h"

@implementation OAuthController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1,创建一个UIWebView
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    /**请求参数
     client_id:申请应用时分配的AppKey
     redirect_ui:授权成功的回调地址
     */
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1450996186&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载数据..."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //1,获取url
    NSString *url = request.URL.absoluteString;
    //2,判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        [self accessTokenWith:code];
        return NO;
    }
    return  YES;
}

- (void)accessTokenWith:(NSString *)code
{
    //利用code换取Accesstoken
    AFHTTPSessionManager *mng = [AFHTTPSessionManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
#error 请输入自己的client_id和client_secret
    params[@"client_id"] = @"";
    params[@"client_secret"] = @"";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://www.baidu.com";
    params[@"code"] = code;
    
    [mng POST:@"https://api.weibo.com/oauth2/access_token" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
     
        //将返回的账号字典数据转成模型，存入沙盒
        Account *account = [Account accountWithDictionary:responseObject];
        [AccountTool saveAccount:account];
        
        //切换根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
        }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            NSLog(@"请求失败-%@",error);
    }];
   
}

@end
