//
//  DropDownMenu.h
//  微博2.0
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  DropDownMenu;

@protocol DropDownMenuDelegate <NSObject>

@optional
- (void)dropDownMenuDissmiss:(DropDownMenu *)menu;
- (void)dropDownMenuShow:(DropDownMenu *)menu;
@end

@interface DropDownMenu : UIView

@property (nonatomic,weak) id<DropDownMenuDelegate> delegate;

/**将来用来显示具体内容的容器*/
@property (nonatomic,weak) UIImageView *containerView;
/**将来用来显示具体内容的容器控制器*/
@property (nonatomic,strong) UIViewController *contentController;
/**内容*/
@property (nonatomic,strong)  UIView *content;

+ (instancetype)menu;
//显示
- (void)showFrom:(UIView*)from;
//销毁
- (void)dismiss;


@end
