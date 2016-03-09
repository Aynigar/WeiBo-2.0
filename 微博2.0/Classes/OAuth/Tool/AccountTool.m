//
//  AccountTool.m
//  微博2.0
//
//  Created by apple on 16/1/25.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "AccountTool.h"

@implementation AccountTool

+ (NSString *)path
{
    //沙盒路径
    NSString *doc  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    
    NSString *path = [doc stringByAppendingPathComponent:@"account.archiver"];
    return path;
}

+ (void)saveAccount:(Account *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:[self path]];
    
}

+ (Account *)account
{
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:[self path]];
    
    return account;
}

//验证账号是否过期
//过期的秒数
//long long expires_in = [account.expires_in longLongValue];
////过期时间
//NSDate *exriresTime = [account.created_time dateByAddingTimeInterval:expires_in];
////现在时间
//NSDate *now = [NSDate date];
//
//// NSOrderedAscending = -1L,升序
//// NSOrderedSame,一样
//// NSOrderedDescending
//NSComparisonResult result = [exriresTime compare:now];
//if (result == NSOrderedAscending) {
//    return nil;
//}
@end
