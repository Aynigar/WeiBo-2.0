//
//  UIWindow+Extesion.m
//  微博2.0
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "UIWindow+Extesion.h"
#import "TabBarController.h"
#import "NewfeatureController.h"

@implementation UIWindow (Extesion)
- (void)switchRootViewController
{
    //上一次版本号
    NSString *key = @"CFBundleVersion";
    NSString *lastVerson = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    //获取当前版本号
    NSString *currentVerson = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVerson isEqualToString:lastVerson]) {
        self.rootViewController = [[TabBarController alloc]init];
    }else{
        self.rootViewController = [[NewfeatureController alloc]init];
        //存入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVerson forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
@end
