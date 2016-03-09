//
//  StatusToolbar.h
//  微博2.0
//
//  Created by apple on 16/2/4.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;
@interface StatusToolbar : UIView
@property (nonatomic,strong)  NSMutableArray *toolBarBtn;
@property (nonatomic,strong)  NSMutableArray *divideLine;
@property (nonatomic,strong)  Status *status;

/**	转发按钮*/
@property (nonatomic,weak) UIButton *rewteedBtn;

/** 评论按钮*/
@property (nonatomic,weak)  UIButton *commentsBtn;

/** 点赞按钮*/
@property (nonatomic,weak)  UIButton *attitudesBtn;

+(instancetype)toolBar;

@end
