//
//  Status.m
//  微博2.0
//
//  Created by apple on 16/1/27.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "Status.h"
#import "Photo.h"
#import "MJExtension.h"
#import "NSDate+Extension.h"

@implementation Status

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls" : [Photo class]};
}

- (NSString *)created_at
{
    //Thu Feb 04 20:30:08 +0800 2016
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createdTime = [fmt dateFromString:_created_at];
    
    NSDate *now = [NSDate date];
    NSCalendar *canlendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit =  NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|  NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *comps =  [canlendar components:unit fromDate:createdTime toDate:now options:0];
    
    if ([createdTime isThisYear]) {
        if ([createdTime isYestaday]) {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createdTime];
            
        }else if ([createdTime isThisDay]){
            if (comps.hour >=1) {
                return [NSString stringWithFormat:@"%ld小时前",(long)comps.hour];
            }else if (comps.minute >=1){
                return [NSString stringWithFormat:@"%ld分钟前",(long)comps.minute];
            }else{
                return @"刚刚";
            }
        }else{
            //其他日子
            NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
            fmt.dateFormat = @"MM:dd HH:mm";
            return [fmt stringFromDate:createdTime];
        }
            
    }else{
        //非今年
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdTime];
    }
   
    return _created_at;
}

- (void)setSource:(NSString *)source
{
     //source = <a href="http://weibo.com/" rel="nofollow">iPhone 6s Plus</a>
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
   
}


//+ (instancetype)statusWithDict:(NSDictionary *)dict
//{
//    Status *status = [[self alloc]init];
//    status.idstr = dict[@"idstr"];
//    status.text = dict[@"text"];
//    status.user = [User userWithDict:dict[@"user"]];
//    return status;
//}
@end
