//
//  Account.h
//  微博2.0
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>

/** access_token	string	用于调用access_token，接口获取授权后的access token */
@property (nonatomic,copy) NSString *access_token;

/** expires_in	string	access_token的生命周期，单位是秒数*/
@property (nonatomic,copy) NSNumber *expires_in;

/** uid	string	当前授权用户的UID*/
@property (nonatomic,copy) NSString *uid;

/** 账号创建时间*/
@property (nonatomic,strong)  NSDate *created_time;

/**  用户昵称*/
@property (nonatomic,copy) NSString  *name;

+ (instancetype)accountWithDictionary:(NSDictionary*)dic;

@end
