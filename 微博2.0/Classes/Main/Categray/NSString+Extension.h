//
//  NSString+Extension.h
//  微博2.0
//
//  Created by apple on 16/2/1.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Extension.h"

@interface NSString (Extension)
- (CGSize)sizeWithText:(UIFont *)font;
- (CGSize)sizeWithText:(UIFont *)font maxW:(CGFloat )maxW;
@end
