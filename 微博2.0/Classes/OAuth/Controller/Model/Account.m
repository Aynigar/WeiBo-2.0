//
//  Account.m
//  微博2.0
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "Account.h"

@implementation Account

+ (instancetype)accountWithDictionary:(NSDictionary *)dic
{
    Account *account = [[self alloc]init];
    account.access_token = dic[@"access_token"];
    account.expires_in = dic[@"expires_in"];
    account.uid = dic[@"uid"];
    //获取账号的存储时间
    account.created_time = [NSDate date];
    return account;
}

//当一个对象要归档进入沙盒中时，会调用这个方法
//目的：说明对象的哪些属性要存入沙盒
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
}

//当从沙盒中解档一个对象时，调用这个方法，需要取出哪些属性
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end
