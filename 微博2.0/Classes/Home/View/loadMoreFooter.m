//
//  loadMoreFooter.m
//  微博2.0
//
//  Created by apple on 16/1/30.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "loadMoreFooter.h"

@implementation loadMoreFooter
+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"loadMoreFooter" owner:nil options:nil]lastObject];
}
@end
