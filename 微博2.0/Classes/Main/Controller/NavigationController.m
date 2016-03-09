//
//  NavigationController.m
//  微博2.0
//
//  Created by apple on 16/1/16.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "NavigationController.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"

@implementation NavigationController

//设置item整体统一的风格样式
+ (void)initialize
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    NSMutableDictionary *disableAttrs = [NSMutableDictionary dictionary];
    disableAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    disableAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    [item setTitleTextAttributes:disableAttrs forState:UIControlStateDisabled];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" imageHighlighted:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" imageHighlighted:@"navigationbar_more_highlighted"];
    }
    [super pushViewController:viewController animated:animated];

}

#warning 不能是self.NavigationController
//因为self本身就是一个导航控制器
- (void)back
{
    //回到上一层控制器
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    //回到最顶层控制器
    [self popToRootViewControllerAnimated:YES];
}

//设置尺寸
//    CGSize size = leftBtn.currentBackgroundImage.size;原始方法
//    leftBtn.frame = CGRectMake(0, 0, size.width, size.height);
@end
