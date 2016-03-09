//
//  NSDate+Extension.m
//  微博2.0
//
//  Created by apple on 16/2/12.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *datecomps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowcomps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return datecomps.year == nowcomps.year;
}

- (BOOL)isThisDay
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [fmt stringFromDate:now];
    NSString *dateStr = [fmt stringFromDate:self];
    
    return [nowStr isEqualToString:dateStr];
}

- (BOOL)isYestaday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:unit fromDate:date toDate:now options:0];
    return comps.year ==0 && comps.month ==0 && comps.day == 1;
    
    return YES;
}
@end
