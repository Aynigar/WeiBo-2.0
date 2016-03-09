//
//  User.m
//  微博2.0
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "User.h"

@implementation User

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    self.vip = mbtype >2;
}

//+ (instancetype)userWithDict:(NSDictionary *)dict
//{
//    User *user = [[self alloc]init];
//    user.idstr = dict[@"idstr"];
//    user.name = dict[@"name"];
//    user.profile_image_url = dict[@"profile_image_url"];
//    return user;
//}

@end
