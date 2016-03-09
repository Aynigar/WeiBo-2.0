//
//  UIBarButtonItem+Extension.m
//  微博2.0
//
//  Created by apple on 16/1/17.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image imageHighlighted:(NSString *)imageHighlighted
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imageHighlighted] forState:UIControlStateHighlighted];
    
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
