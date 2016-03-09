//
//  TittleButton.m
//  微博2.0
//
//  Created by apple on 16/1/26.
//  Copyright © 2016年 neusoft. All rights reserved.
//

#import "TittleButton.h"
#import "UIView+Extension.h"

@implementation TittleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.imageView.backgroundColor = [UIColor clearColor];
        

    }
    return self;
}

// 想在系统计算和设置按钮的尺寸后，再修改一下尺寸
/**
 *  重写setFrame方法的目的：拦截设置尺寸的过程
 *
 *  @param frame frmae
 */
//- (void)setFrame:(CGRect)frame
//{
//    frame.size.width += 10;
//    [super setFrame:frame];
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //1,设置title位置
    self.titleLabel.x = self.imageView.x;
    //2,设置image位置
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);

}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}


@end
