//
//  LSTextView.m
//  微博2.0
//
//  Created by apple on 16/2/15.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "LSTextView.h"
#import "UIView+Extension.h"
@implementation LSTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textViewDidChange
{
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
    
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.hasText) return;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = rect.size.width - 2*x;
    CGFloat h = rect.size.height - 2*y;
    
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

@end
