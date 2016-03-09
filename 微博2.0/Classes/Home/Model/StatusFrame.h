//
//  StatusFrame.h
//  微博2.0
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//  一个StatusFrame模型里面包含的所以子控件的frame数据
//  存放着一个cell所有frame数据，cell的高度，一个数据模型Status

#import <Foundation/Foundation.h>
#import "UIView+Extension.h"
// 昵称字体
#define statusCellNameLabel [UIFont systemFontOfSize:13]

// 时间字体
#define statusCellTimeLabel [UIFont systemFontOfSize:10]

// 来源字体
#define statusCellSourceLabel [UIFont systemFontOfSize:10]

// 微博正文字体
#define statusCellContentLabel [UIFont systemFontOfSize:12]

// 转发微博正文字体
#define statusCellRewteedContentLabel [UIFont systemFontOfSize:11]

// cell边距
#define statusCellBorder 10

// 底部工具条边距
#define statusCellMargin 15

@class Status;

@interface StatusFrame : NSObject
@property (nonatomic,strong)  Status *status;

/** 原创微博*/
@property (nonatomic,assign) CGRect originalViewF;

/** 用户头像*/
@property (nonatomic,assign) CGRect iconViewF;

/** 会员图标*/
@property (nonatomic,assign) CGRect vipViewF;

/** 原创微博配图*/
@property (nonatomic,assign) CGRect photoViewF;

/** 昵称*/
@property (nonatomic,assign) CGRect nameLabelF;

/** 微博来源*/
@property (nonatomic,assign) CGRect sourceLabelF;

/** 微博时间*/
@property (nonatomic,assign) CGRect timeLabelF;

/** 原创微博内容*/
@property (nonatomic,assign) CGRect contentLabelF;

/** 转发微博整体*/
@property (nonatomic,assign) CGRect retweetedViewF;

/** 转发微博正文*/
@property (nonatomic,assign) CGRect retweetedContentF;

/** 转发微博配图*/
@property (nonatomic,assign) CGRect retweetedPhotoF;

/** 底部工具条*/
@property (nonatomic,assign) CGRect toolBarF;

/** cell高度*/
@property (nonatomic,assign) CGFloat cellHeight;

@end
