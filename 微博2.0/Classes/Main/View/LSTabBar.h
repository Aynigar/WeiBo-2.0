//
//  LSTabBar.h
//  微博2.0
//
//  Created by apple on 16/1/19.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSTabBar;
@protocol LSTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPlusButton:(LSTabBar *)tabBar;
@end

@interface LSTabBar : UITabBar
@property (nonatomic,weak) id<LSTabBarDelegate> delegate;
@property (nonatomic,weak) UIButton *plusBtn;
+ (instancetype)TabBar;
@end
