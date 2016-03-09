//
//  Status.h
//  微博2.0
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;

@interface Status : NSObject
/** idstr	string	字符串型的用户UID*/
@property (nonatomic,copy) NSString *idstr;

/** text	string	微博信息内容*/
@property (nonatomic,copy) NSString *text;

/**created_at	string	微博创建时间*/
@property (nonatomic,copy) NSString *created_at;

/**source	string	微博来源*/
@property (nonatomic,copy) NSString *source;

/** user object	微博作者的用户信息字段*/
@property (nonatomic,strong)  User *user;

/** pic_ids	object	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url*/
@property (nonatomic,strong)  NSArray *pic_urls;

/** retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回*/
@property (nonatomic,strong)  Status *retweeted_status;

/**reposts_count	int	转发数*/
@property (nonatomic,assign) int reposts_count;

/**comments_count	int	评论数*/
@property (nonatomic,assign) int comments_count;

/**attitudes_count	int	表态数*/
@property (nonatomic,assign) int attitudes_count;
//+ (instancetype)statusWithDict:(NSDictionary *)dict;

@end
