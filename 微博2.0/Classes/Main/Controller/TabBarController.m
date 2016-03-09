//
//  TabBarController.m
//  微博2.0
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"
#import "MessageCenterViewController.h"
#import "DiscoverViewController.h"
#import "ProdfileViewController.h"
#import "NavigationController.h"
#import "ComposeController.h"
#import "LSTabBar.h"

//随机色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
//RGB颜色
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface TabBarController ()<LSTabBarDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HomeViewController *homeVc = [[HomeViewController alloc]init];
    [self addChildVc:homeVc title:@"首页" image:@"tabbar_home" SelectImage:@"tabbar_home_selected"];
    
    MessageCenterViewController *messageVc = [[MessageCenterViewController alloc]init];
    [self addChildVc:messageVc title:@"消息" image:@"tabbar_message_center" SelectImage:@"tabbar_message_center_selected"];
    
    DiscoverViewController *discoverVc = [[DiscoverViewController alloc]init];
    [self addChildVc:discoverVc title:@"发现" image:@"tabbar_discover" SelectImage:@"tabbar_discover_selected"];
    
    ProdfileViewController *prodfileVc = [[ProdfileViewController alloc]init];
    [self addChildVc:prodfileVc title:@"我" image:@"tabbar_profile" SelectImage:@"tabbar_profile_selected"];
    
    //2,添加一个控制器到tabbar
    //碰到只读属性，可以更改内部属性的成员变量，可以利用KVC，换掉系统自带某个属性，也就是说可以随意修改一个对象或者成员变量
    //forKeyPath可以利用.运算符，就可以一层一层往下查找对象的属性
    
//    self.tabBar = [[LSTabBar alloc]init];
    LSTabBar *tabBar = [[LSTabBar alloc]init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
   
    //如果把 tabBar.delegate = self;放最后写，会报如下错误，因为系统不允许修改tabbar这个属性
   // reason: 'Changing the delegate of a tab bar managed by a tab bar controller is not allowed.'
    
    //    Person *p = [[Person alloc]init];
    //    p.name = @"Jack";
    //    相当于
    //    [p setValue:@"Jack" forKeyPath:@"name"];
    
    //多了一个控制器，浪费对象
    //[self addChildViewController:[[UIViewController alloc]init]];
    
}


- (void)addChildVc:(UIViewController *)ChildVc title:(NSString *)title image:(NSString *)image SelectImage:(NSString *)SelectImage
{
    //设置控制器文字和图片
    ChildVc.tabBarItem.title = title;
    ChildVc.tabBarItem.image = [UIImage imageNamed:image];
    ChildVc.navigationItem.title = title;
    ChildVc.tabBarItem.selectedImage = [[UIImage imageNamed:SelectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = Color(123, 123, 123);
    NSMutableDictionary *SelecttextAttrs = [NSMutableDictionary dictionary];
    SelecttextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [ChildVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [ChildVc.tabBarItem setTitleTextAttributes:SelecttextAttrs forState:UIControlStateSelected];
    //ChildVc.view.backgroundColor = RandomColor;
    
    //包装一个导航控制器
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:ChildVc];
    //添加子控制器
    [self addChildViewController:nav];
    
}

#pragma mark LSTabBarDelegate代理方法
- (void)tabBarDidClickPlusButton:(LSTabBar *)tabBar
{
    ComposeController *vc = [[ComposeController alloc]init];
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
