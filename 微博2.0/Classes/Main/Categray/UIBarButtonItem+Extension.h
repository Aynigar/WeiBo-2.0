//
//  UIBarButtonItem+Extension.h
//  微博2.0
//
//  Created by apple on 16/1/17.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image imageHighlighted:(NSString *)imageHighlighted;
@end
