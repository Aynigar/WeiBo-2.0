//
//  LSTabBar.m
//  微博2.0
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "LSTabBar.h"
#import "UIView+Extension.h"

@implementation LSTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *plusBtn = [[UIButton alloc]init];
        //设置按钮图片
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
       
        //设置按钮尺寸
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}

- (void)plusClick
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1.设置加号按钮位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    //2.设置其他tabBarButton的位置和尺寸
    NSUInteger count = self.subviews.count;
    //遍历所有子控件，得到子控件的个数，拿到控件修改位置
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    for (int i = 0; i < count; i++) {
        UIView *child = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            //设置按钮宽度
            child.width = tabBarButtonW;
            //设置按钮X位置
            child.x = tabBarButtonIndex * tabBarButtonW;
            //增加索引
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }
}

+ (instancetype)TabBar
{
    return [[self alloc]init];
}

//    NSUInteger count = self.subviews.count;
//    for (NSUInteger i =0; i < count; i ++) {
//        UIView *btn = self.subviews[i];
//        int btnIndex = 0;
//        CGFloat W = self.width / count;
//
//        btn.width = W;
//        btn.x = btnIndex * W;
//        btnIndex++;
//        if (self.subviews.count == 2) {
//            btnIndex ++;
//        }
//    }
@end
