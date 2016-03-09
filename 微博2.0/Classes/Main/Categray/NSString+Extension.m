//
//  NSString+Extension.m
//  微博2.0
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithText:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(UIFont *)font
{
    return [self sizeWithText:font maxW:MAXFLOAT];
}
@end
